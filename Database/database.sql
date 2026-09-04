-- =========================================================
-- TẠO DATABASE
-- =========================================================
IF NOT EXISTS (
    SELECT *
    FROM sys.databases
    WHERE name = 'Technology_Device_Store'
)
BEGIN
    CREATE DATABASE Technology_Device_Store;
END
GO

USE Technology_Device_Store;
GO


-- =========================================================
-- 1. BẢNG NHÀ CUNG CẤP
-- =========================================================
CREATE TABLE NCC (
    MaNCC CHAR(10) NOT NULL,
    TenNCC NVARCHAR(255) NOT NULL,
    SoDienThoai VARCHAR(20),
    DiaChi NVARCHAR(500),

    CONSTRAINT PK_NCC
        PRIMARY KEY (MaNCC)
);
GO


-- =========================================================
-- 2. BẢNG TÀI KHOẢN
-- =========================================================
CREATE TABLE Accounts (
    MaTaiKhoan INT IDENTITY(1,1) NOT NULL,
    TaiKhoan VARCHAR(100) NOT NULL,
    MatKhau VARCHAR(255) NOT NULL,
    HoTen NVARCHAR(100) NOT NULL,
    SoDienThoai VARCHAR(20),
    Email VARCHAR(100),
    TongDiem INT NOT NULL DEFAULT 0,

    CONSTRAINT PK_Accounts
        PRIMARY KEY (MaTaiKhoan),

    CONSTRAINT UQ_Accounts_TaiKhoan
        UNIQUE (TaiKhoan),

    CONSTRAINT CK_Accounts_TongDiem
        CHECK (TongDiem >= 0)
);
GO


-- =========================================================
-- 3. BẢNG SẢN PHẨM
-- =========================================================
CREATE TABLE Products (
    MaSP CHAR(10) NOT NULL,
    TenSP NVARCHAR(255) NOT NULL,
    LoaiSP VARCHAR(50) NOT NULL,
    ThuongHieu NVARCHAR(50),
    MaNCC CHAR(10),
    DonGia DECIMAL(18,2) NOT NULL,
    MoTa NVARCHAR(MAX),
    HinhAnh VARCHAR(MAX),
    DanhGia DECIMAL(2,1) NOT NULL DEFAULT 5.0,

    CONSTRAINT PK_Products
        PRIMARY KEY (MaSP),

    CONSTRAINT FK_Products_NCC
        FOREIGN KEY (MaNCC)
        REFERENCES NCC(MaNCC),

    CONSTRAINT CK_Products_DanhGia
        CHECK (DanhGia >= 0 AND DanhGia <= 5)
);
GO


-- =========================================================
-- 4. BẢNG SỔ ĐỊA CHỈ
-- =========================================================
CREATE TABLE Addresses (
    MaDiaChi INT IDENTITY(1,1) NOT NULL,
    MaTaiKhoan INT,
    TenNguoiNhan NVARCHAR(100) NOT NULL,
    SoDienThoai VARCHAR(20) NOT NULL,
    KhuVuc NVARCHAR(255),
    DiaChiChiTiet NVARCHAR(500),
    LoaiDiaChi NVARCHAR(50),
    LaDiaChiMacDinh BIT NOT NULL DEFAULT 0,

    CONSTRAINT PK_Addresses
        PRIMARY KEY (MaDiaChi),

    CONSTRAINT FK_Addresses_Accounts
        FOREIGN KEY (MaTaiKhoan)
        REFERENCES Accounts(MaTaiKhoan)
);
GO


-- =========================================================
-- 5. BẢNG BIẾN THỂ SẢN PHẨM
-- =========================================================
CREATE TABLE ProductVariants (
    MaBienThe INT IDENTITY(1,1) NOT NULL,
    MaSP CHAR(10) NOT NULL,
    MauSac NVARCHAR(50),
    DungLuong NVARCHAR(50),
    Gia DECIMAL(18,2) NOT NULL,
    GiaCu DECIMAL(18,2),
    HinhAnh VARCHAR(MAX),
    SoLuongTon INT NOT NULL DEFAULT 0,

    CONSTRAINT PK_ProductVariants
        PRIMARY KEY (MaBienThe),

    CONSTRAINT FK_ProductVariants_Products
        FOREIGN KEY (MaSP)
        REFERENCES Products(MaSP),

    CONSTRAINT CK_ProductVariants_Gia
        CHECK (Gia >= 0),

    CONSTRAINT CK_ProductVariants_GiaCu
        CHECK (GiaCu IS NULL OR GiaCu >= 0),

    CONSTRAINT CK_ProductVariants_SoLuongTon
        CHECK (SoLuongTon >= 0)
);
GO


