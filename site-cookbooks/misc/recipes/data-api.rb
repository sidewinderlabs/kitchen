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

if node[:instance_role] != "vagrant"
  include_recipe "misc::ssh"

  git "/opt/data-api" do
    repository "git@github.com:EDITD/dataservice.git"
    reference "master"
    revision "96eaf7339d3c488e5c2b9eb220fe2cdf6f6cbae0"
    action :sync
  end
end
