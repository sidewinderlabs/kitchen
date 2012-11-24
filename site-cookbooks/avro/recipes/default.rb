include_recipe "build-essential"
include_recipe "python"

python_pip "avro" do
	action :install
end
