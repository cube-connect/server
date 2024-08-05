#include "DrawManager.h"

#include <imgui.h>
#include <enet/enet.h>

#include "Drawable.h"
#include "IWidget.h"
#include "ILightSource.h"
#include "../utilities/Window.h"
#include "../rendering/Cubemap.h"
#include "../cbs/components/Camera.h"

#include "../networking/client_server_shared/drawing_snapshot.hpp"
#include "cbs/components/RubiksCube/Cubie.h"

void DrawManager::Initialize() {
    // Dear imgui initialiation
    ImGui::CreateContext();
    ImGui::StyleColorsDark();
    ImGui_ImplGlfw_InitForOpenGL(g_Window, true);
    ImGui_ImplOpenGL3_Init("#version 330 core");

    // Load default font
    ImGuiIO& io = ImGui::GetIO();
    io.Fonts->AddFontDefault();

    // Create shader programs
    m_ShaderPrograms[ShaderProgram::Type::PURE_COLOR].AttachShaders("src/shaders/PURE_COLOR.vert",
                                                                    "src/shaders/PURE_COLOR.frag");


    m_ShaderPrograms[ShaderProgram::Type::PURE_TEXTURE].AttachShaders("src/shaders/PURE_TEXTURE.vert",
                                                                      "src/shaders/PURE_TEXTURE.frag");


    m_ShaderPrograms[ShaderProgram::Type::PHONG].AttachShaders("src/shaders/PHONG.vert",
                                                               "src/shaders/PHONG.frag");
    m_ShaderPrograms[ShaderProgram::Type::PHONG].Traits(ShaderProgram::Trait::LIGHT_RECEIVER);


    m_ShaderPrograms[ShaderProgram::Type::SKYBOX].AttachShaders("src/shaders/SKYBOX.vert",
                                                                "src/shaders/SKYBOX.frag");

    glEnable(GL_DEPTH_TEST);
}

void DrawManager::RegisterCamera(Camera *camera) {
    m_Camera = camera;
}

Camera* DrawManager::MainCamera() const {
    return m_Camera;
}

void DrawManager::Skybox(const std::string& right, const std::string& left, const std::string& top, const std::string& bottom, const std::string& back, const std::string& front) {
    m_Skybox = std::make_unique<Cubemap>(right, left, top, bottom, back, front, ShaderProgram::Type::SKYBOX);
}

void DrawManager::Background(const glm::vec3& background) {
    m_Background = background;
}

void DrawManager::RegisterDrawCall(Drawable* component) {
    // Ensure that each component is registered at most once
    assert(std::find(m_Drawables.begin(), m_Drawables.end(), component) == m_Drawables.end());

    m_Drawables.push_back(component);
}

void DrawManager::UnregisterDrawCall(Drawable* component) {
    // Unregistering not registered component has no effect
    auto to_erase = std::find(m_Drawables.begin(), m_Drawables.end(), component);
    if (to_erase != m_Drawables.end()) {
        m_Drawables.erase(to_erase);
    }
}

void DrawManager::RegisterWidget(IWidget* widget) {
    // Ensure that each widget is registered at most once
    assert(std::find(m_Widgets.begin(), m_Widgets.end(), widget) == m_Widgets.end());

    m_Widgets.push_back(widget);
}

void DrawManager::UnregisterWidget(IWidget* widget) {
    // Unregistering not registered widget has no effect
    auto to_erase = std::find(m_Widgets.begin(), m_Widgets.end(), widget);
    if (to_erase != m_Widgets.end()) {
        m_Widgets.erase(to_erase);
    }
}

void DrawManager::RegisterLightSource(ILightSource* light_source) {
    // Ensure that every component is registered at most once
    assert(std::find(m_LightSources.begin(), m_LightSources.end(), light_source) == m_LightSources.end());

    m_LightSources.push_back(light_source);
}

void DrawManager::UnregisterLightSource(ILightSource* light_source) {
    // Unregistering unregistered component has no effect
    auto to_erase = std::find(m_LightSources.begin(), m_LightSources.end(), light_source);
    if (to_erase != m_LightSources.end()) {
        m_LightSources.erase(to_erase);
    }
}


