using System;
using System.Collections.Generic;

namespace Mini_Project.Models;

public partial class Voucher
{
    public string MaVoucher { get; set; } = null!;

    public string? TenVoucher { get; set; }

    public string? LoaiGiamGia { get; set; }

    public decimal? GiaTriGiam { get; set; }

    public decimal? DonHangToiThieu { get; set; }

    public DateTime? NgayHetHan { get; set; }

    public string? LoaiSanPhamApDung { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
