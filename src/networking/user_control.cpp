#include "user_control.hpp"
#include <iostream> // For print statements

UserControl::UserControl() : user_in_control_(0), available_for_user_to_obtain_control_(true) {
    std::cout << "UserControl initialized. No user is in control, and control is available." << std::endl;
}

/**
 * @brief Attempts to gain control for the given user.
 *
 * @param user_id The ID of the user attempting to gain control.
 * @return true if the user successfully gained control, false otherwise.
 */
bool UserControl::attempt_to_gain_control(unsigned int user_id) {
    if (available_for_user_to_obtain_control_) {
        user_in_control_ = user_id;
        available_for_user_to_obtain_control_ = false;
        std::cout << "User " << user_id << " successfully gained control." << std::endl;
        return true;
    } else {
        std::cout << "User " << user_id << " failed to gain control. Control is not available." << std::endl;
        return false;
    }
}

/**
 * @brief Gets the ID of the user currently in control.
 *
 * @return The ID of the user in control.
 */
unsigned int UserControl::get_user_in_control() const { return user_in_control_; }

/**
 * @brief Checks if the control is available for a user to obtain.
 *
 * @return true if the control is available, false otherwise.
 */
bool UserControl::is_available_for_user_to_obtain_control() const { return available_for_user_to_obtain_control_; }

/**
 * @brief Releases control, making it available for other users to obtain.
 */
void UserControl::release_control() {
    available_for_user_to_obtain_control_ = true;
    std::cout << "Control has been released and is now available for other users to obtain." << std::endl;
}
