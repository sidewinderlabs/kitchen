current_dir                   = File.dirname(__FILE__)
user                          = ENV['USER']

# Logging:
#
log_level                     :info
log_location                  STDOUT

# Caching:
#
cache_type                    'BasicFile'
cache_options(                :path => "#{ENV['HOME']}/.chef/checksums")

# Cookbooks:
#
cookbook_path                 ["#{current_dir}/../cookbooks", "#{current_dir}/../site-cookbooks"]

# EC2 sub-command:
#
knife[:availability_zone]     = "#{ENV['EC2_AVAILABILITY_ZONE']}"
knife[:aws_access_key_id]     = "#{ENV['AWS_ACCESS_KEY_ID']}"
knife[:aws_secret_access_key] = "#{ENV['AWS_SECRET_ACCESS_KEY']}"
knife[:aws_ssh_key_id]        = "root"
knife[:chef_mode]             = "solo"
knife[:distro]                = "ubuntu10.04-gems"
knife[:flavor]                = "m1.small"
knife[:identity_file]         = "#{ENV['EC2_HOME']}/.ssh/id_rsa"
knife[:image]                 = "ami-a16665d5"
knife[:region]                = "#{ENV['EC2_REGION']}"
knife[:ssh_user]              = "ubuntu"

# Chef Server:
#
node_name                     user
client_key                    "#{ENV['HOME']}/.chef/#{user}.pem"
validation_client_name        "#{ENV['ORGNAME']}-validator"
validation_key                "#{ENV['HOME']}/.chef/#{ENV['ORGNAME']}-validator.pem"
chef_server_url               "https://api.opscode.com/organizations/#{ENV['ORGNAME']}"
solo                          true
