echo -e "\e[32m disable MySQL 8 version.\e[0m"
yum module disable mysql -y &>> /tmp/roboshop.log

echo -e "\e[32m Setup the MySQL5.7 repo file.\e[0m"
cp /home/centos/shell-scripting/mysql.repo /etc/yum.repos.d/mysql.repo &>> /tmp/roboshop.log

echo -e "\e[32m Install MySQL Server.\e[0m"
yum install mysql-community-server -y &>> /tmp/roboshop.log

echo -e "\e[32m Start  and enable MySQL Service.\e[0m"
systemctl enable mysqld &>> /tmp/roboshop.log
systemctl restart mysqld &>> /tmp/roboshop.log

echo -e "\e[32m changing root credentials.\e[0m"
mysql_secure_installation --set-root-pass $1 &>> /tmp/roboshop.log

