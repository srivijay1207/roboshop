#!/bin/bash

USERID=$(id -u)

if [ $? -ne 0 ]; then
echo " pls login with Root user"
exit 10
fi

yum update -y --exclude=kernel*

if [ $? -ne 0 ]; then
echo "Failure install Update"
else
echo "insatalled Yum updated"
fi

yum -y install postfix cyrus-sasl-plain mailx

if [ $? -ne 0 ]; then
echo "install postfix cyrus-sasl-plain mailx"
else
echo "install postfix cyrus-sasl-plain mailx success....!!!!"
fi

systemctl restart postfix
if [ $? -ne 0 ]; then
echo "Restart Postfix Failure..."
else
echo "Restart Postfix successed...!!!!"
fi

systemctl enable postfix
if [ $? -ne 0 ]; then
echo "enable Postfix Failure..."
else
echo "enable Postfix successed...!!!!"
fi

cp main.cf /etc/postfix/sasl_passwd

touch /etc/postfix/sasl_passwd

cp sasl_passwd /etc/postfix/sasl_passwd

postmap /etc/postfix/sasl_passwd

echo "This is a test mail & Date $(date)" | mail -s "message" srivijay1207@gmail.com
