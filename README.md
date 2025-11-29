# Automated Backup Solution

## Project Overview
This project automates backups of a specified directory on an EC2 instance to an AWS S3 bucket. 
The script creates a tar archive of the directory, uploads it to S3, and generates a log of 
success or failure events.

## Features
- Backs up `/home/ubuntu/data` directory
- Uploads backups to S3 bucket (`my-ec2-backups-12345`)
- Generates a timestamped log file (`backup-report.log`)
- Fully automated using cron

## Setup Instructions

### 1. Launch EC2 Instance
- Ubuntu Server 22.04 LTS
- Configure SSH key pair
- Minimum instance type: t2.micro (free tier) or larger

### 2. Install Dependencies
```bash
sudo apt update
sudo apt install unzip -y
