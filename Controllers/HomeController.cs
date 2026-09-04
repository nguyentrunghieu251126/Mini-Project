using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Mini_Project.Models;

namespace Mini_Project.Controllers;

public class HomeController : Controller
{
    private readonly TechnologyDeviceStoreContext _context;
    public HomeController(TechnologyDeviceStoreContext context)
    {
        _context = context;
    }

    public IActionResult Index()
    {
        // Lấy danh sách sản phẩm và truyền sang View
        var products = _context.Products.ToList();
        return View(products);
    }

    public IActionResult Privacy()
    {
        return View();
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}
