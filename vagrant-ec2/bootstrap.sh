#!/bin/bash
#This script installs ruby, rubygems, and chef
#Run this script on a new EC2 instance as the user-data script, which is run by `root` on machine startup.
set -e -x

#Config
export DEBIAN_FRONTEND=noninteractive
export CHEF_FILE_CACHE_PATH=/tmp/cheftime
export CHEF_COOKBOOK_PATH=$(CHEF_FILE_CACHE_PATH)/cookbooks
export CHEF_ROLE_PATH=$(CHEF_FILE_CACHE_PATH)/roles


mkdir -p $CHEF_FILE_CACHE_PATH
mkdir -p $CHEF_COOKBOOK_PATH

#chef solo ruby file
echo "file_cache_path \"$CHEF_FILE_CACHE_PATH\"
cookbook_path \"$CHEF_COOKBOOK_PATH\"
role_path \"$CHEF_ROLE_PATH\"
log_level :debug" > $CHEF_FILE_CACHE_PATH/solo.rb


apt-get update
apt-get --no-install-recommends -y install build-essential ruby ruby-dev rubygems libopenssl-ruby
gem install --no-rdoc --no-ri chef --version=0.10.4
echo 'PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/lib/gems/1.8/bin"' > /etc/environment
