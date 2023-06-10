echo -e "\e[32m Copying mongodb repo files\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[32m Installing mongo db service\e[0m"
yum install mongodb-org -y

# need to modify the config file

echo -e "\e[32m start and stop mongo db service\e[0m"
systemctl enable mongod
systemctl restart mongod