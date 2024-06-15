#/bin/bash

#################
#  gergilim123  #
#################


#Set Variables

export date=$(date +%d%m%y%H%M)
export src="/mnt/source"
export dest="/mnt/destination"
export log_file="/var/log/backup-rsync/backup-name.log-$date"
export log_status="/var/log/backup-rsync/status.log-$date"

#Start Clock
export start_time=$(date +%s)

#Calculating folder size before Backup
export backupsizebegin=$(du -ms "$src" | cut -f1)

#Run backup with rsync and redirect output to log file
rsync -v -rhlt "$src" "$dest" > $log_file

#Calculate folder size after Backup
export backupsizeend=$(du -ms "$src" | cut -f1)

#Stop Clock
export end_time=$(date +%s)
export elapsed_time=$((end_time - start_time))

#Verification
if [ $? -eq 0 ]; then
    backup_status="Successful"
else
    backup_status="Failed"
fi

echo "Status: $backup_status" >> "$log_status"
echo "Execution time: $elapsed_time seconds" >> "$log_status"
echo "Initial folder size: $backupsizebegin" >> "$log_status"
echo "Final folder size: $backupsizeend" >> "$log_status"
echo -e "File List:\n$(head -n 30 "$log_file")" >> "$log_status"

#Mail configuration

export smtpemailfrom=source@yourmail.com
export zabbixemailto=destionation@yourmail.com
export zabbixsubject="NameYourBackup"
export smtpserver=mail.smtpserver:587
export smtplogin=source@yourmail.com
export smtppass=password
export smtpauth="tls=no"
export smtplog="/var/log/backup-rsync/email.log-$date"
export mailbody="message-file=/var/log/backup-rsync/status.log-$date"
export anexo="/var/log/backup-rsync/backup-name.log-$date"

/root/scripts/sendEmail -f $smtpemailfrom -t $zabbixemailto -u $zabbixsubject -s $smtpserver -o $smtpauth -o $mailbody -xu $smtplogin -xp $smtppass -l $smtplog -a $anexo > $smtplog
