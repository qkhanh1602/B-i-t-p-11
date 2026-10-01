# Bài Tập 11: Dự Án Web Servlet & JPA - Chức Năng Giỏ Hàng & Thanh Toán COD

- **Sinh viên thực hiện**: Nguyễn Quốc Khánh
- **Mã số sinh viên (MSSV)**: 24110251
- **Môi trường phát triển**:
  - IDE: Spring Tools for Eclipse 5.3.0 (STS)
  - Web Server: Apache Tomcat 11.0.4
  - Java Version: JDK 25 / Java 17+
  - Kiến trúc: Mô hình 3 lớp (3-Tier Architecture) & MVC (Model - View - Controller)
  - Công nghệ: Jakarta EE (Servlet 6.0, JSP 4.0, JSTL 3.0), Hibernate JPA 6.5, SiteMesh 3.0, Bootstrap 5.

---

## 📌 Các Tính Năng Đã Hiện Thực

### 1. Chức năng Giỏ Hàng (Shopping Cart)
- **Thêm vào giỏ hàng (Add to Cart)**:
  - Thêm sản phẩm trực tiếp từ Trang chủ (`home.jsp`) hoặc tùy chọn số lượng từ Trang chi tiết (`detail.jsp`).
  - Hỗ trợ nút "Mua ngay" chuyển thẳng đến giỏ hàng.
  - Tự động cộng dồn số lượng khi sản phẩm đã có trong giỏ hàng.
- **Sửa & Kiểm soát số lượng trong giới hạn (Quantity Limits)**:
  - Giới hạn số lượng cho mỗi mặt hàng: từ `1` đến `10` sản phẩm.
  - Nút `[-]` giảm 1 (tự động xóa khi giảm về 0).
  - Nút `[+]` tăng 1 (tự động vô hiệu hóa khi chạm mốc 10).
  - Ô nhập số lượng (Input number) có kiểm tra min/max và thông báo cảnh báo nếu vượt quá giới hạn cho phép.
- **Xóa sản phẩm khỏi giỏ (Remove & Clear)**:
  - Xóa từng món hàng cụ thể với hộp thoại xác nhận.
  - Nút "Làm trống giỏ hàng" để xóa toàn bộ mặt hàng trong giỏ.
- **Hiển thị giỏ hàng & Badge Header**:
  - Giao diện giỏ hàng (`cart.jsp`) hiển thị ảnh, tên, đơn giá VNĐ, số lượng, thành tiền, tóm tắt đơn hàng.
  - Badge số lượng sản phẩm trên thanh menu Header (`header.jsp`) cập nhật theo thời gian thực.

---

### 2. Chức năng Thanh Toán Đơn Hàng COD (Cash On Delivery)
- **Đặt hàng COD (`checkout.jsp`)**:
  - Điền thông tin người nhận: Họ và tên, Số điện thoại, Địa chỉ giao hàng cụ thể, Ghi chú cho shipper.
  - Phương thức thanh toán mặc định: **COD - Thanh toán khi nhận hàng (Cash on Delivery)**.
  - Miễn phí thu hộ COD, cho phép đồng kiểm hàng trước khi trả tiền mặt.
  - Tóm tắt chi tiết các món hàng và tổng tiền shipper sẽ thu khi giao hàng.
- **Xác nhận & Hóa đơn biên lai điện tử (`order-success.jsp`)**:
  - Tự động sinh mã đơn hàng duy nhất dạng `COD-YYYYMMDD-XXXX`.
  - Tự động xóa sạch giỏ hàng sau khi đặt thành công.
  - Hiển thị đầy đủ thông tin biên lai đặt hàng COD, chi tiết sản phẩm, tổng tiền mặt cần trả, hỗ trợ in hóa đơn (`window.print()`).
- **Lịch sử đơn hàng của tôi (`my-orders.jsp`)**:
  - Xem danh sách các đơn hàng COD đã đặt kèm ngày đặt, số món, tổng tiền, trạng thái đơn hàng.

---

## 🚀 Hướng Dẫn Cài Đặt & Khởi Chạy

1. Mở file `open_sts.bat` hoặc khởi động Spring Tools for Eclipse (STS):
   ```
   D:\taixuong\spring-tools-for-eclipse-5.3.0.RELEASE-e4.40.0-win32.win32.x86_64\sts-5.3.0.RELEASE\SpringToolsForEclipse.exe
   ```
2. Import thư mục dự án `servlet-jpa-starter` vào workspace.
3. Cấu hình Apache Tomcat 11.0:
   - Thêm Server Tomcat 11 tại đường dẫn: `D:\taixuong\apache-tomcat-11.0.4`
   - Add project `servlet-jpa-starter` vào server.
4. Truy cập ứng dụng tại:
   - Đăng nhập: `http://localhost:8080/servlet-jpa-starter/login` (Tài khoản: `user` / `123456`)
   - Trang chủ: `http://localhost:8080/servlet-jpa-starter/home`
   - Giỏ hàng: `http://localhost:8080/servlet-jpa-starter/cart`
   - Đơn hàng của tôi: `http://localhost:8080/servlet-jpa-starter/my-orders`
