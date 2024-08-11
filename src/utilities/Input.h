#ifndef Input_hpp
#define Input_hpp

#pragma warning(push, 0)
#include "glfw_shim.hpp"

#include <glm/glm.hpp>
#include "networking/client_server_shared/input_snapshot.hpp"

#pragma warning(pop)

class Input {
    friend void mouse_callback(GLFWwindow *window, double x_pos, double y_pos);
    friend void scroll_callback(GLFWwindow *window, double x_offset, double y_offset);

  public:
    Input();

    // Old style enums to allow easy check
    enum EKeyState {
        FREE = 0, // The key is not being pressed, and is not pressed in the previous frame
        PRESSED,  // The key is pressed in this frame, and not in the previous frame
        HOLD,     // The key is pressed in this frame, and in the previous frame
        RELEASED, // The key is not being pressed, and was pressed in the previous frame
    };

    void Update(GLFWwindow *window);
    void NetworkUpdate(InputSnapshot input_snapshot);

    bool AnyKeyPressed() const { return m_AnyKeyPressed; }
    bool AnyKeyHold() const { return m_AnyKeyHold; }
    bool AnyKeyReleased() const { return m_AnyKeyReleased; }
    bool KeyPressed(int glfw_key_enum) const;
    bool KeyHold(int glfw_key_enum) const;
    bool KeyReleased(int glfw_key_enum) const;
    Input::EKeyState KeyState(int glfw_key_enum) const;

    const glm::vec2 &MousePosition() const { return m_MousePosition; }
    const glm::vec2 &MouseOffset() const { return m_MouseOffset; }
    float ScrollOffset() const { return m_ScrollOffset; }

  private:
    bool m_AnyKeyPressed;
    bool m_AnyKeyHold;
    bool m_AnyKeyReleased;
    Input::EKeyState m_Keys[GLFW_KEY_MENU + 1];

    bool m_MouseFirstMove;
    bool m_ScrollChanged;
    float m_ScrollOffset;
    glm::vec2 m_MousePosition;
    glm::vec2 m_MouseLastPosition;
    glm::vec2 m_MouseOffset;
};

void mouse_callback(GLFWwindow *window, double x_pos, double y_pos);
void scroll_callback(GLFWwindow *window, double x_pos, double y_pos);

extern Input g_Input;

#endif
