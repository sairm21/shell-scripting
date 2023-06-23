source common.sh
component="payment"
roboshop_app_password=$1

if [ -z "$roboshop_app_password"]; then
  echo -e "\e[31m roboshop_app_password is missing \e[0m"
  exit 1
fi

python