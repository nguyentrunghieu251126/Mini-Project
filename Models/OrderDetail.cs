using System;
using System.Collections.Generic;

namespace Mini_Project.Models;

public partial class OrderDetail
{
    public string MaDonHang { get; set; } = null!;

    public int MaBienThe { get; set; }

    public int SoLuong { get; set; }

    public decimal DonGia { get; set; }

    public virtual ProductVariant MaBienTheNavigation { get; set; } = null!;

    public virtual Order MaDonHangNavigation { get; set; } = null!;
}
