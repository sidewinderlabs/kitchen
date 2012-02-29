#
# Author:: Mark Birbeck (mark.birbeck@sidewinderlabs.com)
# Cookbook Name:: misc
# Recipe:: data-api
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

include_recipe "misc::django"
include_recipe "misc::pyes"
include_recipe "misc::requests"
include_recipe "misc::djangorestframework"

python_pip "python-dateutil" do
  version "1.5"
  action :install
end

if node[:instance_role] == "vagrant"
  link "/opt/data-api" do
    to "/opt/workspace/editd-dataservice"
  end
else
  include_recipe "misc::ssh"

  git "/opt/data-api" do
    repository "git@github.com:EDITD/dataservice.git"
    reference "master"
    action :sync
  end
end
