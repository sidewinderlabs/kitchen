#
# Author:: Mark Birbeck (mark.birbeck@sidewinderlabs.com)
# Cookbook Name:: misc
# Recipe:: s3cmd
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


if node[:instance_role] == "vagrant"
  template "/home/vagrant/.s3cfg" do
    owner "vagrant"
    source "s3cfg.erb"
    variables(
      :aws_access_key_id => node[:s3cmd][:aws_access_key_id],
      :aws_secret_access_key => node[:s3cmd][:aws_secret_access_key]
    )
  end
end

template "/root/.s3cfg" do
  owner "root"
  source "s3cfg.erb"
  variables(
    :aws_access_key_id => node[:s3cmd][:aws_access_key_id],
    :aws_secret_access_key => node[:s3cmd][:aws_secret_access_key]
  )
end

package "s3cmd" do
  action :install
end
