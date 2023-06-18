source common.sh
component=catalogue

nodejs

echo -e "${colour} Copying mongodb repo files${nocolour}"
cp /home/centos/shell-scripting/mongodb.repo /etc/yum.repos.d/mongo.repo &>> ${log_file}

echo -e "${colour} Installing mongodv${nocolour}"
yum install mongodb-org-shell -y &>> ${log_file}

echo -e "${colour} Load Schema${nocolour}"
mongo --host mongodb-dev.iamadevopsengineer.tech <${app_dir}/schema/$component.js &>> ${log_file}

