# MariaDB - Backup
> This script was created by ![@Raul Neiva](raulneivaweb@gmail.com) - Powered by ![@Devvos TI](https://devvos.com.br).

[![NPM Version][npm-image]][npm-url]
[![Build Status][travis-image]][travis-url]
[![Downloads Stats][npm-downloads]][npm-url]

This script is to manage backup for MariaDB and keeping old backups.

![](mariadb-logo.png)

## Installation

```
su root
git clone https://github.com/rneiva/mariadb.git
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
-backup_root=/home/backups (root directory for all backups)
-verbose=true (true or false to enable verbose mode)
-keep=7 (number of old backups to keep)
```

3. Be happy! 😊

## References
- [MariaDB Knowledge](https://mariadb.com/kb/en/)

<!-- Markdown link & img dfn's -->
[npm-image]: https://img.shields.io/npm/v/datadog-metrics.svg?style=flat-square
[npm-url]: https://npmjs.org/package/datadog-metrics
[npm-downloads]: https://img.shields.io/npm/dm/datadog-metrics.svg?style=flat-square
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
