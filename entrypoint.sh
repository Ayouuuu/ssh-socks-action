#!/bin/sh -l

set -e

echo "#################################################"
echo "Starting ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"

#env
#echo "INPUT_SERVER : ${INPUT_PROXY_SERVER}"
#echo "INPUT_USERNAME : ${INPUT_PROXY_USERNAME}"
#echo "INPUT_PORT: ${INPUT_PROXY_PORT}"
#echo "INPUT_SOCKS5_PWD: ${INPUT_PROXY_SOCKS5_PWD}"
#echo "INPUT_KEY: ${INPUT_KEY}"
#echo "INPUT_RUN: ${INPUT_RUN}"
#echo "INPUT_SSH_HOST": "${INPUT_HOST}"
#echo "INPUT_SSH_PORT": "${INPUT_PORT}"
#echo "INPUT_SSH_USERNAME: ${INPUT_USERNAME}"
#echo "INPUT_SSH_PASSWORD": "${INPUT_PASSWORD}"

CMD=`echo $INPUT_RUN | sed "s/ / %% /g"`

mkdir "/root/.ssh"

export SOCKS5_PASSWD=${INPUT_SOCKS5_PWD}
config='/root/.ssh/config'
echo "Host ${INPUT_HOST}" > $config
echo "  User ${INPUT_USERNAME}" >> $config
echo "  Port ${INPUT_PORT}" >> $config
echo "  ProxyCommand connect -S ${INPUT_PROXY_USERNAME}@${INPUT_PROXY_SERVER}:${INPUT_PROXY_PORT} %h %p" >> $config

if [ -z "$INPUT_KEY" ]
then
  echo 'Using password'
  export SSHPASS=$PASS
  echo "sshpass -e ssh $INPUT_HOST "$CMD""
else
  echo 'Using private key'
  echo "$INPUT_KEY" > "/root/.ssh/id_rsa"
  chmod 400 "/root/.ssh/id_rsa"

  echo "  IdentityFile /root/.ssh/id_rsa" >> $config
  cat "/root/.ssh/config"

#  ls -lha "/root/.ssh/"
  echo "sshpass ssh $INPUT_HOST "$CMD""
fi