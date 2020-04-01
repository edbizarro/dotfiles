#!/bin/sh

# Setting this, so the repo does not need to be given on the commandline:
export BORG_REPO=/backups
export BORG_FILES_CACHE_TTL=$(expr `ls /home/* | wc -l` \* 4)

# Setting this, so you won't be asked for your repository passphrase:
# export BORG_PASSPHRASE=''
# or this to ask an external program to supply the passphrase:
# export BORG_PASSCOMMAND='pass show backup'

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup"

# Backup the most important directories into an archive named after
# the machine this script is currently running on:

borg create                                 \
    --verbose                               \
    --filter AME                            \
    --list                                  \
    --stats                                 \
    --show-rc                               \
    --compression zstd                      \
    --exclude-caches                        \
    --exclude '/home/*/.cache/*'            \
    --exclude '/home/*/.npm/*'              \
    --exclude '/home/*/.composer/*'         \
    --exclude '/var/cache/*'                \
    --exclude '/var/lock/*'                 \
    --exclude '/var/tmp/*'                  \
    --exclude '/var/log/*'                  \
    --exclude '/home/edbizarro/workspace/*' \
    --exclude '/home/edbizarro/storage/*'   \
    --exclude '/home/edbizarro/pCloudDrive/*'   \
    --exclude '/home/edbizarro/GoogleDrive/*'   \
    --exclude '/home/edbizarro/.friday/Downloads/*'   \
                                    \
    ::'{hostname}-{now}'            \
    /etc                            \
    /home                           \

backup_exit=$?

info "Pruning repository"

# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --prefix '{hostname}-'          \
    --show-rc                       \
    --keep-daily    5               \

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup and Prune finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup and/or Prune finished with warnings"
else
    info "Backup and/or Prune finished with errors"
fi

# info "Sending to Digital Ocean"

rclone sync -v /backups do:edbizarro-backup --s3-chunk-size=100M --s3-upload-concurrency=10 --create-empty-src-dirs --fast-list

exit ${global_exit}
