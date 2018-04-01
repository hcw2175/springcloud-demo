#!/bin/bash

# Docker容器基本信息
dockerName="productservice"
dockerPort="2200"
# 挂住路径建议为绝对路径
dockerJarVolumn="/home/hucw/springcloud/${dockerName}"

# 停止删除现有容器
echo "停止删除容器：${dockerName}"
docker stop ${dockerName} && docker rm ${dockerName}

# Docker容器运行命令
echo ""
docker run --name=${dockerName} -d \
-p ${dockerPort}:${dockerPort} \
-v ${dockerJarVolumn}/jar:/jar \
microserv/openjdk:1.0.0


echo "${dockerName}容器已启动，使用命令查看启动日志：docker logs --tail=500 ${dockerName}"