colour="\e[34m"
nocolour="\e[0m"
log_file="/dev/null"
app_dir="/app"

nodejs() {
  echo -e "${colour} Setup NodeJS repos${nocolour}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${log_file}

  echo -e "${colour} Install NodeJS${nocolour}"
  yum install nodejs -y &>> ${log_file}

  echo -e "${colour} Adding application User${nocolour}"
  useradd roboshop &>> ${log_file}

  echo -e "${colour} setup an app directory${nocolour}"
  rm -rf ${app_dir} &>> ${log_file}
  mkdir ${app_dir}

  echo -e "${colour} Download the application code to created app directory${nocolour}"
  curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>> ${log_file}
  cd ${app_dir}
  unzip /tmp/$component.zip &>> ${log_file}

  echo -e "${colour} download the dependencies${nocolour}"
  cd ${app_dir}
  npm install &>> ${log_file}

  echo -e "${colour} Setup SystemD $component Service${nocolour}"
  cp /home/centos/shell-scripting/$component.service /etc/systemd/system/$component.service &>> ${log_file}

  echo -e "${colour} Load and start the service${nocolour}"
  systemctl daemon-reload &>> ${log_file}
  systemctl enable $component &>> ${log_file}
  systemctl start $component &>> ${log_file}

}