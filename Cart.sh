echo -e "\e[32m Setup NodeJS repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/roboshop.log

echo -e "\e[32m Install NodeJS\e[0m"
yum install nodejs -y &>> /tmp/roboshop.log

echo -e "\e[32m Adding application User\e[0m"
useradd roboshop &>> /tmp/roboshop.log

echo -e "\e[32m setup an app directory\e[0m"
rm -rf /app &>> /tmp/roboshop.log
mkdir /app

echo -e "\e[32m Download the application code to created app directory\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>> /tmp/roboshop.log
cd /app
unzip /tmp/cart.zip &>> /tmp/roboshop.log

echo -e "\e[32m download the dependencies\e[0m"
cd /app
npm install &>> /tmp/roboshop.log

echo -e "\e[32m Setup SystemD Catalogue Service\e[0m"
cp /home/centos/shell-scripting/cart.service /etc/systemd/system/cart.service &>> /tmp/roboshop.log

echo -e "\e[32m Load and start the service\e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log
systemctl enable cart &>> /tmp/roboshop.log
systemctl restart cart &>> /tmp/roboshop.log
