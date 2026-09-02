// Load dữ liệu và khởi chạy các chức năng
document.addEventListener("DOMContentLoaded", initPage);

async function initPage() {
  khoiTaoHieuUngXuatHien(); // data-reveal: Giúp phần tử mờ mờ rồi trượt lên khi lướt tới
  khoiTaoTheoDoiSoDem(); // data-counter: Hiệu ứng số đếm tăng dần từ 0 lên con số mục tiêu
}

// Biến toàn cục
let revealObserver = null; // khoiTaoHieuUngXuatHien
let counterObserver = null; // khoiTaoTheoDoiSoDem

// Khởi tạo hiệu ứng cho các item khi xuất hiện
function khoiTaoHieuUngXuatHien() {
  if (!("IntersectionObserver" in window)) {
    document.querySelectorAll("[data-reveal]").forEach((element) => {
      element.classList.add("is-visible");
    });
    return;
  }

  revealObserver = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (!entry.isIntersecting) return;
        entry.target.classList.add("is-visible");
        revealObserver.unobserve(entry.target);
      });
    },
    {
      threshold: 0.18,
      rootMargin: "0px 0px -20px 0px",
    },
  );

  theoDoiPhanTuCanXuatHien(document);
}

// Theo dõi các phần tử cần xuất hiện để tạo hiệu ứng
function theoDoiPhanTuCanXuatHien(root) {
  const targets = root.querySelectorAll ? root.querySelectorAll("[data-reveal]") : [];

  targets.forEach((element) => {
    if (!revealObserver) {
      element.classList.add("is-visible");
      return;
    }
    revealObserver.observe(element);
  });
}

// Khởi tạo bộ theo dõi cho các con số
function khoiTaoTheoDoiSoDem() {
  const counters = document.querySelectorAll("[data-counter]");

  if (!counters.length) return;

  if (!("IntersectionObserver" in window)) {
    counters.forEach((counter) => taoHieuUngTangSo(counter));
    return;
  }

  counterObserver = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (!entry.isIntersecting) return;

        taoHieuUngTangSo(entry.target);

        counterObserver.unobserve(entry.target);
      });
    },
    {
      threshold: 0.5,
    },
  );

  counters.forEach((counter) => counterObserver.observe(counter));
}

// Tạo hiệu ứng tăng số từ 0 lên giá trị mục tiêu
function taoHieuUngTangSo(counter) {
  const target = Number(counter.dataset.counter || 0);
  // Thời gian chạy hiệu ứng (1.4 giây)
  const duration = 1400;
  const startTime = performance.now();

  const update = (currentTime) => {
    const progress = Math.min((currentTime - startTime) / duration, 1);
    const eased = 1 - Math.pow(1 - progress, 3);
    const value = Math.round(target * eased);
    counter.textContent = value;

    if (progress < 1) {
      requestAnimationFrame(update);
    } else {
      counter.textContent = target;
    }
  };
  requestAnimationFrame(update);
}
