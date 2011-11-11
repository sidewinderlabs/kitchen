#
# Author:: Mark Birbeck (mark.birbeck@sidewinderlabs.com)
# Cookbook Name:: misc
# Recipe:: s3sync
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

if not(File.exists?("/usr/local/bin/s3sync"))
  remote_file "/home/s3sync.tar.gz" do
    source "http://s3.amazonaws.com/ServEdge_pub/s3sync/s3sync.tar.gz"
    mode "0644"
    backup false
  end
  
  execute "unpack s3sync" do
    cwd "/home"
    command "tar -xzvf s3sync.tar.gz"
  end
  
  link "/usr/local/bin/s3sync" do
    to "/home/s3sync/s3sync.rb"
  end
  
  link "/usr/local/bin/s3cmd" do
    to "/home/s3sync/s3cmd.rb"
  end
  
  file "/home/s3sync.tar.gz" do
    action :delete
  end
end
