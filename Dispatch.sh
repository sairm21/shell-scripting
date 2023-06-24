source common.sh
component="dispatch"
roboshop_app_password=$1

if [ -z "$roboshop_app_password" ]; then
  echo -e "\e[31m roboshop_app_password is missing \e[0m"
  exit 1
fi

echo -e "${colour} Install GoLang ${nocolour}"
yum install golang -y &>> ${log_file}
stat_check $?

app_user

echo -e "${colour} download the dependencies & build the software ${nocolour}"
cd /app &>> ${log_file}
go mod init dispatch &>> ${log_file}
go get &>> ${log_file}
go build &>> ${log_file}
stat_check $?

systemd_setup


