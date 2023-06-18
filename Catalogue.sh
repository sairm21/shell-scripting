component=catalogue
colour="\e[34m"
nocolour="\e[0m"

echo -e "${colour} Setup NodeJS repos${nocolour}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /dev/null

echo -e "${colour} Install NodeJS${nocolour}"
yum install nodejs -y &>> /dev/null

echo -e "${colour} Adding application User${nocolour}"
useradd roboshop &>> /dev/null

echo -e "${colour} setup an app directory${nocolour}"
rm -rf /app &>> /dev/null
mkdir /app

echo -e "${colour} Download the application code to created app directory${nocolour}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>> /dev/null
cd /app
unzip /tmp/$component.zip &>> /dev/null

echo -e "${colour} download the dependencies${nocolour}"
cd /app
npm install &>> /dev/null

echo -e "${colour} Setup SystemD $component Service${nocolour}"
cp /home/centos/shell-scripting/$component.service /etc/systemd/system/$component.service &>> /dev/null

echo -e "${colour} Load and start the service${nocolour}"
systemctl daemon-reload &>> /dev/null
systemctl enable $component &>> /dev/null
systemctl start $component &>> /dev/null

echo -e "${colour} Copying mongodb repo files${nocolour}"
cp /home/centos/shell-scripting/mongodb.repo /etc/yum.repos.d/mongo.repo &>> /dev/null

echo -e "${colour} Installing mongodv${nocolour}"
yum install mongodb-org-shell -y &>> /dev/null

echo -e "${colour} Load Schema${nocolour}"
mongo --host mongodb-dev.iamadevopsengineer.tech </app/schema/$component.js &>> /dev/null

