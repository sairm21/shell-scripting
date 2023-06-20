source common.sh

echo -e "${colour} INstalling nginx server${nocolour}"
yum install nginx -y &>> ${log_file}

echo -e "${colour} Removing old content${nocolour}"
rm -rf /usr/share/nginx/html/* &>> ${log_file}

echo -e "${colour} Downloading new content${nocolour}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>> ${log_file}

echo -e "${colour} Extracting Frontend content${nocolour}"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>> ${log_file}

echo -e "${colour} Extracting Frontend content${nocolour}"
cp /home/centos/shell-scripting/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "${colour} restarting Nginx server${nocolour}"
systemctl enable nginx &>> ${log_file}
systemctl restart nginx &>> ${log_file}