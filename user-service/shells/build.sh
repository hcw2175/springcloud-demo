#!/bin/bash

# 进入脚本所在目录，然后返回项目根目录
scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptPath
cd ..

# 服务SSH配置
sshIP=10.211.55.4
sshUsr=hucw
sshPwd=88888888
sshPort=22

# Docker容器基本信息
dockerName="userservice"
dockerPort="2100"

# 编译打包
mvn clean package

# 拷贝jar包到目录
outputPath="${scriptPath}/${dockerName}";
if [ -d ${outputPath} ]; then
  rm -rf ${outputPath}
fi
mkdir ${outputPath} && mkdir ${outputPath}/jar

cp ./target/*.jar ${outputPath}/jar/app.jar
cp ${scriptPath}/release-docker.sh ${outputPath}/release-docker.sh

# 整个目录上传到服务器
cd ${scriptPath}
appPath="~/springcloud"
ssh -p ${sshPort} ${sshUsr}@${sshIP} "[ -d ${appPath}/${dockerName} ] && rm -rf ${appPath}"
ssh -p ${sshPort} ${sshUsr}@${sshIP} "[ -d ${appPath} ] || mkdir -p ${appPath}"

scp -r -P ${sshPort} ./${dockerName} ${sshUsr}@${sshIP}:${appPath}

# 远程执行发布命令
ssh -p ${sshPort} ${sshUsr}@${sshIP} "sh ${appPath}/${dockerName}/release-docker.sh"