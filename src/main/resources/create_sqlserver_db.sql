USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'DeThi03_24110251')
BEGIN
    ALTER DATABASE DeThi03_24110251 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DeThi03_24110251;
END
GO

CREATE DATABASE DeThi03_24110251;
GO

USE DeThi03_24110251;
GO

CREATE TABLE Users (
    Username NVARCHAR(50) NOT NULL PRIMARY KEY,
    Password NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(15) NULL,
    Fullname NVARCHAR(50) NULL,
    Email NVARCHAR(150) NULL,
    Admin BIT NULL,
    Active BIT NULL,
    Images NVARCHAR(500) NULL
);
GO

CREATE TABLE Category (
    CategoryId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Categoryname NVARCHAR(100) NULL,
    Categorycode NVARCHAR(100) NULL,
    Images NVARCHAR(500) NULL,
    Status BIT NULL
);
GO

CREATE TABLE Videos (
    VideoId NVARCHAR(50) NOT NULL PRIMARY KEY,
    Title NVARCHAR(200) NULL,
    Poster NVARCHAR(500) NULL,
    Views INT NULL,
    Description NVARCHAR(500) NULL,
    Active BIT NULL,
    CategoryId INT NULL,
    CONSTRAINT FK_Videos_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);
GO

CREATE TABLE Shares (
    ShareId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Emails NVARCHAR(50) NULL,
    SharedDate DATE NULL,
    Username NVARCHAR(50) NULL,
    VideoId NVARCHAR(50) NULL,
    CONSTRAINT FK_Shares_Users FOREIGN KEY (Username) REFERENCES Users(Username),
    CONSTRAINT FK_Shares_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId)
);
GO

CREATE TABLE Favorites (
    FavoriteId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    LikedDate DATE NULL,
    VideoId NVARCHAR(50) NULL,
    Username NVARCHAR(50) NULL,
    CONSTRAINT FK_Favorites_Users FOREIGN KEY (Username) REFERENCES Users(Username),
    CONSTRAINT FK_Favorites_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId)
);
GO

INSERT INTO Users (Username, Password, Phone, Fullname, Email, Admin, Active, Images) VALUES
(N'admin', N'123456', N'0901234567', N'Quản Trị Viên', N'admin@ute.edu.vn', 1, 1, N'admin.png'),
(N'user', N'123456', N'0912345678', N'Nguyễn Văn An', N'an.nv@ute.edu.vn', 0, 1, N'user1.png'),
(N'tranb', N'123456', N'0923456789', N'Trần Thị Bình', N'binh.tt@gmail.com', 0, 0, N'user2.png');
GO

INSERT INTO Category (Categoryname, Categorycode, Images, Status) VALUES
(N'Lập Trình Web', N'WEB', N'cat-web.png', 1),
(N'Khoa Học Công Nghệ', N'TECH', N'cat-tech.png', 1),
(N'Âm Nhạc Giải Trí', N'MUSIC', N'cat-music.png', 1);
GO

