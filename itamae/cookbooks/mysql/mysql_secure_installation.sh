#!/bin/bash

expect -c "
  set timeout 5
  spawn mysql_secure_installation

  expect \"Enter current password for root\"
  send \"\n\"

  expect \"Set root password?\"
  send \"n\n\"

  expect \"Remove anonymous users?\"
  send \"y\n\"

  expect \"Disallow root login remotely?\"
  send \"y\n\"

  expect \"Remove test database and access to it?\"
  send \"y\n\"

  expect \"Reload privilege tables now?\"
  send \"y\n\"

  interact
"
