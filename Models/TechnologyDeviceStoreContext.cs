using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace Mini_Project.Models;

public partial class TechnologyDeviceStoreContext : DbContext
{
    public TechnologyDeviceStoreContext()
    {
    }

    public TechnologyDeviceStoreContext(DbContextOptions<TechnologyDeviceStoreContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Account> Accounts { get; set; }

    public virtual DbSet<Address> Addresses { get; set; }

    public virtual DbSet<Ncc> Nccs { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderDetail> OrderDetails { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<ProductVariant> ProductVariants { get; set; }

    public virtual DbSet<RewardHistory> RewardHistories { get; set; }

    public virtual DbSet<Voucher> Vouchers { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=DefaultConnection");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Account>(entity =>
        {
            entity.HasKey(e => e.MaTaiKhoan);

            entity.HasIndex(e => e.TaiKhoan, "UQ_Accounts_TaiKhoan").IsUnique();

            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.HoTen).HasMaxLength(100);
            entity.Property(e => e.MatKhau)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.SoDienThoai)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.TaiKhoan)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Address>(entity =>
        {
            entity.HasKey(e => e.MaDiaChi);

            entity.Property(e => e.DiaChiChiTiet).HasMaxLength(500);
            entity.Property(e => e.KhuVuc).HasMaxLength(255);
            entity.Property(e => e.LoaiDiaChi).HasMaxLength(50);
            entity.Property(e => e.SoDienThoai)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.TenNguoiNhan).HasMaxLength(100);

            entity.HasOne(d => d.MaTaiKhoanNavigation).WithMany(p => p.Addresses)
                .HasForeignKey(d => d.MaTaiKhoan)
                .HasConstraintName("FK_Addresses_Accounts");
        });

        modelBuilder.Entity<Ncc>(entity =>
        {
            entity.HasKey(e => e.MaNcc);

            entity.ToTable("NCC");

            entity.Property(e => e.MaNcc)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("MaNCC");
            entity.Property(e => e.DiaChi).HasMaxLength(500);
            entity.Property(e => e.SoDienThoai)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.TenNcc)
                .HasMaxLength(255)
                .HasColumnName("TenNCC");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.MaDonHang);

            entity.Property(e => e.MaDonHang)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.MaVoucher)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.NgayDatHang)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.PhiVanChuyen).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.PhuongThucGiaoHang)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.PhuongThucThanhToan)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.TienGiam).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TienGiamBangDiem).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TongTien).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TongTienHang).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TrangThai)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasDefaultValue("processing");

            entity.HasOne(d => d.MaDiaChiNavigation).WithMany(p => p.Orders)
                .HasForeignKey(d => d.MaDiaChi)
                .HasConstraintName("FK_Orders_Addresses");

            entity.HasOne(d => d.MaTaiKhoanNavigation).WithMany(p => p.Orders)
                .HasForeignKey(d => d.MaTaiKhoan)
                .HasConstraintName("FK_Orders_Accounts");

            entity.HasOne(d => d.MaVoucherNavigation).WithMany(p => p.Orders)
                .HasForeignKey(d => d.MaVoucher)
                .HasConstraintName("FK_Orders_Vouchers");
        });

        modelBuilder.Entity<OrderDetail>(entity =>
        {
            entity.HasKey(e => new { e.MaDonHang, e.MaBienThe });

            entity.Property(e => e.MaDonHang)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.DonGia).HasColumnType("decimal(18, 2)");

            entity.HasOne(d => d.MaBienTheNavigation).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.MaBienThe)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_OrderDetails_ProductVariants");

            entity.HasOne(d => d.MaDonHangNavigation).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.MaDonHang)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_OrderDetails_Orders");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.MaSp);

            entity.Property(e => e.MaSp)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("MaSP");
            entity.Property(e => e.DanhGia)
                .HasDefaultValue(5.0m)
                .HasColumnType("decimal(2, 1)");
            entity.Property(e => e.DonGia).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.HinhAnh).IsUnicode(false);
            entity.Property(e => e.LoaiSp)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("LoaiSP");
            entity.Property(e => e.MaNcc)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("MaNCC");
            entity.Property(e => e.TenSp)
                .HasMaxLength(255)
                .HasColumnName("TenSP");
            entity.Property(e => e.ThuongHieu).HasMaxLength(50);

            entity.HasOne(d => d.MaNccNavigation).WithMany(p => p.Products)
                .HasForeignKey(d => d.MaNcc)
                .HasConstraintName("FK_Products_NCC");
        });

        modelBuilder.Entity<ProductVariant>(entity =>
        {
            entity.HasKey(e => e.MaBienThe);

            entity.Property(e => e.DungLuong).HasMaxLength(50);
            entity.Property(e => e.Gia).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.GiaCu).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.HinhAnh).IsUnicode(false);
            entity.Property(e => e.MaSp)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("MaSP");
            entity.Property(e => e.MauSac).HasMaxLength(50);

            entity.HasOne(d => d.MaSpNavigation).WithMany(p => p.ProductVariants)
                .HasForeignKey(d => d.MaSp)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ProductVariants_Products");
        });

        modelBuilder.Entity<RewardHistory>(entity =>
        {
            entity.HasKey(e => e.MaLichSu);

            entity.ToTable("RewardHistory");

            entity.Property(e => e.LoaiGiaoDich)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.MaDonHang)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.MoTa).HasMaxLength(255);
            entity.Property(e => e.NgayGiaoDich)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.HasOne(d => d.MaDonHangNavigation).WithMany(p => p.RewardHistories)
                .HasForeignKey(d => d.MaDonHang)
                .HasConstraintName("FK_RewardHistory_Orders");

            entity.HasOne(d => d.MaTaiKhoanNavigation).WithMany(p => p.RewardHistories)
                .HasForeignKey(d => d.MaTaiKhoan)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_RewardHistory_Accounts");
        });

        modelBuilder.Entity<Voucher>(entity =>
        {
            entity.HasKey(e => e.MaVoucher);

            entity.Property(e => e.MaVoucher)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.DonHangToiThieu).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.GiaTriGiam).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.LoaiGiamGia)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.LoaiSanPhamApDung)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.NgayHetHan).HasColumnType("datetime");
            entity.Property(e => e.TenVoucher).HasMaxLength(255);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
