::Chef::Node.send(:include, Opscode::OpenSSL::Password)

# ElasticSearch configuration
#
set[:elasticsearch][:version] = "0.18.4"
