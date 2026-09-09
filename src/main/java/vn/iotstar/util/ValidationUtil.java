package vn.iotstar.util;

import java.nio.file.Paths;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import jakarta.servlet.http.Part;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;

/**
 * Tiện ích hỗ trợ kiểm tra dữ liệu đầu vào (Validation)
 */
public class ValidationUtil {

    // Regex kiểm tra Email hợp lệ
    private static final String EMAIL_REGEX = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);

    // Regex kiểm tra Số điện thoại Việt Nam (10 số, bắt đầu 03, 05, 07, 08, 09 hoặc 02)
    private static final String PHONE_REGEX = "^(0|\\+84)(3|5|7|8|9)[0-9]{8}$";
    private static final Pattern PHONE_PATTERN = Pattern.compile(PHONE_REGEX);

    // Regex kiểm tra OTP 6 chữ số
    private static final String OTP_REGEX = "^[0-9]{6}$";
    private static final Pattern OTP_PATTERN = Pattern.compile(OTP_REGEX);

    // Danh sách đuôi file ảnh hợp lệ
    private static final List<String> ALLOWED_IMAGE_EXTENSIONS = Arrays.asList("jpg", "jpeg", "png", "gif", "webp", "bmp");
    public static final long MAX_IMAGE_SIZE = 5 * 1024 * 1024; // 5MB

    // Validator từ Jakarta Bean Validation
    private static Validator validator;

    static {
        try {
            ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
            validator = factory.getValidator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Kiểm tra chuỗi rỗng hoặc chỉ chứa khoảng trắng
     */
    public static boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    /**
     * Kiểm tra định dạng Email
     */
    public static boolean isValidEmail(String email) {
        if (isBlank(email)) return false;
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    /**
     * Kiểm tra định dạng số điện thoại Việt Nam
     */
    public static boolean isValidPhone(String phone) {
        if (isBlank(phone)) return false;
        String cleanPhone = phone.trim().replaceAll("[\\s.-]", "");
        return PHONE_PATTERN.matcher(cleanPhone).matches();
    }

    /**
     * Kiểm tra mã OTP 6 số
     */
    public static boolean isValidOtp(String otp) {
        if (isBlank(otp)) return false;
        return OTP_PATTERN.matcher(otp.trim()).matches();
    }

    /**
     * Kiểm tra file upload có đúng định dạng ảnh không
     */
    public static boolean isImageFile(Part part) {
        if (part == null || part.getSize() <= 0) return true; // Không upload file thì coi như hợp lệ
        String submittedName = part.getSubmittedFileName();
        if (submittedName == null || submittedName.isEmpty()) return true;

        String filename = Paths.get(submittedName).getFileName().toString();
        int dotIndex = filename.lastIndexOf(".");
        if (dotIndex < 0) return false;

        String ext = filename.substring(dotIndex + 1).toLowerCase();
        return ALLOWED_IMAGE_EXTENSIONS.contains(ext);
    }

    /**
     * Kiểm tra dung lượng file có vượt quá giới hạn không
     */
    public static boolean isFileSizeValid(Part part, long maxSizeBytes) {
        if (part == null || part.getSize() <= 0) return true;
        return part.getSize() <= maxSizeBytes;
    }

    /**
     * Kiểm tra Bean với Annotation Jakarta Validation (@NotBlank, @NotNull, @Min, @Max, etc.)
     * Trả về Map<FieldName, ErrorMessage>
     */
    public static <T> Map<String, String> validateBean(T object) {
        Map<String, String> errors = new HashMap<>();
        if (validator == null || object == null) return errors;

        Set<ConstraintViolation<T>> violations = validator.validate(object);
        for (ConstraintViolation<T> violation : violations) {
            String property = violation.getPropertyPath().toString();
            String message = violation.getMessage();
            errors.put(property, message);
        }
        return errors;
    }
}
