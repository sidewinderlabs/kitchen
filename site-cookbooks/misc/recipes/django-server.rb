#
# Author:: Mark Birbeck (mark.birbeck@sidewinderlabs.com)
# Cookbook Name:: misc
# Recipe:: django-server
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

include_recipe "misc::django"

package "swig" do
  action :install
end

python_pip "djangorestframework" do
  version "0.2.4"
  action :install
end

python_pip "m2crypto" do
  action :install
end

python_pip "requests-oauth2" do
  action :install
end

python_pip "requests" do
  version "0.9.0"
  action :install
end
