#
# Cookbook Name:: kestrel
# Recipe:: kestrel-tugboat-config
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/usr/local/kestrel/current/config/production.scala" do
  source "default.scala.erb"
  mode "0644"
  notifies :restart, resources(:service => 'kestrel')
end