std::array<float, 16> flatten_4x4(glm::mat4 input) {
    float *input_flattened = glm::value_ptr(input);

    std::array<float, 16> input_fixed_size_flattened{};
    // Convert each double element to float and store in the new array
    for (int i = 0; i < 16; ++i) {
        input_fixed_size_flattened[i] = input_flattened[i];
    }

    return input_fixed_size_flattened;
}

void DrawManager::CallDrawsOverNetwork(ENetHost* server) const {

    std::array<std::array<float, 16>, 27> local_to_world_matrices;

    glm::vec3 camera_position = m_Camera->Object().Root().Position();

    std::array<float, 3> camera_pos_flattened_fixed_size;
    float *camera_pos_flattened = glm::value_ptr(camera_position);
    for (int i = 0; i < 3; i++) {
        camera_pos_flattened_fixed_size[i] = camera_pos_flattened[i];
    }

    glm::mat4 camera_projection_matrix = m_Camera->Projection();
    std::array<float, 16> camera_proj_fixed_size_flattened = flatten_4x4(camera_projection_matrix);

    glm::mat4 camera_view_matrix = m_Camera->ViewMatrix();
    std::array<float, 16> camera_view_fixed_size_flattened = flatten_4x4(camera_view_matrix);

    int i = 0;
    for (const auto& drawable : m_Drawables) {
        if (auto cubie = dynamic_cast<Cubie*>(drawable)) {
            glm::mat4 model_matrix_for_drawable =  cubie->GetModelMatrixToDrawCubie();
            local_to_world_matrices[i] = flatten_4x4(model_matrix_for_drawable);
            i++;
        }  // else don't care
    }

    DrawingSnapshot drawing_snapshot = {camera_pos_flattened_fixed_size, camera_view_fixed_size_flattened, camera_proj_fixed_size_flattened, local_to_world_matrices};

    // Send data to all connected peers at the end of the service loop
    ENetPacket* packet = enet_packet_create(&drawing_snapshot, sizeof(DrawingSnapshot), 0);

    for (size_t i = 0; i < server->peerCount; ++i) {
        ENetPeer* peer = &server->peers[i];
        if (peer->state == ENET_PEER_STATE_CONNECTED) {
            enet_peer_send(peer, 0, packet);
        }
    }

    enet_host_flush(server);

}


void DrawManager::CallDraws() const {
    glClearColor(m_Background.x, m_Background.y, m_Background.z, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glm::mat4 pv = m_Camera->Projection() * m_Camera->ViewMatrix();

    // Draw objects
    for (auto to_draw = m_Drawables.cbegin(); to_draw != m_Drawables.cend(); to_draw++) {
        int shader_type = (*to_draw)->ShaderType();
        const ShaderProgram& curr_shader = m_ShaderPrograms[shader_type];

        curr_shader.Use();
        curr_shader.Uniform("pv", pv);

        // For each trait in shader set corresponding properties 
        if (curr_shader.Traits() & ShaderProgram::Trait::LIGHT_RECEIVER) {
            curr_shader.Uniform("viewPos", m_Camera->Object().Root().Position());
            curr_shader.Uniform("material.shininess", 32.0f);

            for (auto light_source = m_LightSources.begin(); light_source != m_LightSources.end(); ++light_source) {
                (*light_source)->SetLightProperties(curr_shader);
            }
        }

        (*to_draw)->Draw(curr_shader);
    }

    // Draw skybox
    if (m_Skybox != nullptr) {
        glDepthFunc(GL_LEQUAL);
        const ShaderProgram& skybox_shader = m_ShaderPrograms[ShaderProgram::Type::SKYBOX];

        skybox_shader.Use();
        skybox_shader.Uniform("pv", m_Camera->Projection() * glm::mat4(glm::mat3(m_Camera->ViewMatrix())));

        m_Skybox->Draw(skybox_shader);

        glDepthFunc(GL_LESS);
    }
    
    // Draw GUI
    ImGui_ImplOpenGL3_NewFrame();
    ImGui_ImplGlfw_NewFrame();
    ImGui::NewFrame();

    for (auto widget = m_Widgets.begin(); widget != m_Widgets.end(); widget++) {
        (*widget)->Draw();
    }

    ImGui::Render();
    ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
    ImGui::EndFrame();

    // End of drawing
    glfwSwapBuffers(g_Window);
}
