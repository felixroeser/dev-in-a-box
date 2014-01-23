#
# Cookbook Name:: kestrel
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java::openjdk"

package "daemon"
package "unzip"

['/usr/local', '/var/log', '/var/run'].each do |dir|
  directory "#{dir}/kestrel" do
    action :create
    # mode 0755
    mode 0777
  end
end

remote_file "/usr/local/kestrel-2.4.1.zip" do
  action :create_if_missing
  source "http://robey.github.com/kestrel/download/kestrel-2.4.1.zip"
end

bash "install kestrel" do
  # http://vialstudios.com/guide-authoring-cookbooks.html
  code <<-EOH 
  cd "/usr/local/kestrel"
  unzip /usr/local/kestrel-2.4.1.zip
  ln -s kestrel-2.4.1 current
  chmod +x current/scripts/*
  rm current/scripts/kestrel.sh
  EOH

  not_if { File.exists?("/usr/local/kestrel/kestrel-2.4.1") }
end

template "/usr/local/kestrel/current/scripts/kestrel.sh" do
  source "kestrel.sh"
  mode "0755"
  action :create_if_missing
end

template "/etc/init.d/kestrel" do
  source "kestrel-init.d"
  mode "0755"
  action :create_if_missing
end

service "kestrel" do
  supports [ :start =>true, :restart => true, :stop => true, :reload => true ]
  action [ :enable, :start ]
end

