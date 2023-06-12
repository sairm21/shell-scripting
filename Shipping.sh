echo -e "\e[32m install maven \e[0m"
yum install maven -y &>> /tmp/roboshop.log

echo -e "\e[32m Add application User\e[0m"
useradd roboshop &>> /tmp/roboshop.log

echo -e "\e[32m setup an app directory\e[0m"
rm -rf /app &>> /tmp/roboshop.log
mkdir /app &>> /tmp/roboshop.log

echo -e "\e[32m Download the application code to created app directory\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>> /tmp/roboshop.log
cd /app &>> /tmp/roboshop.log
unzip /tmp/shipping.zip &>> /tmp/roboshop.log

echo -e "\e[32m download the dependencies & build the application\e[0m"
cd /app &>> /tmp/roboshop.log
mvn clean package &>> /tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>> /tmp/roboshop.log

echo -e "\e[32m Setup SystemD Shipping Service\e[0m"
cp /home/centos/shell-scripting/shipping.service /etc/systemd/system/shipping.service &>> /tmp/roboshop.log

echo -e "\e[32m mysql installation\e[0m"
yum install mysql -y &>> /tmp/roboshop.log

echo -e "\e[32m Load Schema\e[0m"
mysql -h mysql-dev.iamadevopsengineer.tech -uroot -pRoboShop@1 < /app/schema/shipping.sql &>> /tmp/roboshop.log

echo -e "\e[32m Load the service\e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log

echo -e "\e[32m Enable and Start the service\e[0m"
systemctl enable shipping &>> /tmp/roboshop.log
systemctl restart shipping &>> /tmp/roboshop.log
