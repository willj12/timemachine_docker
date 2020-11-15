#!/bin/bash
read -sp 'timemachine user password: ' password1
echo
read -sp 'Repeat timemachine user password: ' password2

if [[ "${password1}" != "${password2}" ]]; then
  echo "Passwords don't match"
  exit 1
fi

sed -i "" "s/<password placeholder>/${password1}\\\n${password1}/g" Dockerfile

docker build . -t timemachine

sed -i "" "s/${password1}\\\n${password1}/<password placeholder>/g" Dockerfile
