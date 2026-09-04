IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Technology_Device_Store')
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
    MaNCC INT IDENTITY(1,1),
    TenNCC NVARCHAR(255) NOT NULL,
    SoDienThoai VARCHAR(20),
    DiaChi NVARCHAR(MAX),
    CONSTRAINT PK_NCC PRIMARY KEY (MaNCC)
);


-- =========================================================
-- 2. BẢNG TÀI KHOẢN
-- =========================================================
CREATE TABLE Accounts (
    MaTaiKhoan INT IDENTITY(1,1),
    TaiKhoan VARCHAR(100) NOT NULL,
    MatKhau VARCHAR(255) NOT NULL,
    HoTen NVARCHAR(100) NOT NULL,
    SoDienThoai VARCHAR(20),
    Email VARCHAR(100),
    TongDiem INT DEFAULT 0,
    CONSTRAINT PK_Accounts PRIMARY KEY (MaTaiKhoan),
    CONSTRAINT UQ_Accounts_TaiKhoan UNIQUE (TaiKhoan)
);


-- =========================================================
-- 3. BẢNG SẢN PHẨM
-- =========================================================
CREATE TABLE Products (
    MaSP VARCHAR(50),
    TenSP NVARCHAR(255) NOT NULL,
    LoaiSP VARCHAR(50) NOT NULL,
    ThuongHieu NVARCHAR(50),
    MaNCC INT,
    MoTa NVARCHAR(MAX),
    DanhGia DECIMAL(2,1) DEFAULT 5.0,
    CONSTRAINT PK_Products  PRIMARY KEY (MaSP),
    CONSTRAINT FK_Products_NCC FOREIGN KEY (MaNCC) REFERENCES NCC(MaNCC)
);


-- =========================================================
-- 4. BẢNG SỔ ĐỊA CHỈ
-- =========================================================
CREATE TABLE Addresses (
    MaDiaChi INT IDENTITY(1,1),
    MaTaiKhoan INT,
    TenNguoiNhan NVARCHAR(100) NOT NULL,
    SoDienThoai VARCHAR(20) NOT NULL,
    KhuVuc NVARCHAR(255),
    DiaChiChiTiet NVARCHAR(MAX),
    LoaiDiaChi NVARCHAR(50),
    LaDiaChiMacDinh BIT DEFAULT 0,
    CONSTRAINT PK_Addresses  PRIMARY KEY (MaDiaChi),
    CONSTRAINT FK_Addresses_Accounts FOREIGN KEY (MaTaiKhoan) REFERENCES Accounts(MaTaiKhoan)
);

-- =========================================================
-- 5. BẢNG BIẾN THỂ SẢN PHẨM
-- =========================================================
CREATE TABLE ProductVariants (
    MaBienThe INT IDENTITY(1,1),
    MaSP VARCHAR(50),
    MauSac NVARCHAR(50),
    DungLuong NVARCHAR(50),
    Gia DECIMAL(18,2) NOT NULL,
    GiaCu DECIMAL(18,2),
    HinhAnh VARCHAR(MAX),
    CONSTRAINT PK_ProductVariants PRIMARY KEY (MaBienThe),
    CONSTRAINT FK_ProductVariants_Products FOREIGN KEY (MaSP) REFERENCES Products(MaSP)
);

-- =========================================================
-- 6. BẢNG MÃ GIẢM GIÁ
-- =========================================================
CREATE TABLE Vouchers (
    MaVoucher VARCHAR(50),
    TenVoucher NVARCHAR(255),
    LoaiGiamGia VARCHAR(20),
    GiaTriGiam DECIMAL(18,2),
    DonHangToiThieu DECIMAL(18,2),
    NgayHetHan DATETIME,
    LoaiSanPhamApDung VARCHAR(50),
    CONSTRAINT PK_Vouchers PRIMARY KEY (MaVoucher)
);


-- =========================================================
-- 7. BẢNG ĐƠN HÀNG
-- =========================================================
CREATE TABLE Orders (
    MaDonHang VARCHAR(50),
    MaTaiKhoan INT,
    MaDiaChi INT,
    NgayDatHang DATETIME DEFAULT GETDATE(),
    TrangThai VARCHAR(50) DEFAULT 'processing',
    PhuongThucGiaoHang VARCHAR(50),
    PhuongThucThanhToan VARCHAR(50),
    MaVoucher VARCHAR(50),
    TongTienHang DECIMAL(18,2),
    PhiVanChuyen DECIMAL(18,2),
    TienGiam DECIMAL(18,2),
    TienGiamBangDiem DECIMAL(18,2),
    TongTien DECIMAL(18,2),
    CONSTRAINT PK_Orders PRIMARY KEY (MaDonHang),
    CONSTRAINT FK_Orders_Accounts FOREIGN KEY (MaTaiKhoan) REFERENCES Accounts(MaTaiKhoan),
    CONSTRAINT FK_Orders_Addresses FOREIGN KEY (MaDiaChi) REFERENCES Addresses(MaDiaChi),
    CONSTRAINT FK_Orders_Vouchers FOREIGN KEY (MaVoucher) REFERENCES Vouchers(MaVoucher)
);


-- =========================================================
-- 8. BẢNG CHI TIẾT ĐƠN HÀNG
-- =========================================================
CREATE TABLE OrderDetails (
    MaDonHang VARCHAR(50),
    MaBienThe INT,
    SoLuong INT NOT NULL,
    DonGia DECIMAL(18,2) NOT NULL,
    CONSTRAINT PK_OrderDetails PRIMARY KEY (MaDonHang, MaBienThe),
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (MaDonHang) REFERENCES Orders(MaDonHang),
    CONSTRAINT FK_OrderDetails_ProductVariants FOREIGN KEY (MaBienThe) REFERENCES ProductVariants(MaBienThe)
);


-- =========================================================
-- 9. BẢNG LỊCH SỬ ĐIỂM THƯỞNG
-- =========================================================
CREATE TABLE RewardHistory (
    MaLichSu INT IDENTITY(1,1),
    MaTaiKhoan INT,
    MaDonHang VARCHAR(50),
    LoaiGiaoDich VARCHAR(20),
    SoDiem INT NOT NULL,
    MoTa NVARCHAR(255),
    NgayGiaoDich DATETIME DEFAULT GETDATE(),
    CONSTRAINT PK_RewardHistory PRIMARY KEY (MaLichSu),
    CONSTRAINT FK_RewardHistory_Accounts FOREIGN KEY (MaTaiKhoan) REFERENCES Accounts(MaTaiKhoan),
    CONSTRAINT FK_RewardHistory_Orders FOREIGN KEY (MaDonHang) REFERENCES Orders(MaDonHang)
);
GO
