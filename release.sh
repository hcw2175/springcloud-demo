#!/bin/bash

scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptPath

sh ./service-discovery/shells/build.sh

sh ./user-service/shells/build.sh

sh ./product-service/shells/build.sh