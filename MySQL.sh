source common.sh

echo -e "${colour} disable MySQL 8 version.${nocolour}"
yum module disable mysql -y &>> ${log_file}
stat_check $?

echo -e "${colour} Setup the MySQL5.7 repo file.${nocolour}"
cp /home/centos/shell-scripting/mysql.repo /etc/yum.repos.d/mysql.repo &>> ${log_file}
stat_check $?

echo -e "${colour} Install MySQL Server.${nocolour}"
yum install mysql-community-server -y &>> ${log_file}
stat_check $?

echo -e "${colour} Start  and enable MySQL Service.${nocolour}"
systemctl enable mysqld &>> ${log_file}
systemctl restart mysqld &>> ${log_file}
stat_check $?

echo -e "${colour} changing root credentials.${nocolour}"
mysql_secure_installation --set-root-pass $1 &>> ${log_file}
stat_check $?
