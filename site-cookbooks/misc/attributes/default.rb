::Chef::Node.send(:include, Opscode::OpenSSL::Password)

# ElasticSearch configuration
#
default[:elasticsearch][:version] = "0.18.2"
