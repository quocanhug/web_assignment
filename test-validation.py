import urllib.request
import urllib.parse
import http.cookiejar
import sys

if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8')
if hasattr(sys.stderr, 'reconfigure'):
    sys.stderr.reconfigure(encoding='utf-8')

cookie_jar = http.cookiejar.CookieJar()
opener = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(cookie_jar))

class NoRedirectHandler(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, req, fp, code, msg, headers, newurl):
        return None

opener_no_redirect = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(cookie_jar), NoRedirectHandler)

BASE_URL = "http://localhost:8080/web_assignment"

def print_header(title):
    print("\n" + "=" * 60)
    print(f" {title}")
    print("=" * 60)

def test_security_filter():
    print_header("TEST 1: Security Interceptor / Filter (Bảo vệ tài nguyên)")
    url = f"{BASE_URL}/admin/categories"
    try:
        req = urllib.request.Request(url)
        resp = opener_no_redirect.open(req)
        print("[-] FAIL: Truy cập không xác thực nhưng không bị chặn (Status:", resp.status, ")")
    except urllib.error.HTTPError as e:
        loc = e.headers.get("Location", "")
        if e.code == 302 and "/account/login" in loc:
            print(f"[+] PASS: Đã chặn truy cập /admin/categories và chuyển hướng đến: {loc}")
        else:
            print(f"[-] FAIL: Status={e.code}, Location={loc}")

def test_login_validation():
    print_header("TEST 2: Validation Form Đăng nhập (/account/login)")
    url = f"{BASE_URL}/account/login"
    data = urllib.parse.urlencode({"email": "", "password": ""}).encode('utf-8')
    req = urllib.request.Request(url, data=data, method="POST")
    try:
        resp = opener.open(req)
        html = resp.read().decode('utf-8', errors='replace')
        has_email = "Vui lòng nhập địa chỉ email" in html
        has_pwd = "Vui lòng nhập mật khẩu" in html
        has_error_id = 'id="email.errors"' in html and 'id="password.errors"' in html
        
        print(f"[*] Kiểm tra lỗi email rỗng: {'ĐẠT' if has_email else 'CHƯA ĐẠT'}")
        print(f"[*] Kiểm tra lỗi mật khẩu rỗng: {'ĐẠT' if has_pwd else 'CHƯA ĐẠT'}")
        print(f"[*] Kiểm tra thẻ span định dạng lỗi id='xxx.errors': {'ĐẠT' if has_error_id else 'CHƯA ĐẠT'}")
        
        if has_email and has_pwd and has_error_id:
            print("[+] PASS: Form đăng nhập kiểm lỗi thành công!")
        else:
            print("[-] FAIL: Kiểm lỗi đăng nhập chưa hoàn chỉnh.")
    except Exception as e:
        print(f"[-] ERROR: {e}")

def test_register_validation():
    print_header("TEST 3: Validation Form Đăng ký (/account/register)")
    url = f"{BASE_URL}/account/register"
    data = urllib.parse.urlencode({
        "fullname": "A",
        "email": "bad_email_format",
        "phone": "123",
        "password": "123",
        "confirmPassword": "456"
    }).encode('utf-8')
    req = urllib.request.Request(url, data=data, method="POST")
    try:
        resp = opener.open(req)
        html = resp.read().decode('utf-8', errors='replace')
        c1 = "Họ và tên phải từ 2 đến 50 ký tự" in html
        c2 = "Địa chỉ email không đúng định dạng" in html
        c3 = "Số điện thoại không đúng định dạng" in html
        c4 = "Mật khẩu phải có tối thiểu 6 ký tự" in html
        c5 = "Mật khẩu xác nhận không trùng khớp" in html

        print(f"[*] Kiểm tra họ tên ngắn (<2 ký tự): {'ĐẠT' if c1 else 'CHƯA ĐẠT'}")
        print(f"[*] Kiểm tra định dạng email: {'ĐẠT' if c2 else 'CHƯA ĐẠT'}")
        print(f"[*] Kiểm tra số điện thoại (10 chữ số): {'ĐẠT' if c3 else 'CHƯA ĐẠT'}")
        print(f"[*] Kiểm tra mật khẩu (<6 ký tự): {'ĐẠT' if c4 else 'CHƯA ĐẠT'}")
        print(f"[*] Kiểm tra xác nhận mật khẩu không khớp: {'ĐẠT' if c5 else 'CHƯA ĐẠT'}")

        if c1 and c2 and c3 and c4 and c5:
            print("[+] PASS: Toàn bộ 5 quy tắc kiểm lỗi Form đăng ký hoạt động chính xác!")
        else:
            print("[-] FAIL: Có trường chưa chặn được dữ liệu sai.")
    except Exception as e:
        print(f"[-] ERROR: {e}")

def test_otp_validation():
    print_header("TEST 4: Validation Form Xác nhận OTP (/account/verify)")
    url = f"{BASE_URL}/account/verify"
    data = urllib.parse.urlencode({
        "email": "demo@gmail.com",
        "otp": "abc"
    }).encode('utf-8')
    req = urllib.request.Request(url, data=data, method="POST")
    try:
        resp = opener.open(req)
        html = resp.read().decode('utf-8', errors='replace')
        has_otp_err = "Mã OTP phải bao gồm đúng 6 chữ số" in html
        print(f"[*] Kiểm tra mã OTP sai định dạng chữ số: {'ĐẠT' if has_otp_err else 'CHƯA ĐẠT'}")
        if has_otp_err:
            print("[+] PASS: Kiểm lỗi OTP thành công!")
        else:
            print("[-] FAIL: Chưa chặn được OTP sai.")
    except Exception as e:
        print(f"[-] ERROR: {e}")

if __name__ == "__main__":
    print("KIỂM THỬ TỰ ĐỘNG TÍNH NĂNG VALIDATION & SECURITY INTERCEPTOR")
    print(f"Server Target: {BASE_URL}")
    try:
        urllib.request.urlopen(f"{BASE_URL}/home", timeout=3)
    except Exception:
        print(f"\n[!] CẢNH BÁO: Không thể kết nối tới {BASE_URL}.")
        print("    Vui lòng kiểm tra chắc chắn rằng Apache Tomcat đang chạy trên cổng 8080.")
        sys.exit(1)

    test_security_filter()
    test_login_validation()
    test_register_validation()
    test_otp_validation()
    print("\n" + "=" * 60)
    print(" HOÀN THÀNH TẤT CẢ CÁC BÀI KIỂM THỬ VALIDATION!")
    print("=" * 60 + "\n")
