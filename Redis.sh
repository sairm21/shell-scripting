source common.sh

echo -e "${colour} Installing redis repo file${nocolour}"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> ${log_file}
stat_check $?

echo -e "${colour} Enable Redis 6.2 from package streams${nocolour}"
yum module enable redis:remi-6.2 -y &>> ${log_file}
stat_check $?

echo -e "${colour} Install Redis${nocolour}"
yum install redis -y &>> ${log_file}
stat_check $?

echo -e "${colour} Update listen address from 127.0.0.1 to 0.0.0.0 ${nocolour}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>> ${log_file}
stat_check $?

echo -e "${colour} Enable and Restart redis${nocolour}"
systemctl enable redis &>> ${log_file}
systemctl restart redis &>> ${log_file}
stat_check $?