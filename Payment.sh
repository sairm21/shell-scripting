echo -e "\e[32m Install Python 3.6 \e[0m"
yum install python36 gcc python3-devel -y &>> /tmp/roboshop.log

echo -e "\e[32m Add application User \e[0m"
useradd roboshop &>> /tmp/roboshop.log

echo -e "\e[32m Lets setup an app directory \e[0m"
rm -rf /app &>> /tmp/roboshop.log
mkdir /app &>> /tmp/roboshop.log

echo -e "\e[32m Download the application code to created app directory \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>> /tmp/roboshop.log
cd /app &>> /tmp/roboshop.log
unzip /tmp/payment.zip &>> /tmp/roboshop.log

echo -e "\e[32m download the dependencies. \e[0m"
cd /app &>> /tmp/roboshop.log
pip3.6 install -r requirements.txt &>> /tmp/roboshop.log

echo -e "\e[32m Setup SystemD Payment Service \e[0m"
cp /home/centos/shell-scripting/payment.service /etc/systemd/system/payment.service &>> /tmp/roboshop.log

echo -e "\e[32m Load the service. \e[0m"
systemctl daemon-reload &>> /tmp/roboshop.log

echo -e "\e[32m enable and reStart the service. \e[0m"
systemctl enable payment &>> /tmp/roboshop.log
systemctl restart payment &>> /tmp/roboshop.log

