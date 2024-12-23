#!/bin/bash

# Usage: ./backup.sh /path/to/directory

SOURCE_DIR=$1
BACKUP_ROOT="/home/aungmyomyat/backups"  # Set a root directory for all backups
TIMESTAMP=$(date +'%Y%m%d%H%M%S')
BACKUP_DIR="$BACKUP_ROOT/$(basename "$SOURCE_DIR")-$TIMESTAMP"
LOG_FILE="$BACKUP_ROOT/backup_log.txt"

# Ensure the backup root directory exists
mkdir -p "$BACKUP_ROOT"

# Check if source directory exists
if [ -d "$SOURCE_DIR" ]; then
    cp -r "$SOURCE_DIR" "$BACKUP_DIR"
else
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Error: Directory $SOURCE_DIR does not exist." | tee -a "$LOG_FILE"
fi









