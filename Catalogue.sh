echo -e "\e[32m Setup NodeJS repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash #&>> /dev/null

echo -e "\e[32m Install NodeJS\e[0m"
yum install nodejs -y #&>> /dev/null

echo -e "\e[32m Adding application User\e[0m"
useradd roboshop #&>> /dev/null

echo -e "\e[32m setup an app directory\e[0m"
rm -rf /app #&>> /dev/null
mkdir /app

echo -e "\e[32m Download the application code to created app directory\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip #&>> /dev/null
cd /app
unzip /tmp/catalogue.zip #&>> /dev/null

echo -e "\e[32m download the dependencies\e[0m"
cd /app
npm install #&>> /dev/null

echo -e "\e[32m Setup SystemD Catalogue Service\e[0m"
cp /home/centos/shell-scripting/catalogue.service /etc/systemd/system/catalogue.service #&>> /dev/null

echo -e "\e[32m Load and start the service\e[0m"
systemctl daemon-reload #&>> /dev/null
systemctl enable catalogue #&>> /dev/null
systemctl start catalogue #&>> /dev/null

echo -e "\e[32m Copying mongodb repo files\e[0m"
cp /home/centos/shell-scripting/mongodb.repo /etc/yum.repos.d/mongo.repo #&>> /dev/null

echo -e "\e[32m Installing mongodv\e[0m"
yum install mongodb-org-shell -y #&>> /dev/null

echo -e "\e[32m Load Schema\e[0m"
mongo --host mongodb-dev.iamadevopsengineer.tech </app/schema/catalogue.js #&>> /dev/null

