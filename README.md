# 🚀 GRE Tunnel Manager

**A clean, persistent & easy-to-use GRE Tunnel setup tool**

[![Bash](https://img.shields.io/badge/Bash-4%2B-green?style=flat-square&logo=gnu-bash)](https://www.gnu.org/software/bash/)
[![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Linux-orange?style=flat-square&logo=linux)]()

---

### ✨ Features

- Beautiful interactive menu with colors
- Fully persistent (survives reboot using systemd)
- Clean and complete removal option
- Simple one-command installation from GitHub
- Supports both Iran ↔ Outside server setup
- Automatic validation of IP addresses

---

### 📦 Requirements

- Root access
- Linux with `iproute2` and `systemd`
- `curl` (for one-liner installation)

---

### ⚡ One-Command Installation

```bash
bash <(curl -sL https://raw.githubusercontent.com/20elias01/GRE/main/gre-setup.sh)
