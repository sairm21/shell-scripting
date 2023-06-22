source common.sh

echo -e "${colour} Copying mongodb repo files${nocolour}"
cp mongodb.repo /etc/yum.repos.d/mongo.repo ${log_file}
stat_check $?

echo -e "${colour} Installing mongo db service${nocolour}"
yum install mongodb-org -y ${log_file}
stat_check $?

echo -e "${colour} Update mongodb lisen address${nocolour}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat_check $?

echo -e "${colour} start and stop mongo db service${nocolour}"
systemctl enable mongod ${log_file}
systemctl restart mongod ${log_file}
stat_check $?