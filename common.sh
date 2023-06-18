colour="\e[34m"
nocolour="\e[0m"
log_file="/dev/null"
app_dir="/app"

app_user(){
  echo -e "${colour} Adding application User${nocolour}"
  useradd roboshop &>> ${log_file}

  echo -e "${colour} setup an app directory${nocolour}"
  rm -rf /app &>> ${log_file}
  mkdir /app &>> ${log_file}

  echo -e "${colour} Download the application code to created app directory${nocolour}"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>> ${log_file}
  cd ${app_dir}
  unzip /tmp/${component.zip &>> ${log_file}

}

systemd_setup() {
    echo -e "${colour} Setup SystemD $component Service${nocolour}"
    cp /home/centos/shell-scripting/$component.service /etc/systemd/system/$component.service &>> ${log_file}

    echo -e "${colour} Load and start the service${nocolour}"
    systemctl daemon-reload &>> ${log_file}
    systemctl enable $component &>> ${log_file}
    systemctl start $component &>> ${log_file}
}

nodejs() {
  echo -e "${colour} Setup NodeJS repos${nocolour}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${log_file}

  echo -e "${colour} Install NodeJS${nocolour}"
  yum install nodejs -y &>> ${log_file}

  app_user

  echo -e "${colour} download the dependencies${nocolour}"
  cd ${app_dir}
  npm install &>> ${log_file}

systemd_setup

}

mongo_schema_setup() {
  echo -e "${colour} Copying mongodb repo files${nocolour}"
  cp /home/centos/shell-scripting/mongodb.repo /etc/yum.repos.d/mongo.repo &>> ${log_file}

  echo -e "${colour} Installing mongodv${nocolour}"
  yum install mongodb-org-shell -y &>> ${log_file}

  echo -e "${colour} Load Schema${nocolour}"
  mongo --host mongodb-dev.iamadevopsengineer.tech <${app_dir}/schema/$component.js &>> ${log_file}

}

mysql_schema_setup() {
    echo -e "${colour} mysql installation${nocolour}"
    yum install mysql -y &>> ${log_file}

    echo -e "${colour} Load Schema${nocolour}"
    mysql -h mysql-dev.iamadevopsengineer.tech -uroot -pRoboShop@1 < /app/schema/${component}.sql &>> ${log_file}

}

maven() {
  echo -e "${colour} install maven ${nocolour}"
  yum install maven -y &>> ${log_file}

  app_user

  echo -e "${colour} download the dependencies & build the application${nocolour}"
  cd /app &>> ${log_file}
  mvn clean package &>> ${log_file}
  mv target/${component}-1.0.jar ${component}.jar &>> ${log_file}

  systemd_setup

  mysql_schema_setup
}