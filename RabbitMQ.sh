echo -e "\e[32m Configure YUM Repos \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>> /tmp/roboshop.log

echo -e "\e[32m Configure YUM Repos for RabbitMQ \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>> /tmp/roboshop.log

echo -e "\e[32m Install RabbitMQ \e[0m"
yum install rabbitmq-server -y &>> /tmp/roboshop.log

echo -e "\e[32m Start and enable RabbitMQ Service\e[0m"
systemctl enable rabbitmq-server &>> /tmp/roboshop.log
systemctl start rabbitmq-server &>> /tmp/roboshop.log

echo -e "\e[32m creating user and setting permissions\e[0m"
rabbitmqctl add_user roboshop $1 &>> /tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> /tmp/roboshop.log
