CREATE TABLE IF NOT EXISTS Users (
    Username VARCHAR(50) NOT NULL PRIMARY KEY,
    Password VARCHAR(50) NOT NULL,
    Phone VARCHAR(15),
    Fullname VARCHAR(50),
    Email VARCHAR(150),
    Admin BOOLEAN DEFAULT FALSE,
    Active BOOLEAN DEFAULT FALSE,
    Images VARCHAR(500)
);

CREATE TABLE IF NOT EXISTS Category (
    CategoryId INT AUTO_INCREMENT PRIMARY KEY,
    Categoryname VARCHAR(100),
    Categorycode VARCHAR(100),
    Images VARCHAR(500),
    Status BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS Videos (
    VideoId VARCHAR(50) NOT NULL PRIMARY KEY,
    Title VARCHAR(200),
    Poster VARCHAR(500),
    Views INT DEFAULT 0,
    Description VARCHAR(500),
    Active BOOLEAN DEFAULT TRUE,
    CategoryId INT,
    CONSTRAINT FK_Videos_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);

CREATE TABLE IF NOT EXISTS Shares (
    ShareId INT AUTO_INCREMENT PRIMARY KEY,
    Emails VARCHAR(50),
    SharedDate DATE,
    Username VARCHAR(50),
    VideoId VARCHAR(50),
    CONSTRAINT FK_Shares_Users FOREIGN KEY (Username) REFERENCES Users(Username),
    CONSTRAINT FK_Shares_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId)
);

CREATE TABLE IF NOT EXISTS Favorites (
    FavoriteId INT AUTO_INCREMENT PRIMARY KEY,
    LikedDate DATE,
    Username VARCHAR(50),
    VideoId VARCHAR(50),
    CONSTRAINT FK_Favorites_Users FOREIGN KEY (Username) REFERENCES Users(Username),
    CONSTRAINT FK_Favorites_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId)
);

INSERT INTO Users (Username, Password, Phone, Fullname, Email, Admin, Active, Images) VALUES
('admin', '123456', '0901234567', 'Quản Trị Viên', 'admin@ute.edu.vn', TRUE, TRUE, 'admin.png'),
('user', '123456', '0912345678', 'Nguyễn Văn An', 'an.nv@ute.edu.vn', FALSE, TRUE, 'user1.png'),
('tranb', '123456', '0923456789', 'Trần Thị Bình', 'binh.tt@gmail.com', FALSE, FALSE, 'user2.png');

INSERT INTO Category (Categoryname, Categorycode, Images, Status) VALUES
('Lập Trình Web', 'WEB', 'cat-web.png', TRUE),
('Khoa Học Công Nghệ', 'TECH', 'cat-tech.png', TRUE),
('Âm Nhạc Giải Trí', 'MUSIC', 'cat-music.png', TRUE);

INSERT INTO Videos (VideoId, Title, Poster, Views, Description, Active, CategoryId) VALUES
('VID01', 'Hướng Dẫn Cấu Hình Sitemesh Decorators 3', 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=600', 1250, 'Hướng dẫn chi tiết xây dựng giao diện dùng Sitemesh Decorators 3 trên nền tảng Jakarta EE.', TRUE, 1),
('VID02', 'Lập Trình Java Servlet & JPA Căn Bản', 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=600', 980, 'Khám phá kiến trúc 3 tầng và cách kết nối Hibernate JPA trong ứng dụng Servlet.', TRUE, 1),
('VID03', 'Thiết Kế Cơ Sở Dữ Liệu SQL Server Cho Web', 'https://images.unsplash.com/photo-1544383835-bda2bc66a55d?w=600', 640, 'Hướng dẫn tạo bảng Users, Category, Videos, Favorites và quan hệ khóa ngoại.', TRUE, 1),
('VID04', 'Kỹ Thuật Phân Trang Với JPQL Trong Hibernate', 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=600', 820, 'Sử dụng setFirstResult và setMaxResults để phân trang 3 video và 6 video hiệu quả.', TRUE, 1),
('VID05', 'Xác Thực Tài Khoản Bằng Mã OTP Qua Email', 'https://images.unsplash.com/photo-1563986768609-322da13575f3?w=600', 1100, 'Quy trình đăng ký tài khoản với trạng thái Active = false và kích hoạt bằng OTP.', TRUE, 1),
('VID06', 'Trí Tuệ Nhân Tạo AI Năm 2026', 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=600', 3200, 'Xu hướng phát triển công nghệ AI thế hệ mới và ứng dụng trong lập trình.', TRUE, 2),
('VID07', 'Khám Phá Vũ Trụ Và Công Nghệ Lượng Tử', 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=600', 1750, 'Những bước tiến vượt bậc của máy tính lượng tử trong xử lý dữ liệu lớn.', TRUE, 2),
('VID08', 'Nhạc Không Lời Thư Giãn Khi Lập Trình', 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=600', 5400, 'Tuyển tập những bản nhạc Lofi và giao hưởng acoustic giúp tập trung làm việc.', TRUE, 3);

INSERT INTO Favorites (LikedDate, Username, VideoId) VALUES
('2026-09-20', 'admin', 'VID01'),
('2026-09-21', 'user', 'VID01'),
('2026-09-22', 'user', 'VID02'),
('2026-09-23', 'admin', 'VID06');

INSERT INTO Shares (Emails, SharedDate, Username, VideoId) VALUES
('banbe@example.com', '2026-09-20', 'admin', 'VID01'),
('dongnghiep@ute.edu.vn', '2026-09-21', 'user', 'VID01'),
('nhomlaptrinh@gmail.com', '2026-09-22', 'user', 'VID02');

-- Bảng Cart và CartItem phục vụ quản lý giỏ hàng theo User
CREATE TABLE IF NOT EXISTS Cart (
    CartId INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_Cart_Users FOREIGN KEY (Username) REFERENCES Users(Username)
);

CREATE TABLE IF NOT EXISTS CartItems (
    CartItemId INT AUTO_INCREMENT PRIMARY KEY,
    CartId INT NOT NULL,
    VideoId VARCHAR(50) NOT NULL,
    Quantity INT DEFAULT 1,
    Price DECIMAL(18,2) DEFAULT 199000.00,
    CONSTRAINT FK_CartItems_Cart FOREIGN KEY (CartId) REFERENCES Cart(CartId),
    CONSTRAINT FK_CartItems_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId)
);

-- Bảng Orders và OrderDetails lưu đơn hàng thanh toán COD
CREATE TABLE IF NOT EXISTS Orders (
    OrderId VARCHAR(50) NOT NULL PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Address VARCHAR(500) NOT NULL,
    Note VARCHAR(500),
    PaymentMethod VARCHAR(50) DEFAULT 'COD',
    PaymentStatus VARCHAR(100) DEFAULT 'Chờ thu tiền COD khi nhận hàng',
    OrderStatus VARCHAR(100) DEFAULT 'Chờ xác nhận & Giao hàng COD',
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(18,2) DEFAULT 0,
    CONSTRAINT FK_Orders_Users FOREIGN KEY (Username) REFERENCES Users(Username)
);

CREATE TABLE IF NOT EXISTS OrderDetails (
    DetailId INT AUTO_INCREMENT PRIMARY KEY,
    OrderId VARCHAR(50) NOT NULL,
    VideoId VARCHAR(50) NOT NULL,
    Quantity INT DEFAULT 1,
    Price DECIMAL(18,2) DEFAULT 0,
    TotalPrice DECIMAL(18,2) DEFAULT 0,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    CONSTRAINT FK_OrderDetails_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId)
);


