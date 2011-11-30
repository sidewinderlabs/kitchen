#
# Author:: Mark Birbeck (mark.birbeck@sidewinderlabs.com)
# Cookbook Name:: misc
# Recipe:: elasticsearch
#
# Copyright 2011, Sidewinder Ltd.
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
  
remote_file "/opt/elasticsearch-#{node[:elasticsearch][:version]}.tar.gz" do
  source "https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-#{node[:elasticsearch][:version]}.tar.gz"
  mode "0644"
  backup false
  not_if { File.directory?("/opt/elasticsearch-#{node[:elasticsearch][:version]}")}
end

execute "unpack ES" do
  cwd "/opt"
  command "tar -xzvf elasticsearch-#{node[:elasticsearch][:version]}.tar.gz"
  not_if { File.directory?("/opt/elasticsearch-#{node[:elasticsearch][:version]}")}
end

link "/usr/local/elasticsearch" do
  to "/opt/elasticsearch-#{node[:elasticsearch][:version]}"
end

file "/opt/elasticsearch-#{node[:elasticsearch][:version]}.tar.gz" do
  action :delete
end

cookbook_file "/etc/init.d/elasticsearchd" do
  source "es.init"
  owner "root"
  group "root"
  mode "0700"
end

cookbook_file "/usr/local/elasticsearch/config/elasticsearch.yml" do
  source "elasticsearch.yml"
end

execute "Install Thrift plug-in" do
  command "/usr/local/elasticsearch/bin/plugin -install transport-thrift"
end

execute "Install Web front-end plug-in" do
  command "/usr/local/elasticsearch/bin/plugin -install mobz/elasticsearch-head"
end

execute "Install BigDesk plug-in" do
  command "/usr/local/elasticsearch/bin/plugin -install lukas-vlcek/bigdesk"
end

execute "Create ES service" do
  command "update-rc.d elasticsearchd defaults"
end

service "elasticsearchd" do
  action :start
end
