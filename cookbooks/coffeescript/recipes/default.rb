#
# Cookbook Name:: coffee-script
# Recipe:: default
#

include_recipe "nodejs"

bash "install coffee-script" do
  user "root"
  code <<-EOH
    npm install -g coffee-script@#{node['coffeescript']['version']}
  EOH
  not_if "npm list -g | grep coffee-script | grep #{node['coffeescript']['version']}"
end