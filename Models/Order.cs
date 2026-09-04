using System;
using System.Collections.Generic;

namespace Mini_Project.Models;

public partial class Order
{
    public string MaDonHang { get; set; } = null!;

    public int? MaTaiKhoan { get; set; }

    public int? MaDiaChi { get; set; }

    public DateTime NgayDatHang { get; set; }

    public string TrangThai { get; set; } = null!;

    public string? PhuongThucGiaoHang { get; set; }

    public string? PhuongThucThanhToan { get; set; }

    public string? MaVoucher { get; set; }

    public decimal? TongTienHang { get; set; }

    public decimal? PhiVanChuyen { get; set; }

    public decimal? TienGiam { get; set; }

    public decimal? TienGiamBangDiem { get; set; }

    public decimal? TongTien { get; set; }

    public virtual Address? MaDiaChiNavigation { get; set; }

    public virtual Account? MaTaiKhoanNavigation { get; set; }

    public virtual Voucher? MaVoucherNavigation { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual ICollection<RewardHistory> RewardHistories { get; set; } = new List<RewardHistory>();
}
