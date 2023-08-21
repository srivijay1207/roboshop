#!/bin/bash

DATE=$(date +%F)
LOGSDIR=/tmp
# /home/centos/shellscript-logs/script-name-date.log
SCRIPT_NAME=$0
LOGFILE=$LOGSDIR/$0-$DATE.log
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

if [ $USERID -ne 0 ];
then
    echo -e "$R ERROR:: Please login with root access"
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

cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE

VALIDATE $? "copied from mongo repo"

yum install mongodb-org -y &>> $LOGFILE
VALIDATE $? "install mongodb-org....!!!!"
systemctl enable mongod &>> $LOGFILE
VALIDATE $? "enable mongodb"
systemctl start mongod &>> $LOGFILE
VALIDATE $? "start mongodb"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>> $LOGFILE
VALIDATE $? "ip config"
systemctl restart mongod &>> $LOGFILE
VALIDATE $? "Restart"