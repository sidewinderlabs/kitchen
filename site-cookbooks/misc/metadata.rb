maintainer       "Sidewinder Labs Ltd."
maintainer_email "mark.birbeck@sidewinderlabs.com"
license          "Apache 2.0"
description      "Installs/Configures the Sidewinder Labs Platform"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1.0"
recipe           "misc", "Installs and configures the Sidewinder Labs Platform"

%w{ python }.each do |cb|
  depends cb
end

%w{ debian ubuntu centos }.each do |os|
  supports os
end
