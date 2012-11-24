#
# Author:: Mark Birbeck (mark.birbeck@sidewinderlabs.com)
# Cookbook Name:: hadoop
# Recipe:: mongo-hadoop
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

include_recipe "hadoop"
include_recipe "java"

src = "/usr/local/src"
p = "mongo-hadoop"

git "#{src}/#{p}" do
	repository "git://github.com/mongodb/#{p}.git"
	reference "833bf5582d305ba556c28545a23fefc2fde7e9eb"
	action :export
	not_if do
    	File.exists?("#{src}/#{p}/README.md")
	end
end

remote_file "#{src}/#{p}/mongo-2.9.3.jar" do
	source "https://github.com/downloads/mongodb/mongo-java-driver/mongo-2.9.3.jar"
	action :create_if_missing
end

execute "Build and install mongo-hadoop" do
  command "./sbt -mem 640 package"
  cwd "#{src}/#{p}"
end
