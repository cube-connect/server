#include "Time.h"
#include <chrono>

Time::Time()
    : m_CurrentTime(0.0f), m_FixedCurrentTime(0.0f), m_DeltaTime(0.0f), m_FixedDeltaTime(0.0f), m_LastFrame(0.0f),
      m_TimeMultiplier(1) {}

double glfwGetTimeReplacement() {
    // Static initialization of the starting point (like GLFW does internally)
    static const auto start_time = std::chrono::high_resolution_clock::now();

    // Calculate the elapsed time since start_time
    auto now = std::chrono::high_resolution_clock::now();
    auto duration = now - start_time;
    return std::chrono::duration_cast<std::chrono::duration<double>>(duration).count();
}

void Time::Initialize() {
    m_CurrentTime = static_cast<float>(glfwGetTimeReplacement());
    m_LastFrame = m_FixedCurrentTime = m_CurrentTime;
}

void Time::Hold() { m_DeltaTime = static_cast<float>(glfwGetTimeReplacement()) - m_LastFrame; }

void Time::Update() {
    m_CurrentTime = static_cast<float>(glfwGetTimeReplacement());

    // Absolute time calculations
    m_DeltaTime = m_CurrentTime - m_LastFrame;
    m_LastFrame = m_CurrentTime;

    // Relative time calculations
    m_FixedDeltaTime = m_DeltaTime * m_TimeMultiplier;
    m_FixedCurrentTime += m_FixedDeltaTime;
}

void Time::TimeMultiplayer(unsigned int time_multiplayer) { m_TimeMultiplier = time_multiplayer; }
