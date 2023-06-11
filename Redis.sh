echo -e "\e[32m Installing redis repo file\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> /tmp/roboshop.log

echo -e "\e[32m Enable Redis 6.2 from package streams\e[0m"
yum module enable redis:remi-6.2 -y &>> /tmp/roboshop.log

echo -e "\e[32m Install Redis\e[0m"
yum install redis -y &>> /tmp/roboshop.log

echo -e "\e[32m Update listen address from 127.0.0.1 to 0.0.0.0 \e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>> /tmp/roboshop.log

echo -e "\e[32m Enable and Restart redis\e[0m"
systemctl enable redis &>> /tmp/roboshop.log
systemctl restart redis &>> /tmp/roboshop.log