#include <unordered_map>
#include "Input.h"

#include "Window.h"

#pragma warning(disable : 26495)
Input::Input()
    : m_AnyKeyPressed(false), m_AnyKeyHold(false), m_AnyKeyReleased(false), m_MouseFirstMove(true),
      m_ScrollChanged(true), m_ScrollOffset(0.0f), m_MousePosition(g_Window.Width() / 2.0f, g_Window.Height() / 2.0f),
      m_MouseLastPosition(m_MousePosition), m_MouseOffset(0.0f) {

    for (int i = 0; i < GLFW_KEY_MENU + 1; ++i) {
        m_Keys[i] = EKeyState::FREE;
    }
}
#pragma warning(default : 26495)

void Input::NetworkUpdate(InputSnapshot input_snapshot) {

    m_AnyKeyPressed = false;
    m_AnyKeyHold = false;
    m_AnyKeyReleased = false;

    // Method to get the mapping of GLFW keys to pressed states
    std::unordered_map<int, bool> key_state_map = {
        {GLFW_KEY_F, input_snapshot.f_pressed},
        {GLFW_KEY_B, input_snapshot.b_pressed},
        {GLFW_KEY_R, input_snapshot.r_pressed},
        {GLFW_KEY_L, input_snapshot.l_pressed},
        {GLFW_KEY_U, input_snapshot.u_pressed},
        {GLFW_KEY_D, input_snapshot.d_pressed},
        {GLFW_KEY_LEFT_SHIFT, input_snapshot.shift_pressed},
        {GLFW_KEY_ENTER, input_snapshot.enter_pressed},
        {GLFW_MOUSE_BUTTON_LEFT, input_snapshot.left_mouse_button_pressed},
        {GLFW_MOUSE_BUTTON_RIGHT, input_snapshot.right_mouse_button_pressed},
    };

    // Iterate through the key-value pairs
    for (const auto &[key, pressed] : key_state_map) {
        if (pressed) {
            if (m_Keys[key] == EKeyState::FREE || m_Keys[key] == EKeyState::RELEASED) {
                m_Keys[key] = EKeyState::PRESSED;
                m_AnyKeyPressed = true;
            } else if (m_Keys[key] == EKeyState::PRESSED) {
                m_Keys[key] = EKeyState::HOLD;
                m_AnyKeyHold = true;
            }
        } else {
            if (m_Keys[key] == EKeyState::PRESSED || m_Keys[key] == EKeyState::HOLD) {
                m_Keys[key] = EKeyState::RELEASED;
                m_AnyKeyReleased = true;
            } else {
                m_Keys[key] = EKeyState::FREE;
            }
        }
    }

    // Mouse position
    // this was added because there is no more mouse callback
    m_MousePosition = glm::vec2(input_snapshot.mouse_position_x, input_snapshot.mouse_position_y);
    if (g_Input.m_MouseFirstMove) {
        g_Input.m_MouseLastPosition = g_Input.m_MousePosition;
        g_Input.m_MouseFirstMove = false;
    }

    m_MouseOffset.x = m_MousePosition.x - m_MouseLastPosition.x;
    m_MouseOffset.y = m_MouseLastPosition.y - m_MousePosition.y;
    m_MouseLastPosition = m_MousePosition;

    // Mouse scroll
    if (!m_ScrollChanged) {
        m_ScrollOffset = 0.0f;
    }
    m_ScrollChanged = false;
}

void Input::Update(GLFWwindow *window) {
    m_AnyKeyPressed = false;
    m_AnyKeyHold = false;
    m_AnyKeyReleased = false;

    // Mouse buttons
    for (int i = 0; i < GLFW_MOUSE_BUTTON_8; ++i) {
        if (glfwGetMouseButton(window, i) == GLFW_PRESS) {
            if (m_Keys[i] == EKeyState::FREE || m_Keys[i] == EKeyState::RELEASED) {
                m_Keys[i] = EKeyState::PRESSED;
                m_AnyKeyPressed = true;
            } else if (m_Keys[i] == EKeyState::PRESSED) {
                m_Keys[i] = EKeyState::HOLD;
                m_AnyKeyHold = true;
            }
        } else {
            if (m_Keys[i] == EKeyState::PRESSED || m_Keys[i] == EKeyState::HOLD) {
                m_Keys[i] = EKeyState::RELEASED;
                m_AnyKeyReleased = true;
            } else {
                m_Keys[i] = EKeyState::FREE;
            }
        }
    }

    // Keyboard buttons
    for (int i = GLFW_KEY_SPACE; i < GLFW_KEY_MENU + 1; ++i) {
        if (glfwGetKey(window, i) == GLFW_PRESS) {
            if (m_Keys[i] == EKeyState::FREE || m_Keys[i] == EKeyState::RELEASED) {
                m_Keys[i] = EKeyState::PRESSED;
                m_AnyKeyPressed = true;
            } else if (m_Keys[i] == EKeyState::PRESSED) {
                m_Keys[i] = EKeyState::HOLD;
                m_AnyKeyHold = true;
            }
        } else {
            if (m_Keys[i] == EKeyState::PRESSED || m_Keys[i] == EKeyState::HOLD) {
                m_Keys[i] = EKeyState::RELEASED;
                m_AnyKeyReleased = true;
            } else {
                m_Keys[i] = EKeyState::FREE;
            }
        }
    }

    // Mouse position
    m_MouseOffset.x = m_MousePosition.x - m_MouseLastPosition.x;
    m_MouseOffset.y = m_MouseLastPosition.y - m_MousePosition.y;
    m_MouseLastPosition = m_MousePosition;

    // Mouse scroll
    if (!m_ScrollChanged) {
        m_ScrollOffset = 0.0f;
    }
    m_ScrollChanged = false;
}

bool Input::KeyPressed(int glfw_key_enum) const { return m_Keys[glfw_key_enum] == EKeyState::PRESSED; }

bool Input::KeyHold(int glfw_key_enum) const { return m_Keys[glfw_key_enum] == EKeyState::HOLD; }

bool Input::KeyReleased(int glfw_key_enum) const { return m_Keys[glfw_key_enum] == EKeyState::RELEASED; }

Input::EKeyState Input::KeyState(int glfw_key_enum) const { return m_Keys[glfw_key_enum]; }

void mouse_callback(GLFWwindow *window, double x_pos, double y_pos) {
    (void *)window;

    g_Input.m_MousePosition.x = static_cast<float>(x_pos);
    g_Input.m_MousePosition.y = static_cast<float>(y_pos);

    // Executed only once at the beginning
    if (g_Input.m_MouseFirstMove) {
        g_Input.m_MouseLastPosition = g_Input.m_MousePosition;
        g_Input.m_MouseFirstMove = false;
    }
}

void scroll_callback(GLFWwindow *window, double x_offset, double y_offset) {
    (void *)window;
    (void)x_offset;
    g_Input.m_ScrollOffset = static_cast<float>(y_offset);

    g_Input.m_ScrollChanged = true;
}
