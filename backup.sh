#!/bin/bash

########################################
# Automated Backup Script for EC2
# Sends directory backup to AWS S3
# Logs success/failure
########################################

SOURCE_DIR="/home/ubuntu/data"
BACKUP_NAME="backup-$(date +%Y-%m-%d_%H-%M-%S).tar.gz"
TEMP_BACKUP="/tmp/$BACKUP_NAME"
S3_BUCKET="s3://my-ec2-backups-12345"
LOG_FILE="/home/ubuntu/backup-report.log"

echo "----------------------------------------" >> $LOG_FILE
echo "Backup started at: $(date)" >> $LOG_FILE

# Step 1: Create tar archive
tar -czf $TEMP_BACKUP $SOURCE_DIR

if [ $? -eq 0 ]; then
    echo "[OK] Tar file created: $TEMP_BACKUP" >> $LOG_FILE
else
    echo "[ERROR] Failed to create tar file" >> $LOG_FILE
    exit 1
fi

# Step 2: Upload to S3
aws s3 cp $TEMP_BACKUP $S3_BUCKET

if [ $? -eq 0 ]; then
    echo "[OK] Uploaded to S3 bucket: $S3_BUCKET" >> $LOG_FILE
else
    echo "[ERROR] Upload to S3 FAILED" >> $LOG_FILE
    exit 1
fi

# Step 3: Cleanup temporary file
rm $TEMP_BACKUP

echo "[DONE] Backup completed successfully at: $(date)" >> $LOG_FILE
echo "----------------------------------------" >> $LOG_FILE
