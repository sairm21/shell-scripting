colour="\e[34m"
nocolour="\e[0m"
log_file="/dev/null"
app_dir="/app"

stat_check() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32m Sucess\e[0m"
  else
    echo -e "\e[31m Failure\e[0m"
  fi
}

app_user() {
  echo -e "${colour} Adding application User${nocolour}"
  id roboshop &>> ${log_file}
  if [ $? -eq 1 ]; then
    useradd roboshop &>> ${log_file}
  fi
    stat_check $?

  echo -e "${colour} setup an app directory${nocolour}"
  rm -rf /app &>> ${log_file}
  mkdir /app &>> ${log_file}

stat_check $?
  echo -e "${colour} Download the application code to created app directory${nocolour}"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>> ${log_file}
  cd ${app_dir}
  unzip "/tmp/${component}.zip" &>> ${log_file}

stat_check $?
}

systemd_setup() {
    echo -e "${colour} Setup SystemD $component Service${nocolour}"
    cp /home/centos/shell-scripting/${component}.service /etc/systemd/system/${component}.service &>> ${log_file}

stat_check $?
    echo -e "${colour} Load and start the service${nocolour}"
    systemctl daemon-reload &>> ${log_file}
    systemctl enable $component &>> ${log_file}
    systemctl start $component &>> ${log_file}

stat_check $?
}

nodejs() {
  echo -e "${colour} Setup NodeJS repos${nocolour}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${log_file}

stat_check $?
  echo -e "${colour} Install NodeJS${nocolour}"
  yum install nodejs -y &>> ${log_file}
stat_check $?
  app_user

  echo -e "${colour} download the dependencies${nocolour}"
  cd ${app_dir}
  npm install &>> ${log_file}

stat_check $?
systemd_setup

stat_check $?
}

mongo_schema_setup() {
  echo -e "${colour} Copying mongodb repo files${nocolour}"
  cp /home/centos/shell-scripting/mongodb.repo /etc/yum.repos.d/mongo.repo &>> ${log_file}

stat_check $?
  echo -e "${colour} Installing mongodv${nocolour}"
  yum install mongodb-org-shell -y &>> ${log_file}

stat_check $?
  echo -e "${colour} Load Schema${nocolour}"
  mongo --host mongodb-dev.iamadevopsengineer.tech <${app_dir}/schema/${component}.js &>> ${log_file}

stat_check $?
}

mysql_schema_setup() {
    echo -e "${colour} mysql installation${nocolour}"
    yum install mysql -y &>> ${log_file}

stat_check $?
    echo -e "${colour} Load Schema${nocolour}"
    mysql -h mysql-dev.iamadevopsengineer.tech -uroot -pRoboShop@1 < /app/schema/${component}.sql &>> ${log_file}

stat_check $?
}

maven() {
  echo -e "${colour} install maven ${nocolour}"
  yum install maven -y &>> ${log_file}

stat_check $?
  app_user

  echo -e "${colour} download the dependencies & build the application${nocolour}"
  cd /app &>> ${log_file}
  mvn clean package &>> ${log_file}
  mv target/${component}-1.0.jar ${component}.jar &>> ${log_file}

stat_check $?
  systemd_setup

  mysql_schema_setup

stat_check $?
}

python() {
  echo -e "${colour} Install Python 3.6 ${nocolour}"
  yum install python36 gcc python3-devel -y &>> ${log_file}

stat_check $?
  app_user

  echo -e "${colour} download the dependencies. ${nocolour}"
  cd /app &>> /tmp/roboshop.log
  pip3.6 install -r requirements.txt &>> ${log_file}

sed -i "s/roboshop_app_password/$1/" /home/centos/shell-scripting/${component}.service &>> ${log_file}

stat_check $?
  systemd_setup

stat_check $?
}