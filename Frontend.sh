echo -e "\e[32m INstalling nginx server\e[0m"
yum install nginx -y &>> /dev/null

echo -e "\e[32m Removing old content\e[0m"
rm -rf /usr/share/nginx/html/* &>> /dev/null

echo -e "\e[32m Downloading new content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>> /dev/null

echo -e "\e[32m Extracting Frontend content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>> /dev/null

echo -e "\e[32m Extracting Frontend content\e[0m"
cp /home/centos/shell-scripting/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[32m restarting Nginx server\e[0m"
systemctl enable nginx &>> /dev/null
systemctl restart nginx &>> /dev/null