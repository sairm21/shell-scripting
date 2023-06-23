source common.sh

echo -e "${colour} Configure YUM Repos ${nocolour}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>> ${log_file}
stat_check $?

echo -e "${colour} Configure YUM Repos for RabbitMQ ${nocolour}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>> ${log_file}
stat_check $?

echo -e "${colour} Install RabbitMQ ${nocolour}"
yum install rabbitmq-server -y &>> ${log_file}
stat_check $?

echo -e "${colour} Start and enable RabbitMQ Service${nocolour}"
systemctl enable rabbitmq-server &>> ${log_file}
systemctl start rabbitmq-server &>> ${log_file}
stat_check $?

echo -e "${colour} creating user and setting permissions${nocolour}"
rabbitmqctl add_user roboshop $1 &>> ${log_file}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> ${log_file}
stat_check $?