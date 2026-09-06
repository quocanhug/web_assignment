package vn.iotstar.service.impl;

import java.util.Date;
import java.util.Random;

import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.impl.UserDao;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.EmailUtil;

public class UserServiceImpl implements IUserService {

    private IUserDao userDao = new UserDao();

    // OTP có hiệu lực 5 phút
    private static final long OTP_EXPIRY_MINUTES = 5;

    private String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // 6 chữ số
        return String.valueOf(otp);
    }

    @Override
    public boolean register(User user) {
        // Kiểm tra email đã tồn tại chưa
        User existing = userDao.findByEmail(user.getEmail());
        if (existing != null) {
            return false;
        }

        // Sinh OTP và set thời hạn
        String otp = generateOtp();
        user.setOtp(otp);
        user.setOtpExpiry(new Date(System.currentTimeMillis() + OTP_EXPIRY_MINUTES * 60 * 1000));
        user.setIsActive(false);

        userDao.insert(user);

        // Gửi email OTP
        String subject = "Mã xác nhận đăng ký tài khoản";
        String body = "Xin chào " + user.getFullname() + ",\n\n"
                + "Mã OTP xác nhận tài khoản của bạn là: " + otp + "\n"
                + "Mã có hiệu lực trong " + OTP_EXPIRY_MINUTES + " phút.\n\n"
                + "Trân trọng,\nWeb Assignment Team";
        EmailUtil.sendEmail(user.getEmail(), subject, body);

        return true;
    }

    @Override
    public boolean activate(String email, String otp) {
        User user = userDao.findByEmail(email);
        if (user == null) {
            return false;
        }

        // Kiểm tra OTP đúng và chưa hết hạn
        if (user.getOtp() != null && user.getOtp().equals(otp)
                && user.getOtpExpiry() != null && user.getOtpExpiry().after(new Date())) {
            user.setIsActive(true);
            user.setOtp(null);
            user.setOtpExpiry(null);
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public User login(String email, String password) {
        User user = userDao.findByEmailAndPassword(email, password);
        if (user != null && user.getIsActive()) {
            return user;
        }
        return null;
    }

    @Override
    public boolean generateOtpForForgotPassword(String email) {
        User user = userDao.findByEmail(email);
        if (user == null || !user.getIsActive()) {
            return false;
        }

        String otp = generateOtp();
        user.setOtp(otp);
        user.setOtpExpiry(new Date(System.currentTimeMillis() + OTP_EXPIRY_MINUTES * 60 * 1000));
        userDao.update(user);

        // Gửi email OTP
        String subject = "Mã OTP đặt lại mật khẩu";
        String body = "Xin chào " + user.getFullname() + ",\n\n"
                + "Mã OTP để đặt lại mật khẩu của bạn là: " + otp + "\n"
                + "Mã có hiệu lực trong " + OTP_EXPIRY_MINUTES + " phút.\n\n"
                + "Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.\n\n"
                + "Trân trọng,\nWeb Assignment Team";
        EmailUtil.sendEmail(user.getEmail(), subject, body);

        return true;
    }

    @Override
    public boolean resetPassword(String email, String otp, String newPassword) {
        User user = userDao.findByEmail(email);
        if (user == null) {
            return false;
        }

        // Kiểm tra OTP đúng và chưa hết hạn
        if (user.getOtp() != null && user.getOtp().equals(otp)
                && user.getOtpExpiry() != null && user.getOtpExpiry().after(new Date())) {
            user.setPassword(newPassword);
            user.setOtp(null);
            user.setOtpExpiry(null);
            userDao.update(user);
            return true;
        }
        return false;
    }
}
