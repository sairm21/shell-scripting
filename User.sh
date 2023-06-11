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
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>> /tmp/roboshop.log
cd /app
unzip /tmp/user.zip &>> /tmp/roboshop.log

echo -e "\e[32m download the dependencies\e[0m"
cd /app
npm install &>> /tmp/roboshop.log

echo -e "\e[32m Setup SystemD Catalogue Service\e[0m"
cp /home/centos/shell-scripting/user.service /etc/systemd/system/user.service &>> /tmp/roboshop.log

echo -e "\e[32m Load and start the service\e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log
systemctl enable user &>> /tmp/roboshop.log
systemctl restart user &>> /tmp/roboshop.log


echo -e "\e[32m Copying mongodb repo files\e[0m"
cp /home/centos/shell-scripting/mongodb.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log

echo -e "\e[32m Installing mongodv\e[0m"
yum install mongodb-org-shell -y &>> /tmp/roboshop.log

echo -e "\e[32m Load Schema\e[0m"
mongo --host mongodb-dev.iamadevopsengineer.tech </app/schema/catalogue.js &>> /tmp/roboshop.log

