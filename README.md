# Automatic Backup Script for TrueNAS Server
This script is designed for Linux servers, allowing you to send files to your TrueNAS server.

In addition to copying files with Rsync, it will also send an email with summarized backup information.

Email Sending Credits: Written by: Brandon Zehm caspian@dotconf.net

# Setup Instructions:

1 - Create a Backup Directory:

    Within the TrueNAS shell, create a new directory for backups. It's ideal to use a location under /mnt.

2 - Configure Rsync Module:

    Navigate to Services -> Rsync -> Add to create a new module.
    You can restrict access by specifying the source IP for security purposes.

3 - Generate RSA Key on Host Server:

    Execute ssh-keygen command to generate an RSA key on the host server.

4 - Copy and Paste the Key:

    Copy the generated RSA key and paste it into the Authentication section of Accounts -> Users -> Root in TrueNAS.

5 - Send Files to Host Server:

    Install the sendemail and perl packages on the host server.
    Upload "sendEmail" "sendEmail.pl" "script-rsync.sh" files to the server.

6 - Create Log Folder:

    Don't forget to create a folder for logs: 'mkdir /var/log/backup-rsync.'

7 - Configure Cron Job:

    Configure the script to run automatically using the Linux task scheduler (crontab).
    Edit /etc/crontab to add the script execution schedule.

Usage:

Make sure to edit the script with your specific needs and email login credentials before use.
Set up the script as a routine task in /etc/crontab for automatic execution.



---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Feel free to customize the formatting or wording further if needed!
