using System;
using System.Collections.Generic;

namespace Mini_Project.Models;

public partial class Account
{
    public int MaTaiKhoan { get; set; }

    public string TaiKhoan { get; set; } = null!;

    public string MatKhau { get; set; } = null!;

    public string HoTen { get; set; } = null!;

    public string? SoDienThoai { get; set; }

    public string? Email { get; set; }

    public int TongDiem { get; set; }

    public virtual ICollection<Address> Addresses { get; set; } = new List<Address>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual ICollection<RewardHistory> RewardHistories { get; set; } = new List<RewardHistory>();
}
