package vn.iotstar.service;

import vn.iotstar.entity.User;

public interface IUserService {
    boolean register(User user);
    boolean activate(String email, String otp);
    User login(String email, String password);
    boolean generateOtpForForgotPassword(String email);
    boolean resetPassword(String email, String otp, String newPassword);
    User findById(int userId);
    void updateProfile(User user);
}
