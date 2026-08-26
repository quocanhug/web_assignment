-- =============================================
-- TẠO DATABASE VÀ BẢNG CATEGORY CHO BÀI TẬP CRUD
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
    PRIMARY KEY CLUSTERED 
    (
        [cate_id] ASC
    )
) ON [PRIMARY]
GO

-- Bước 3: Thêm dữ liệu mẫu (tùy chọn)
INSERT INTO Category (cate_name, icons) VALUES (N'Điện thoại', NULL);
INSERT INTO Category (cate_name, icons) VALUES (N'Laptop', NULL);
INSERT INTO Category (cate_name, icons) VALUES (N'Máy tính bảng', NULL);
INSERT INTO Category (cate_name, icons) VALUES (N'Phụ kiện', NULL);
GO

-- Kiểm tra
SELECT * FROM Category;
GO
