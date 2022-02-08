
[<< back](README.md)

# Installation scripts

---
## GNU/Linux

**Install**: Run as `root` user.
```
wget -qO- https://raw.githubusercontent.com/dvarrui/asker/master/install/linux/install_asker.sh | bash
```

Run `asker version` as normal user.

**Uninstall**: Run as `root` user.
```
wget -qO- https://raw.githubusercontent.com/dvarrui/asker/master/install/linux/uninstall_asker.sh | bash
```

---
## Windows

Requirements:
* Windows 7+ / Windows Server 2003+
* PowerShell v2+

**Install**: Run this coomand as Administrator user on PowerShell (PS):
```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/dvarrui/asker/master/install/windows/install_asker.ps1'))
```

Run `asker version` as normal user.

**Uninstall**: Run this coomand as Administrator user on PowerShell (PS):

```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/dvarrui/asker/master/install/windows/uninstall_asker.ps1'))
```
