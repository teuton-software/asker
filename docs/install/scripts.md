
[<< back](README.md)

# Using installation scripts

## GNU/Linux installation script

Run as `root` user:
```
wget -qO- https://raw.githubusercontent.com/dvarrui/asker/master/bin/linux_asker_install.sh | bash
```

Run `asker version` as normal user.

| Tested on | OS version  | Ruby version |
| --------- | ----------- | ------------ |
| OpenSUSE  | TW, Leap 15 | 2.6          |
| Debian    | 9           | 2.3          |
| Mint      | 19          | 2.5          |
| Ubuntu    | 18          |              |

## Windows installation script

Requirements:
* Windows 7+ / Windows Server 2003+
* PowerShell v2+

Run this coomand as Administrator user on PowerShell (PS):
```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/dvarrui/asker/master/bin/windows_asker_install.ps1'))
```

Run `asker version` as normal user.
