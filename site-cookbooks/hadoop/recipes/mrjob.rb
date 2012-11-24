#
# Author:: Mark Birbeck (mark.birbeck@sidewinderlabs.com)
# Cookbook Name:: misc
# Recipe:: mrjob
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

require_recipe "python::pip"

if node[:instance_role] == "vagrant"
  conf_dir = "/home/vagrant"
  ssh_file = "/home/vagrant/.ssh/EMR.pem"
  user = "vagrant"
else
  conf_dir = "/root"
  ssh_file = "/root/.ssh/EMR.pem"
  user = "root"
end

python_pip "boto" do
  action :install
end

template "#{conf_dir}/.boto" do
  owner user
  source "boto.conf.erb"
  variables(
    :aws_access_key_id => node[:s3cmd][:aws_access_key_id],
    :aws_secret_access_key => node[:s3cmd][:aws_secret_access_key]
  )
end

python_pip "mrjob" do
  action :install
end

template "#{conf_dir}/.mrjob.conf" do
  owner user
  source "mrjob.conf.erb"
  variables(
    :aws_access_key_id => node[:s3cmd][:aws_access_key_id],
    :aws_secret_access_key => node[:s3cmd][:aws_secret_access_key]
  )
end

cookbook_file ssh_file do
  source "EMR.pem"
  owner user
  mode "0600"
end
