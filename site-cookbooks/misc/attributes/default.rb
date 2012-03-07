#::Chef::Node.send(:include, Opscode::OpenSSL::Password)

# E L A S T I C S E A R C H
# =========================
#
set[:elasticsearch][:name] = "elasticsearch"
set[:elasticsearch][:version] = "0.19.0"
set[:elasticsearch][:cluster] = "cluster001"
set[:elasticsearch][:home] = "/usr/local/elasticsearch"
set[:elasticsearch][:logs] = "/var/log/elasticsearch"
set[:elasticsearch][:data] = "/var/opt/elasticsearch"

if node[:instance_role] == "vagrant"
  set[:elasticsearch][:min_mem] = "1g"
  set[:elasticsearch][:max_mem] = "1g"
else
  set[:elasticsearch][:min_mem] = "8g"
  set[:elasticsearch][:max_mem] = "8g"
end

# P Y T H O N
# ===========
#
# The latest version that we can get via package installers is 2.6, so
# we need to install from source (the cookbook already has the version
# set to 2.7.1 so no need to specify it here):
#
set['python']['install_method'] = 'source'
set['python']['version'] = '2.7'
set['python']['prefix_dir'] = '/usr'

# S O L R
# =======
#
# For version 3.x:
#
set[:service][:solr][:version_x] = "3.5.0"
set[:service][:solr][:download_url_x] = "http://mirrors.enquira.co.uk/apache//lucene/solr/#{node[:service][:solr][:version]}/apache-solr-#{node[:service][:solr][:version]}.tgz"

# For version 4.x:
#
set[:service][:solr][:build] = "1702"
set[:service][:solr][:version] = "4.0-2011-12-13_09-19-12"
set[:service][:solr][:download_url] = "https://builds.apache.org/job/Solr-trunk/#{node[:service][:solr][:build]}/artifact/artifacts/apache-solr-#{node[:service][:solr][:version]}.tgz"

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
set[:service][:solr][:jetty_vm_config] = "-XX:+UseConcMarkSweepGC -Xmx4096m"