-- =========================================================
-- 6. BẢNG MÃ GIẢM GIÁ
-- =========================================================
CREATE TABLE Vouchers (
    MaVoucher CHAR(10) NOT NULL,
    TenVoucher NVARCHAR(255),
    LoaiGiamGia VARCHAR(20),
    GiaTriGiam DECIMAL(18,2),
    DonHangToiThieu DECIMAL(18,2),
    NgayHetHan DATETIME,
    LoaiSanPhamApDung VARCHAR(50),

    CONSTRAINT PK_Vouchers
        PRIMARY KEY (MaVoucher),

    CONSTRAINT CK_Vouchers_GiaTriGiam
        CHECK (GiaTriGiam IS NULL OR GiaTriGiam >= 0),

    CONSTRAINT CK_Vouchers_DonHangToiThieu
        CHECK (
            DonHangToiThieu IS NULL
            OR DonHangToiThieu >= 0
        )
);
GO


-- =========================================================
-- 7. BẢNG ĐƠN HÀNG
-- =========================================================
CREATE TABLE Orders (
    MaDonHang CHAR(10) NOT NULL,
    MaTaiKhoan INT,
    MaDiaChi INT,
    NgayDatHang DATETIME NOT NULL DEFAULT GETDATE(),
    TrangThai VARCHAR(50) NOT NULL DEFAULT 'processing',
    PhuongThucGiaoHang VARCHAR(50),
    PhuongThucThanhToan VARCHAR(50),
    MaVoucher CHAR(10),
    TongTienHang DECIMAL(18,2),
    PhiVanChuyen DECIMAL(18,2),
    TienGiam DECIMAL(18,2),
    TienGiamBangDiem DECIMAL(18,2),
    TongTien DECIMAL(18,2),

    CONSTRAINT PK_Orders
        PRIMARY KEY (MaDonHang),

    CONSTRAINT FK_Orders_Accounts
        FOREIGN KEY (MaTaiKhoan)
        REFERENCES Accounts(MaTaiKhoan),

    CONSTRAINT FK_Orders_Addresses
        FOREIGN KEY (MaDiaChi)
        REFERENCES Addresses(MaDiaChi),

    CONSTRAINT FK_Orders_Vouchers
        FOREIGN KEY (MaVoucher)
        REFERENCES Vouchers(MaVoucher),

    CONSTRAINT CK_Orders_TongTienHang
        CHECK (
            TongTienHang IS NULL
            OR TongTienHang >= 0
        ),

    CONSTRAINT CK_Orders_PhiVanChuyen
        CHECK (
            PhiVanChuyen IS NULL
            OR PhiVanChuyen >= 0
        ),

    CONSTRAINT CK_Orders_TienGiam
        CHECK (
            TienGiam IS NULL
            OR TienGiam >= 0
        ),

    CONSTRAINT CK_Orders_TienGiamBangDiem
        CHECK (
            TienGiamBangDiem IS NULL
            OR TienGiamBangDiem >= 0
        ),

    CONSTRAINT CK_Orders_TongTien
        CHECK (
            TongTien IS NULL
            OR TongTien >= 0
        )
);
GO


-- =========================================================
-- 8. BẢNG CHI TIẾT ĐƠN HÀNG
-- =========================================================
CREATE TABLE OrderDetails (
    MaDonHang CHAR(10) NOT NULL,
    MaBienThe INT NOT NULL,
    SoLuong INT NOT NULL,
    DonGia DECIMAL(18,2) NOT NULL,

    CONSTRAINT PK_OrderDetails
        PRIMARY KEY (MaDonHang, MaBienThe),

    CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY (MaDonHang)
        REFERENCES Orders(MaDonHang),

    CONSTRAINT FK_OrderDetails_ProductVariants
        FOREIGN KEY (MaBienThe)
        REFERENCES ProductVariants(MaBienThe),

    CONSTRAINT CK_OrderDetails_SoLuong
        CHECK (SoLuong > 0),

    CONSTRAINT CK_OrderDetails_DonGia
        CHECK (DonGia >= 0)
);
GO


