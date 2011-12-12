#
# Author:: Mark Birbeck (mark.birbeck@sidewinderlabs.com)
# Cookbook Name:: misc
# Recipe:: solr
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

remote_file "/opt/#{node[:service][:solr][:target]}.tar.gz" do
  source "#{node[:service][:solr][:download_url]}"
  mode "0644"
  backup false
  not_if { File.directory?("/opt/apache-#{node[:service][:solr][:target]}")}
end

execute "unpack solr" do
  cwd "/opt"
  command "tar -xzvf #{node[:service][:solr][:target]}.tar.gz"
  not_if { File.directory?("/opt/apache-#{node[:service][:solr][:target]}")}
end

link "#{node[:service][:solr][:install]}" do
  to "/opt/apache-#{node[:service][:solr][:target]}"
end

file "/opt/#{node[:service][:solr][:target]}.tar.gz" do
  action :delete
end

directory "#{node[:service][:solr][:install]}/products" do
  recursive true
end

directory "#{node[:service][:solr][:logs]}" do
  recursive true
end

execute "create initial index" do
  command "cp -R #{node[:service][:solr][:install]}/example/solr/ #{node[:service][:solr][:install]}/products/"
  creates "#{node[:service][:solr][:install]}/products/solr/solr.xml"
end

script "copy Solr library" do
  interpreter "bash"
  code <<-EOH
    cp -R #{node[:service][:solr][:install]}/example/lib #{node[:service][:solr][:install]}/products/
    cp -R #{node[:service][:solr][:install]}/example/webapps #{node[:service][:solr][:install]}/products/
  EOH
  not_if { File.file?("#{node[:service][:solr][:install]}/products/webapps/solr.war")}
end

# Copy the Jetty configuration file:
#
template "/etc/default/jetty" do
  source "jetty-config.erb"
end


# J E T T Y
# =========
#

# Copy the Jetty run-time that is distributed with Solr. This is short-term,
# and at some point we should factor this out to a Jetty recipe, and install
# it independently:
#
script "copy run-time for Jetty" do
  interpreter "bash"
  code <<-EOH
    cp #{node[:service][:solr][:install]}/example/start.jar #{node[:service][:solr][:install]}/products/
  EOH
  not_if { File.file?("#{node[:service][:solr][:install]}/products/start.jar")}
end

# Create the configuration directory and then copy the Jetty files:
#
directory "#{node[:service][:solr][:install]}/products/etc" do
  recursive true
end

cookbook_file "#{node[:service][:solr][:install]}/products/etc/jetty.xml" do
  source "jetty.xml"
  owner "root"
  group "root"
  mode "0700"
end

cookbook_file "#{node[:service][:solr][:install]}/products/etc/jetty-logging.xml" do
  source "jetty-logging.xml"
  owner "root"
  group "root"
  mode "0700"
end

cookbook_file "#{node[:service][:solr][:install]}/products/etc/webdefault.xml" do
  source "webdefault.xml"
  owner "root"
  group "root"
  mode "0700"
end

# Copy the init.d script and then start or restart the service:
#
cookbook_file "/etc/init.d/jetty" do
  source "jetty.init"
  owner "root"
  group "root"
  mode "0700"
end

service "jetty" do
  supports :restart => true, :status => true
  action [:enable, :start]
end
