#include "Scene.h"

#include <enet/enet.h>
#include <iostream>
#include <cstdlib>
#include <cstring>

#include "../rendering/Drawable.h"
#include "../rendering/ILightSource.h"

void MyScene::PreRun() {
    m_Running = true;
    m_DrawManager.Initialize();
}

void MyScene::Run() {
    m_ObjectManager.InitializeObjects();

    // Initialize Time manager as close to game loop as possible
    // to avoid misrepresented delta time
    g_Time.Initialize();
    
    // Game loop
    while (m_Running && !glfwWindowShouldClose(g_Window)) {
        // If frame rate is greater than limit then wait
        do {
            g_Time.Hold();
            glfwPollEvents();
        } while (g_Time.DeltaTime() < m_FrameRateLimit);

        // Update global systems
        g_Time.Update();
        g_Input.Update(g_Window);
        
        // Managers
        m_ObjectManager.ProcessFrame();
        m_DrawManager.CallDraws();
    }
}

void MyScene::RunOverNetwork() {
    m_ObjectManager.InitializeObjects();

    // Initialize Time manager as close to game loop as possible
    // to avoid misrepresented delta time
    g_Time.Initialize();

    uint16_t port = 7777;

    if (enet_initialize() != 0) {
        std::cerr << "An error occurred while initializing ENet.\n";
//        return EXIT_FAILURE;
    }
    atexit(enet_deinitialize);

    ENetAddress address;
    ENetHost* server;

    address.host = ENET_HOST_ANY;
    address.port = port;

    server = enet_host_create(&address, 32, 2, 0, 0);
    if (!server) {
        std::cerr << "An error occurred while trying to create an ENet server host.\n";
//        return EXIT_FAILURE;
    }

    std::cout << "Server initialized on port " << port << ".\n";

    ENetEvent event;
    InputSnapshot input_snapshot;

    // Game loop
    while (m_Running && !glfwWindowShouldClose(g_Window)) {
        // If frame rate is greater than limit then wait
        do {
            g_Time.Hold();
            glfwPollEvents();
        } while (g_Time.DeltaTime() < m_FrameRateLimit);


        while (enet_host_service(server, &event, 0) > 0) {
            switch (event.type) {
                case ENET_EVENT_TYPE_CONNECT:
                    std::cout << "A new client connected from "
                              << event.peer->address.host << ":"
                              << event.peer->address.port << ".\n";
                    event.peer->data = (void*)"Client information";
                    break;
                case ENET_EVENT_TYPE_RECEIVE:
                    std::cout << "A packet of length " << event.packet->dataLength
                              << " containing " << (char*)event.packet->data
                              << " was received from " << (char*)event.peer->data
                              << " on channel " << event.channelID << ".\n";

                    if (event.packet->dataLength == sizeof(InputSnapshot)) {
                        input_snapshot = *reinterpret_cast<InputSnapshot*>(event.packet->data);
                    } else {
                        std::cerr << "Received packet of incorrect size." << std::endl;
                    }
                    enet_packet_destroy(event.packet);
                    break;
                case ENET_EVENT_TYPE_DISCONNECT:
                    std::cout << (char*)event.peer->data << " disconnected.\n";
                    event.peer->data = nullptr;
                    break;
                default:
                    break;
            }
        }


        // Update global systems
        g_Time.Update();
        g_Input.NetworkUpdate(input_snapshot);

        // Managers
        m_ObjectManager.ProcessFrame();
        m_DrawManager.CallDrawsOverNetwork(server);
        // m_DrawManager.CallDraws();
    }
}

void MyScene::PostRun() {
    m_ObjectManager.DestroyObjects();
}

void MyScene::Exit() {
    m_Running = false;
}

void MyScene::FrameRateLimit(unsigned int frame_rate) {
    m_FrameRateLimit = frame_rate != 0 ? 1.0f / (float)frame_rate : 0.0f;
}

MyObject* MyScene::CreateObject(std::string name) {
    return m_ObjectManager.CreateObject(name);
}

void MyScene::DestroyObject(std::uint8_t id) {
    m_ObjectManager.DestroyObject(id);
}

void MyScene::RegisterDrawCall(Drawable* drawable) {
    m_DrawManager.RegisterDrawCall(drawable);
}

void MyScene::UnregisterDrawCall(Drawable* drawable) {
    m_DrawManager.UnregisterDrawCall(drawable);
}

void MyScene::RegisterWidget(IWidget* widget) {
    m_DrawManager.RegisterWidget(widget);
}

void MyScene::UnregisterWidget(IWidget* widget) {
    m_DrawManager.UnregisterWidget(widget);
}

void MyScene::RegisterLightSource(ILightSource* light_source) {
    m_DrawManager.RegisterLightSource(light_source);
}

void MyScene::UnregisterLightSource(ILightSource* light_source) {
    m_DrawManager.UnregisterLightSource(light_source);
}

void MyScene::RegisterCamera(Camera* camera) {
    m_DrawManager.RegisterCamera(camera);
}

Camera* MyScene::MainCamera() const {
    return m_DrawManager.MainCamera();
}

void MyScene::Skybox(const std::string& right, const std::string& left, const std::string& top, const std::string& bottom, const std::string& back, const std::string& front) {
    m_DrawManager.Skybox(right, left, top, bottom, back, front);
}

void MyScene::Background(const glm::vec3& background) {
    m_DrawManager.Background(background);
}
