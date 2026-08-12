# EvoluX Mobile (evoluxapp)

**EvoluX Mobile** brings a **finance-oriented Linux toolkit** to **Android via Termux**, the same *idea* as running Kali inside Termux — a **proot** environment on your phone — **not** the PC live ISO.

| | **EvoluX (PC)** | **EvoluX Mobile** (this repo) |
|--|-----------------|-------------------------------|
| GitHub | [Wawa1981/evolux](https://github.com/Wawa1981/evolux) | **[Wawa1981/evoluxapp](https://github.com/Wawa1981/evoluxapp)** |
| Form | Bootable **ISO** (Arch, x86_64) | **proot** distro in Termux (aarch64) |
| Desktop | XFCE live | Terminal first (no full desktop in v1) |
| DistroWatch | Target product | Separate mobile kit |

## What you get on the phone

After install (Debian aarch64 base + EvoluX branding + packages):

- **Personal finance CLI** — `ledger`, `qalc`
- **Security** — `gnupg`, `pass`, `tor`, OpenSSH client
- **Dev / data** — `python3`, `pip`, `git`, `curl`
- **Comfort** — `vim`, `htop`, `tmux`, bash completion
- Branding: hostname / MOTD **EvoluX Mobile**

Optional later: Electrum (if available for your arch), VNC desktop (documented limits only).

## Requirements

- Android phone **64-bit ARM** (aarch64) — e.g. moto g54  
- [Termux](https://termux.dev/) from F-Droid (recommended) or official build  
- ~2–4 GB free storage on the phone  
- Internet for the first bootstrap  

## Quick install (in Termux)

```bash
pkg update && pkg install git
git clone https://github.com/Wawa1981/evoluxapp.git
cd evoluxapp
bash scripts/install-in-termux.sh
```

Then:

```bash
proot-distro login evolux
# or: bash scripts/login.sh
evolux-welcome
```

Full guide: **[INSTALL-TERMUX.md](INSTALL-TERMUX.md)**  
Limits: **[docs/LIMITS.md](docs/LIMITS.md)**

## Layout

```text
evoluxapp/
├── README.md
├── INSTALL-TERMUX.md
├── scripts/install-in-termux.sh   # main installer (Termux)
├── scripts/login.sh
├── bootstrap/packages.txt
├── bootstrap/post-install.sh      # runs inside the proot as root
├── branding/motd
├── proot-distro/evolux.sh         # optional custom plugin notes
└── docs/LIMITS.md
```

## Relation to the PC distro

The **PC ISO** (`evolux-*-x86_64.iso`) does **not** run inside Termux.  
This repo is the **mobile path**. Same brand, different delivery.

## License

MIT — see [LICENSE](LICENSE).
