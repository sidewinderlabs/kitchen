#
# Author:: Mark Birbeck (mark@editd.com)
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2012, Sidewinder Labs Ltd.
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
# The following is based on:
#
#  https://ccp.cloudera.com/display/CDH4DOC/Installing+CDH4+on+a+Single+Linux+Node+in+Pseudo-distributed+Mode#InstallingCDH4onaSingleLinuxNodeinPseudo-distributedMode-InstallingCDH4withYARNonaSingleLinuxNodeinPseudodistributedmode
#

include_recipe "java"


# Install the Cloudera repo.
#
if platform?("ubuntu", "debian")
  apt_repository "cloudera" do
    uri "http://archive.cloudera.com/cdh4/ubuntu/#{node['lsb']['codename']}/amd64/cdh"
    distribution "#{node['lsb']['codename']}-cdh4"
    components ["contrib"]
    key "http://archive.cloudera.com/cdh4/ubuntu/#{node['lsb']['codename']}/amd64/cdh/archive.key"
    action :add
  end
  execute "apt-get update"
end

# Install Hadoop and start HDFS:
#
package "hadoop-conf-pseudo" do
  action :install
end


# Format the NameNode:
#
script "Format namenode" do
  interpreter "bash"
  user "hdfs"
  code <<-EOH

  hdfs namenode -format
  EOH
  not_if "sudo -u hdfs hadoop fs -ls -R /tmp/hadoop-yarn/staging/history/done_intermediate"
end


# Start HDFS:
#
service "hadoop-hdfs-datanode" do
  action :start
end

service "hadoop-hdfs-namenode" do
  action :start
end

service "hadoop-hdfs-secondarynamenode" do
  action :start
end


# Create all of the necessary directories:
#
script "Configure YARN" do
  interpreter "bash"
  user "hdfs"
  code <<-EOH

  # Create /tmp
  #
  hadoop fs -mkdir /tmp
  hadoop fs -chmod -R 1777 /tmp

  # Create User, Staging, and Log Directories:
  #
  hadoop fs -mkdir /user/vagrant
  hadoop fs -chown vagrant:vagrant /user/vagrant

  hadoop fs -mkdir /var/log/hadoop-yarn
  hadoop fs -chown yarn:mapred /var/log/hadoop-yarn

  hadoop fs -mkdir /tmp/hadoop-yarn/staging
  hadoop fs -chmod -R 1777 /tmp/hadoop-yarn/staging

  hadoop fs -mkdir /tmp/hadoop-yarn/staging/history/done_intermediate
  hadoop fs -chmod -R 1777 /tmp/hadoop-yarn/staging/history/done_intermediate

  hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn/staging
  EOH
  not_if "sudo -u hdfs hadoop fs -ls -R /tmp/hadoop-yarn/staging/history/done_intermediate"
end

service "hadoop-yarn-resourcemanager" do
  action :start
end

service "hadoop-yarn-nodemanager" do
  action :start
end

#service "hadoop-mapreduce-historyserver" do
#  action :start
#end
