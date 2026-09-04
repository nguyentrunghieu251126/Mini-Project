using System;
using System.Collections.Generic;

namespace Mini_Project.Models;

public partial class Ncc
{
    public int MaNcc { get; set; }

    public string TenNcc { get; set; } = null!;

    public string? SoDienThoai { get; set; }

    public string? DiaChi { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
