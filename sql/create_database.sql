-- =============================================
-- TẠO DATABASE VÀ CÁC BẢNG CHO BÀI TẬP CRUD
-- Chạy script này trong SQL Server Management Studio (SSMS)
-- =============================================

-- Bước 1: Tạo Database
CREATE DATABASE ServletCRUDMVC;
GO

USE ServletCRUDMVC;
GO

-- Bước 2: Tạo bảng Category
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Category(
    [cate_id] [int] IDENTITY(1,1) NOT NULL,
    [cate_name] [nvarchar](255) NOT NULL,
    [icons] [nvarchar](255) NULL,
    [status] [int] DEFAULT 1,
    PRIMARY KEY CLUSTERED 
    (
        [cate_id] ASC
    )
) ON [PRIMARY]
GO

-- Bước 3: Tạo bảng Users
CREATE TABLE Users(
    [user_id] [int] IDENTITY(1,1) NOT NULL,
    [fullname] [nvarchar](255) NOT NULL,
    [email] [nvarchar](255) NOT NULL UNIQUE,
    [password] [nvarchar](255) NOT NULL,
    [is_active] [bit] DEFAULT 0,
    [otp] [varchar](6) NULL,
    [otp_expiry] [datetime] NULL,
    PRIMARY KEY CLUSTERED 
    (
        [user_id] ASC
    )
) ON [PRIMARY]
GO

-- Bước 4: Tạo bảng Products (quan hệ N-1 với Category)
CREATE TABLE Products(
    [product_id] [int] IDENTITY(1,1) NOT NULL,
    [product_name] [nvarchar](255) NOT NULL,
    [price] [float] NOT NULL,
    [description] [nvarchar](max) NULL,
    [image] [nvarchar](500) NULL,
    [created_date] [datetime] DEFAULT GETDATE(),
    [status] [int] DEFAULT 1,
    [cate_id] [int] NULL,
    PRIMARY KEY CLUSTERED 
    (
        [product_id] ASC
    ),
    FOREIGN KEY ([cate_id]) REFERENCES Category([cate_id])
) ON [PRIMARY]
GO

-- Bước 5: Thêm dữ liệu mẫu Category
INSERT INTO Category (cate_name, icons) VALUES (N'Điện thoại', NULL);
INSERT INTO Category (cate_name, icons) VALUES (N'Laptop', NULL);
INSERT INTO Category (cate_name, icons) VALUES (N'Máy tính bảng', NULL);
INSERT INTO Category (cate_name, icons) VALUES (N'Phụ kiện', NULL);
GO

-- Bước 6: Thêm dữ liệu mẫu Products
INSERT INTO Products (product_name, price, description, image, cate_id) VALUES (N'iPhone 15 Pro Max', 34990000, N'Điện thoại Apple iPhone 15 Pro Max 256GB', NULL, 1);
INSERT INTO Products (product_name, price, description, image, cate_id) VALUES (N'Samsung Galaxy S24 Ultra', 31990000, N'Điện thoại Samsung Galaxy S24 Ultra 256GB', NULL, 1);
INSERT INTO Products (product_name, price, description, image, cate_id) VALUES (N'Xiaomi 14 Ultra', 23990000, N'Điện thoại Xiaomi 14 Ultra 512GB', NULL, 1);
INSERT INTO Products (product_name, price, description, image, cate_id) VALUES (N'MacBook Air M3', 27990000, N'Laptop Apple MacBook Air M3 13 inch 8GB 256GB', NULL, 2);
INSERT INTO Products (product_name, price, description, image, cate_id) VALUES (N'Dell XPS 15', 42990000, N'Laptop Dell XPS 15 9530 Core i7 32GB 1TB', NULL, 2);
INSERT INTO Products (product_name, price, description, image, cate_id) VALUES (N'ASUS ROG Zephyrus G14', 35990000, N'Laptop Gaming ASUS ROG Zephyrus G14 Ryzen 9', NULL, 2);
INSERT INTO Products (product_name, price, description, image, cate_id) VALUES (N'iPad Pro M4', 28990000, N'Máy tính bảng iPad Pro M4 11 inch 256GB', NULL, 3);
INSERT INTO Products (product_name, price, description, image, cate_id) VALUES (N'Samsung Galaxy Tab S9', 19990000, N'Máy tính bảng Samsung Galaxy Tab S9 Ultra', NULL, 3);
INSERT INTO Products (product_name, price, description, image, cate_id) VALUES (N'AirPods Pro 2', 5990000, N'Tai nghe Apple AirPods Pro 2 USB-C', NULL, 4);
INSERT INTO Products (product_name, price, description, image, cate_id) VALUES (N'Chuột Logitech MX Master 3S', 2490000, N'Chuột không dây Logitech MX Master 3S', NULL, 4);
INSERT INTO Products (product_name, price, description, image, cate_id) VALUES (N'OPPO Find X7 Ultra', 24990000, N'Điện thoại OPPO Find X7 Ultra 512GB', NULL, 1);
INSERT INTO Products (product_name, price, description, image, cate_id) VALUES (N'Lenovo ThinkPad X1 Carbon', 38990000, N'Laptop Lenovo ThinkPad X1 Carbon Gen 11', NULL, 2);
GO

-- Kiểm tra
SELECT * FROM Category;
SELECT * FROM Users;
SELECT * FROM Products;
GO
