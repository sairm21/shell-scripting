source common.sh
component=shipping
mysql_root_password = $1

if [ -z "$mysql_root_password"]; then
  echo -e "\e[31m mysql root password is missing \e[0m"
  exit 1
fi

maven