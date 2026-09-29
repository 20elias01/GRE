# 🚀 GRE Tunnel Manager

<p align="center">
  <a href="#-english-version">English</a> •
  <a href="#-نسخه-فارسی">فارسی</a>
</p>

---

# 🇬🇧 English Version

**A clean, persistent & key-based GRE Tunnel setup tool**

[![Bash](https://img.shields.io/badge/Bash-4%2B-green?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-orange?style=for-the-badge&logo=linux&logoColor=white)]()
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)

### ✨ Features

- Beautiful interactive colored menu
- Fully persistent (survives reboot via systemd)
- Smart Key system (no need to re-enter IPs on the second server)
- One-command installation from GitHub
- Clean & complete removal option
- Automatic IP validation

### ⚡ One-Command Installation

```bash
bash <(curl -sL https://raw.githubusercontent.com/20elias01/GRE/main/gre-setup.sh)
🖥️ How to Use

Run the script on the Iran server → Choose option 1
Copy the generated Connection Key
Run the script on the Outside server → Choose option 2 and paste the key
Done!

After Setup:

Iran side shows the destination IPv6
Outside side automatically tests the connection with 4 pings

🗑️ Complete Removal
Run the script again and choose option 3.

It completely removes the tunnel, service, and all traces.
📝 Technical Notes

Tunnel IPv6 addresses:
Iran: fd00:1::1/64
Outside: fd00:1::2/64

Protocol 47 (GRE) must be allowed in firewall
Must be run as root


🇮🇷 نسخه فارسی
ابزاری تمیز، پایدار و مبتنی بر کلید برای راه‌اندازی تونل GRE
✨ ویژگی‌ها

منوی رنگی و زیبای تعاملی
کاملاً پایدار (بعد از ریبوت هم باقی می‌ماند)
سیستم کلید هوشمند (نیازی به وارد کردن مجدد IP در سرور دوم نیست)
نصب با یک دستور از گیت‌هاب
گزینه حذف کامل و تمیز
اعتبارسنجی خودکار آدرس IP

⚡ نصب سریع با یک دستور
Bashbash <(curl -sL https://raw.githubusercontent.com/20elias01/GRE/main/gre-setup.sh)
🖥️ نحوه استفاده

اسکریپت را روی سرور ایران اجرا کنید → گزینه 1 را انتخاب کنید
کلید اتصال تولید شده را کپی کنید
اسکریپت را روی سرور خارج اجرا کنید → گزینه 2 را انتخاب کرده و کلید را وارد کنید
تمام!

بعد از راه‌اندازی:

سمت ایران آدرس IPv6 مقصد را نمایش می‌دهد
سمت خارج به صورت خودکار ۴ پینگ تست می‌گیرد

🗑️ حذف کامل
دوباره اسکریپت را اجرا کرده و گزینه 3 را انتخاب کنید.

تونل، سرویس و تمام آثار آن به طور کامل پاک می‌شود.
📝 نکات فنی

آدرس‌های IPv6 داخل تونل:
ایران: fd00:1::1/64
خارج: fd00:1::2/64

پروتکل ۴۷ (GRE) باید در فایروال باز باشد
اسکریپت باید با دسترسی root اجرا شود



  ساخته شده با ❤️ توسط EliasVPN

  Made with ❤️ by EliasVPN

```
