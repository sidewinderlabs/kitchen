#
# Author:: Mark Birbeck (mark.birbeck@sidewinderlabs.com)
# Cookbook Name:: hadoop
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

require_recipe "elasticsearch"

git "/usr/local/share/wonderdog" do
  repository "https://github.com/infochimps-labs/wonderdog.git"
  reference "master"
  action :sync
end
