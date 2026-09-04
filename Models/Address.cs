using System;
using System.Collections.Generic;

namespace Mini_Project.Models;

public partial class Address
{
    public int MaDiaChi { get; set; }

    public int? MaTaiKhoan { get; set; }

    public string TenNguoiNhan { get; set; } = null!;

    public string SoDienThoai { get; set; } = null!;

    public string? KhuVuc { get; set; }

    public string? DiaChiChiTiet { get; set; }

    public string? LoaiDiaChi { get; set; }

    public bool LaDiaChiMacDinh { get; set; }

    public virtual Account? MaTaiKhoanNavigation { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