INSERT INTO Videos (VideoId, Title, Poster, Views, Description, Active, CategoryId) VALUES
(N'VID01', N'Hướng Dẫn Cấu Hình Sitemesh Decorators 3', N'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=600', 1250, N'Hướng dẫn chi tiết xây dựng giao diện dùng Sitemesh Decorators 3 trên nền tảng Jakarta EE.', 1, 1),
(N'VID02', N'Lập Trình Java Servlet & JPA Căn Bản', N'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=600', 980, N'Khám phá kiến trúc 3 tầng và cách kết nối Hibernate JPA trong ứng dụng Servlet.', 1, 1),
(N'VID03', N'Thiết Kế Cơ Sở Dữ Liệu SQL Server Cho Web', N'https://images.unsplash.com/photo-1544383835-bda2bc66a55d?w=600', 640, N'Hướng dẫn tạo bảng Users, Category, Videos, Favorites và quan hệ khóa ngoại.', 1, 1),
(N'VID04', N'Kỹ Thuật Phân Trang Với JPQL Trong Hibernate', N'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=600', 820, N'Sử dụng setFirstResult và setMaxResults để phân trang 3 video và 6 video hiệu quả.', 1, 1),
(N'VID05', N'Xác Thực Tài Khoản Bằng Mã OTP Qua Email', N'https://images.unsplash.com/photo-1563986768609-322da13575f3?w=600', 1100, N'Quy trình đăng ký tài khoản với trạng thái Active = false và kích hoạt bằng OTP.', 1, 1),
(N'VID06', N'Trí Tuệ Nhân Tạo AI Năm 2026', N'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=600', 3200, N'Xu hướng phát triển công nghệ AI thế hệ mới và ứng dụng trong lập trình.', 1, 2),
(N'VID07', N'Khám Phá Vũ Trụ Và Công Nghệ Lượng Tử', N'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=600', 1750, N'Những bước tiến vượt bậc của máy tính lượng tử trong xử lý dữ liệu lớn.', 1, 2),
(N'VID08', N'Nhạc Không Lời Thư Giãn Khi Lập Trình', N'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=600', 5400, N'Tuyển tập những bản nhạc Lofi và giao hưởng acoustic giúp tập trung làm việc.', 1, 3);
GO

INSERT INTO Favorites (LikedDate, Username, VideoId) VALUES
('2026-09-20', N'admin', N'VID01'),
('2026-09-21', N'user', N'VID01'),
('2026-09-22', N'user', N'VID02'),
('2026-09-23', N'admin', N'VID06');
GO

INSERT INTO Shares (Emails, SharedDate, Username, VideoId) VALUES
(N'banbe@example.com', '2026-09-20', N'admin', N'VID01'),
(N'dongnghiep@ute.edu.vn', '2026-09-21', N'user', N'VID01'),
(N'nhomlaptrinh@gmail.com', '2026-09-22', N'user', N'VID02');
GO

-- Bảng Cart và CartItems quản lý giỏ hàng cho User trong SQL Server
CREATE TABLE Cart (
    CartId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Cart_Users FOREIGN KEY (Username) REFERENCES Users(Username)
);
GO

CREATE TABLE CartItems (
    CartItemId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CartId INT NOT NULL,
    VideoId NVARCHAR(50) NOT NULL,
    Quantity INT DEFAULT 1,
    Price DECIMAL(18,2) DEFAULT 199000.00,
    CONSTRAINT FK_CartItems_Cart FOREIGN KEY (CartId) REFERENCES Cart(CartId),
    CONSTRAINT FK_CartItems_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId)
);
GO

-- Bảng Orders và OrderDetails quản lý thanh toán đơn hàng COD trong SQL Server
CREATE TABLE Orders (
    OrderId NVARCHAR(50) NOT NULL PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    CustomerName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Address NVARCHAR(500) NOT NULL,
    Note NVARCHAR(500) NULL,
    PaymentMethod NVARCHAR(50) DEFAULT N'COD',
    PaymentStatus NVARCHAR(100) DEFAULT N'Chờ thu tiền COD khi nhận hàng',
    OrderStatus NVARCHAR(100) DEFAULT N'Chờ xác nhận & Giao hàng COD',
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18,2) DEFAULT 0,
    CONSTRAINT FK_Orders_Users FOREIGN KEY (Username) REFERENCES Users(Username)
);
GO

CREATE TABLE OrderDetails (
    DetailId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    OrderId NVARCHAR(50) NOT NULL,
    VideoId NVARCHAR(50) NOT NULL,
    Quantity INT DEFAULT 1,
    Price DECIMAL(18,2) DEFAULT 0,
    TotalPrice DECIMAL(18,2) DEFAULT 0,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    CONSTRAINT FK_OrderDetails_Videos FOREIGN KEY (VideoId) REFERENCES Videos(VideoId)
);
GO


