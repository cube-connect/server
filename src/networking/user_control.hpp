#ifndef USER_CONTROL_HPP
#define USER_CONTROL_HPP

/**
 * @class UserControl
 * @brief Manages control access for users.
 *
 * The UserControl class tracks which user has control and whether the control is available for others to obtain.
 */
class UserControl {
  public:
    /**
     * @brief Constructs a new UserControl object.
     */
    UserControl();
    bool attempt_to_gain_control(unsigned int user_id);
    unsigned int get_user_in_control() const;
    bool is_available_for_user_to_obtain_control() const;
    void release_control();

    bool being_controlled; ///< Flag indicating if control is available for users to obtain.

  private:
    unsigned int user_in_control_;              ///< The ID of the user currently in control.
};

#endif // USER_CONTROL_HPP
