#!/bin/bash
:
set -x

service mariadb start
mysql_secure_installation <<EOF

y
verylongpwd
verylongpwd
y
y
y
y
EOF

mysql -uroot -pverylongpwd < /usr/share/zoneminder/db/zm_create.sql

cat <<EOF >> $(pwd)/tmp.sql
CREATE USER 'zmuser'@localhost IDENTIFIED BY 'zmpass';
GRANT ALL PRIVILEGES ON zm.* TO 'zmuser'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES ;
EOF

mysql -u root -pverylongpwd < $(pwd)/tmp.sql
rm $(pwd)/tmp.sql

mysqladmin -uroot -p reload
chmod 740 /etc/zm/zm.conf
chown root:www-data /etc/zm/zm.conf
adduser www-data video

service zoneminder start
a2enconf zoneminder
a2enmod rewrite headers expires
/etc/init.d/apache2 start

tail -f /var/log/faillog & 
wait $!