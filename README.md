# MariaDB - Backup
This script is to manage backup for MariaDB keeping old backups.

![](mariadb-logo.png)

## Installation

```
su root
mkdir -p /home/bkp-folder
```


## Requirements

```
- MariaDB 10.4 or latest;
```

## How to use?

1. Open the *mariadb-backup.sh*;
2. Change the default variables:

```
-backup_root = /home/backups (root directory for all backups)
-verbose = true (true or false to enable verbose mode)
-keep = 7 (number of old backups to keep)
```

3. Be happy! 😊

## References
- [MariaDB Knowledge](https://mariadb.com/kb/en/)
