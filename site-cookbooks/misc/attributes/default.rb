#::Chef::Node.send(:include, Opscode::OpenSSL::Password)

# E L A S T I C S E A R C H
# =========================
#
set[:elasticsearch][:version] = "0.18.5"

# S O L R
# =======
#
set[:service][:solr][:name] = "solr"
set[:service][:solr][:version] = "3.5.0"
set[:service][:solr][:download_url] = "http://mirrors.enquira.co.uk/apache//lucene/solr/#{node[:service][:solr][:version]}/apache-solr-#{node[:service][:solr][:version]}.tgz"
set[:service][:solr][:install] = "/usr/local/#{node[:service][:solr][:name]}"
set[:service][:solr][:target] = "solr-#{node[:service][:solr][:version]}"
set[:service][:solr][:data] = "/var/data/#{node[:service][:solr][:name]}"
set[:service][:solr][:logs] = "/var/logs/#{node[:service][:solr][:name]}"

# J E T T Y
# =========
#
set[:service][:solr][:jetty_config] = "-XX:+UseConcMarkSweepGC -Xmx1536m"
