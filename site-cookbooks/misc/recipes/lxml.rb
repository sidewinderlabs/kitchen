#
# Author:: Mark Birbeck (mark.birbeck@sidewinderlabs.com)
# Cookbook Name:: misc
# Recipe:: lxml
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

# Fail on non-Ubuntu platforms to ensure that the correct names are
# inserted here:
#
pkgs = value_for_platform(
  ["debian","ubuntu"] => {
    "default" => ["libxml2-dev", "libxslt1-dev"]
  }
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

python_pip "lxml" do
  version "2.3.2"
  action :install
end
