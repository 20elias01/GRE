# 🚀 GRE-IPv6Local Tunnel Manager

<p align="center">
  <a href="./README.fa.md">
    <img src="https://img.shields.io/badge/🇮🇷_نسخه_فارسی-Persian-red?style=for-the-badge" alt="Persian Version">
  </a>
</p>

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
```

### 🖥️ How to Use

1. Run the script on the **Iran** server → Choose option `1`
2. Copy the generated **Connection Key**
3. Run the script on the **Outside** server → Choose option `2` and paste the key
4. Done!

#### After Setup:
- Iran side shows the destination IPv6
- Outside side automatically tests the connection with 4 pings

### 🗑️ Complete Removal

Run the script again and choose option `3`.  
It completely removes the tunnel, service, and all traces.

### 📝 Technical Notes

- Tunnel IPv6 addresses:
  - Iran: `fd00:1::1/64`
  - Outside: `fd00:1::2/64`
- Protocol **47 (GRE)** must be allowed in firewall
- Must be run as **root**

---

<p align="center">
  <b>Made with ❤️ by EliasVPN</b>
</p>
