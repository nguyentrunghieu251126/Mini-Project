using System;
using System.Collections.Generic;

namespace Mini_Project.Models;

public partial class RewardHistory
{
    public int MaLichSu { get; set; }

    public int? MaTaiKhoan { get; set; }

    public string? MaDonHang { get; set; }

    public string? LoaiGiaoDich { get; set; }

    public int SoDiem { get; set; }

    public string? MoTa { get; set; }

    public DateTime? NgayGiaoDich { get; set; }

    public virtual Order? MaDonHangNavigation { get; set; }

    public virtual Account? MaTaiKhoanNavigation { get; set; }
}
