#!bin/bash

DATE=$(date +%F)
LOGSDIR=/tmp
# /home/centos/shellscript-logs/script-name-date.log
SCRIPT_NAME=$0
LOGFILE=$LOGSDIR/$0-$DATE.log
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

if [ $? -ne 0 ]; 
then
    echo " get access with Root user"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ];
    then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}
yum install nginx -y

VALIDATE $? "nginx installed"

systemctl enable nginx
VALIDATE $? "enable Nginx"
systemctl start nginx
VALIDATE $? "start Naginx"
rm -rf /usr/share/nginx/html/*
curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip
cd /usr/share/nginx/html
unzip /tmp/web.zip