-- =========================================================
-- 9. BẢNG LỊCH SỬ ĐIỂM THƯỞNG
-- =========================================================
CREATE TABLE RewardHistory (
    MaLichSu INT IDENTITY(1,1) NOT NULL,
    MaTaiKhoan INT NOT NULL,
    MaDonHang CHAR(10),
    LoaiGiaoDich VARCHAR(20) NOT NULL,
    SoDiem INT NOT NULL,
    MoTa NVARCHAR(255),
    NgayGiaoDich DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT PK_RewardHistory
        PRIMARY KEY (MaLichSu),

    CONSTRAINT FK_RewardHistory_Accounts
        FOREIGN KEY (MaTaiKhoan)
        REFERENCES Accounts(MaTaiKhoan),

    CONSTRAINT FK_RewardHistory_Orders
        FOREIGN KEY (MaDonHang)
        REFERENCES Orders(MaDonHang),

    CONSTRAINT CK_RewardHistory_LoaiGiaoDich
        CHECK (
            LoaiGiaoDich IN ('CONG', 'TRU')
        )
);
GO

INSERT INTO NCC
    (MaNCC, TenNCC, SoDienThoai, DiaChi)
VALUES
(
    'NCC0000001',
    N'Công ty TNHH Apple Việt Nam',
    '0900000001',
    N'TP. Hồ Chí Minh'
),
(
    'NCC0000002',
    N'Công ty Samsung Việt Nam',
    '0900000002',
    N'TP. Hồ Chí Minh'
),
(
    'NCC0000003',
    N'Công ty Dell Việt Nam',
    '0900000003',
    N'Hà Nội'
);
GO

-- =========================================================
-- THÊM DỮ LIỆU BẢNG SẢN PHẨM
-- =========================================================
INSERT INTO Products (MaSP, TenSP, LoaiSP, ThuongHieu, MaNCC, DonGia, MoTa, HinhAnh, DanhGia)
VALUES
(
    'SP001',
    N'iPhone 17',
    'DienThoai',
    N'Apple',
    'NCC0000001',
    2000000,
    N'iPhone 17 với thiết kế hiện đại, hiệu năng mạnh mẽ và hệ thống camera chất lượng cao.',
    'https://cdn2.fptshop.com.vn/unsafe/360x0/filters:format(webp):quality(75)/00918054_dell_inspiron_14_5441_1_f77fa23935.png',
    4.8
),
(
    'SP002',
    N'Samsung Galaxy S26',
    'DienThoai',
    N'Samsung',
    'NCC0000002',
    2000000,
    N'Samsung Galaxy S26 sở hữu màn hình AMOLED sắc nét, hiệu năng cao và camera chuyên nghiệp.',
    'https://cdn2.fptshop.com.vn/unsafe/360x0/filters:format(webp):quality(75)/00918054_dell_inspiron_14_5441_1_f77fa23935.png',
    4.7
),
(
    'SP003',
    N'MacBook Air M4',
    'Laptop',
    N'Apple',
    'NCC0000001',
    2000000,
    N'MacBook Air M4 mỏng nhẹ, hiệu năng mạnh mẽ và thời lượng pin dài.',
    'https://cdn2.fptshop.com.vn/unsafe/360x0/filters:format(webp):quality(75)/00918054_dell_inspiron_14_5441_1_f77fa23935.png',
    4.9
),
(
    'SP004',
    N'Dell XPS 15',
    'Laptop',
    N'Dell',
    'NCC0000003',
    2000000,
    N'Dell XPS 15 là laptop cao cấp với thiết kế sang trọng, màn hình chất lượng cao và hiệu năng mạnh.',
    'https://cdn2.fptshop.com.vn/unsafe/360x0/filters:format(webp):quality(75)/00918054_dell_inspiron_14_5441_1_f77fa23935.png',
    4.6
),
(
    'SP005',
    N'AirPods Pro 3',
    'TaiNghe',
    N'Apple',
    'NCC0000001',
    2000000,
    N'Tai nghe không dây cao cấp với khả năng chống ồn chủ động và chất lượng âm thanh tốt.',
    'https://cdn2.fptshop.com.vn/unsafe/360x0/filters:format(webp):quality(75)/00918054_dell_inspiron_14_5441_1_f77fa23935.png',
    4.8
),
(
    'SP006',
    N'Logitech G Pro X Superlight 2',
    'Chuot',
    N'Logitech',
    'NCC0000003',
    2000000,
    N'Chuột gaming không dây cao cấp, trọng lượng nhẹ và cảm biến có độ chính xác cao.',
    'https://cdn2.fptshop.com.vn/unsafe/360x0/filters:format(webp):quality(75)/00918054_dell_inspiron_14_5441_1_f77fa23935.png',
    4.7
);
GO