# 🚀 مدیریت تونل GRE-IPv6Local

<p align="center">
  <a href="./README.md">
    <img src="https://img.shields.io/badge/🇬🇧_English_Version-blue?style=for-the-badge" alt="English Version">
  </a>
</p>

**ابزاری تمیز، پایدار و مبتنی بر کلید برای راه‌اندازی تونل GRE**

[![Bash](https://img.shields.io/badge/Bash-4%2B-green?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-orange?style=for-the-badge&logo=linux&logoColor=white)]()
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)

### ✨ ویژگی‌ها

- منوی رنگی و زیبای تعاملی
- کاملاً پایدار (بعد از ریبوت هم باقی می‌ماند)
- سیستم کلید هوشمند (نیازی به وارد کردن مجدد IP در سرور دوم نیست)
- نصب با یک دستور از گیت‌هاب
- گزینه حذف کامل و تمیز
- اعتبارسنجی خودکار آدرس IP

### ⚡ نصب سریع با یک دستور

```bash
bash <(curl -sL https://raw.githubusercontent.com/20elias01/GRE-IPv6Local/main/gre-setup.sh)
```

### 🖥️ نحوه استفاده

1. اسکریپت را روی **سرور ایران** اجرا کنید → گزینه `1` را انتخاب کنید
2. **کلید اتصال** تولید شده را کپی کنید
3. اسکریپت را روی **سرور خارج** اجرا کنید → گزینه `2` را انتخاب کرده و کلید را وارد کنید
4. تمام!

#### بعد از راه‌اندازی:
- سمت ایران آدرس IPv6 مقصد را نمایش می‌دهد
- سمت خارج به صورت خودکار ۴ پینگ تست می‌گیرد

### 🗑️ حذف کامل

دوباره اسکریپت را اجرا کرده و گزینه `3` را انتخاب کنید.  
تونل، سرویس و تمام آثار آن به طور کامل پاک می‌شود.

### 📝 نکات فنی

- آدرس‌های IPv6 داخل تونل:
  - ایران: `fd00:1::1/64`
  - خارج: `fd00:1::2/64`
- پروتکل **۴۷ (GRE)** باید در فایروال باز باشد
- اسکریپت باید با دسترسی **root** اجرا شود

---

<p align="center">
  <b>ساخته شده با ❤️ توسط EliasVPN</b>
</p>
