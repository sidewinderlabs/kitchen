#
# Author:: Mark Birbeck (mark.birbeck@sidewinderlabs.com)
# Cookbook Name:: misc
# Recipe:: hive
#
# Copyright 2011, Sidewinder Labs Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node[:java][:install_flavor] = "sun"

require_recipe "java"

# Install the Cloudera repo.
#
if platform?("centos", "redhat", "fedora")
  yum_repository "cloudera-cdh3" do
    name "Cloudera's Distribution for Hadoop, Version 3"
    url "http://archive.cloudera.com/redhat/cdh/3b4/mirrors"
    mirrorlist true
    key "http://archive.cloudera.com/redhat/cdh/RPM-GPG-KEY-cloudera"
    action :add
  end
end

if platform?("ubuntu", "debian")
  apt_repository "cloudera" do
    uri "http://archive.cloudera.com/debian"
    distribution "#{node['lsb']['codename']}-cdh3"
    components ["contrib"]
    key "http://archive.cloudera.com/debian/archive.key"
    action :add
  end
end

# Install Hadoop and then start the services.
#
package "hadoop-0.20-conf-pseudo" do
  action :install
end

service "hadoop-0.20-datanode" do
  action :start
end

service "hadoop-0.20-jobtracker" do
  action :start
end

service "hadoop-0.20-namenode" do
  action :start
end

service "hadoop-0.20-secondarynamenode" do
  action :start
end

service "hadoop-0.20-tasktracker" do
  action :start
end

# Install Hive itself.
#
package "hadoop-hive" do
  action :install
end

# Must be done after Hive is installed otherwise the directories won't
# exist.
#
template "/etc/hive/conf/hive-site.xml" do
  owner "root"
  group "hadoop"
  mode "0644"
  source "hive-site.xml.erb"
  variables(
    :aws_access_key_id => node[:s3cmd][:aws_access_key_id],
    :aws_secret_access_key => node[:s3cmd][:aws_secret_access_key]
  )
end
