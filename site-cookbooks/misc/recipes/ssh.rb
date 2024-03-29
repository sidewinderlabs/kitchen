#
# Author:: Mark Birbeck (mark.birbeck@sidewinderlabs.com)
# Cookbook Name:: misc
# Recipe:: ssh
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

include_recipe "misc::keygen"

# Ensure that the .ssh directory exists for root:
#
directory "/root/.ssh" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

# Copy the default config file:
#
template "/root/.ssh/config" do
  source "ssh-config.erb"
  owner "root"
  group "root"
  mode "0700"
end
