#!/bin/bash
#===============================================================
# NAME      :  mariadb-backup.sh
# Programmer:  Raul Neiva
# Date      :  20-Feb-2021
# Purpose   :  Simple backup script for MariaDB backups + keep old files on Linux
# Changes history:
#
#  Date     |     By        | Changes/New features
# ----------+---------------+-----------------------------------
# 15-02-21    Raul Neiva       Initial version
#===============================================================

#===========================================
# Colors
#===========================================

export RED=$(tput setaf 1)
export BGRED=$(tput setab 1)
export GREEN=$(tput setaf 2)
export BLDGREEN=$(tput bold)$(tput setaf 2)
export YELLOW=$(tput setaf 3)
export BLDYELLOW=$(tput bold)$(tput setaf 3)
export BLUE=$(tput setaf 4)
export BLDBLUE=$(tput bold)$(tput setaf 4)
export PURPLE=$(tput setaf 5)
export CYAN=$(tput setaf 6)
export WHITE=$(tput setaf 7)
export BOLD=$(tput bold)
export NORMAL=$(tput sgr0)

#===========================================
# Main
#===========================================

# Email for notifications
email=email@email.com

# set default variables
backup_root=/srv/backups/mariadb	# root directory for all backups
v=true					                  # verbose output
keep=7					                  # number of old backups to keep
hash=sha256				                # crypto hash to use for checksums

# set mysqldump options
dumpopts='--single-transaction --flush-logs --flush-privileges'

## don't edit below this line

# get our options
while getopts qk:h: opt; do
  case $opt in
  q)
      v=false
      ;;
  k)
      keep=$OPTARG 
      ;;
  h)
      hash=$OPTARG 
      ;;
  esac
done
shift $((OPTIND - 1))

# set a righteous mask
umask 0027

# create backup path
stamp=`date +%Y-%m-%d.%H%M%S`
backup_dir=${backup_root}/${stamp}
mkdir -p ${backup_dir}
$v && printf 'Keeping %s backups.\n' $keep
$v && printf 'Backup location: %s\n' $backup_dir

## set some functions

# get a list of databases to backup (strip out garbage and internal databases)
_get_db_list () {
  mysqlshow | \
    sed -r '/Databases|information_schema|performance_schema/d' | \
    awk '{ print $2 }'
}

# get a list of backups in the backup directory, ignore files and links
# make this a pattern match later
_get_backups () {
  (cd $backup_root && find ./* -maxdepth 1 -type d -exec basename {} \;)
}

# dump database
_dump_db () {
   nice -n 19 mysqldump $dumpopts $1 | nice -n 19 gzip
}

# create checksums
_checksum () {
  sum=`openssl $hash $1 | cut -d' ' -f2`
  printf '%s %s\n' $sum `basename $1`
}

# get the database list and remove garbage
db_list=`_get_db_list`

# run the backup
for db in $db_list; do
   $v && printf 'Backing up "%s" database...' $db
   _dump_db $db > ${backup_dir}/${db}.sql.gz
   _checksum ${backup_dir}/${db}.sql.gz >> ${backup_dir}/${hash^^}SUMS
   $v &&printf ' done.\n'
   echo "MySQL backup is completed! Backup name is ${db}.sql.gz" | mail -s "MySQL backup" ${email}
done

# create a link to current backup
(cd $backup_root && rm -f latest && ln -s ${stamp} latest)

# find out how many backup directories are in the root
dirnum=`_get_backups | wc -l`
diff=$(expr $dirnum - $keep)

# figure out if we need to delete any old backups
if [ "$diff" -gt "0" ]; then
  $v && printf 'Removing %s old backup(s):\n' $diff
  for d in `_get_backups | sort | head -n $diff`; do
    $v && printf '  %s\n' $d
    rm -rf ${backup_root}/${d}
    echo "Old backups was removed!" | mail -s "MySQL backup cleanup" ${email}
  done
else
  $v && printf 'No old backups to remove (found %s).\n' $dirnum
fi