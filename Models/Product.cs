using System;
using System.Collections.Generic;

namespace Mini_Project.Models;

public partial class Product
{
    public string MaSp { get; set; } = null!;

    public string TenSp { get; set; } = null!;

    public string LoaiSp { get; set; } = null!;

    public string? ThuongHieu { get; set; }

    public string? MaNcc { get; set; }

    public decimal DonGia { get; set; }

    public string? MoTa { get; set; }

    public string? HinhAnh { get; set; }

    public decimal DanhGia { get; set; }

    public virtual Ncc? MaNccNavigation { get; set; }

    public virtual ICollection<ProductVariant> ProductVariants { get; set; } = new List<ProductVariant>();
}
