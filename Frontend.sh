echo -e "\e[32m INstalling nginx server\e[0m"
yum install nginx -y

echo -e "\e[32m Removing old content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[32m Downloading new content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[32m Extracting Frontend content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

# need to copy config file

echo -e "\e[32m restarting Nginx server\e[0m"
systemctl enable nginx
systemctl restart nginx