#
# Cookbook Name:: kestrel
# Recipe:: start
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "start kestrel" do
  cwd "/usr/local/kestrel/current"
  code <<-EOH
  JAVA_HOME=/usr scripts/kestrel.sh start
  EOH
end
