#::Chef::Node.send(:include, Opscode::OpenSSL::Password)

# E L A S T I C S E A R C H
# =========================
#
set[:elasticsearch][:version] = "0.18.5"

# S O L R
# =======
#
# For version 3.x:
#
set[:service][:solr][:version_x] = "3.5.0"
set[:service][:solr][:download_url_x] = "http://mirrors.enquira.co.uk/apache//lucene/solr/#{node[:service][:solr][:version]}/apache-solr-#{node[:service][:solr][:version]}.tgz"

# For version 4.x:
#
set[:service][:solr][:version] = "4.0-2011-12-12_09-14-13"
set[:service][:solr][:download_url] = "https://builds.apache.org/job/Solr-trunk/lastStableBuild/artifact/artifacts/apache-solr-#{node[:service][:solr][:version]}.tgz"

# General Solr configuration:
#
set[:service][:solr][:name] = "solr"
set[:service][:solr][:install] = "/usr/local/#{node[:service][:solr][:name]}"
set[:service][:solr][:target] = "solr-#{node[:service][:solr][:version]}"
set[:service][:solr][:data] = "/var/data/#{node[:service][:solr][:name]}"
set[:service][:solr][:logs] = "/var/logs/#{node[:service][:solr][:name]}"

# J E T T Y
# =========
#
set[:service][:solr][:jetty_vm_config] = "-XX:+UseConcMarkSweepGC -Xmx1536m"
