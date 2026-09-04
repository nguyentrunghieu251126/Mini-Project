using System;
using System.Collections.Generic;

namespace Mini_Project.Models;

public partial class ProductVariant
{
    public int MaBienThe { get; set; }

    public string? MaSp { get; set; }

    public string? MauSac { get; set; }

    public string? DungLuong { get; set; }

    public decimal Gia { get; set; }

    public decimal? GiaCu { get; set; }

    public string? HinhAnh { get; set; }

    public virtual Product? MaSpNavigation { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
}
