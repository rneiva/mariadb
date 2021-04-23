# MariaDB - Backup
This script is to manage backup for MariaDB keeping old backups.


- [https://mariadb.com/kb/en/] (https://mariadb.com/kb/en/)

## Requirements

```
- Root Account
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
