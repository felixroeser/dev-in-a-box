
include_recipe "build-essential"

cache_path  = Chef::Config[:file_cache_path]
version     = node[:sqlite][:version]
tarball     = "sqlite-autoconf-#{version}.tar.gz"

configure_opts = node[:sqlite][:configure_options].join(" ")

remote_file "#{cache_path}/#{tarball}" do
  source    "#{node[:sqlite][:url]}/#{tarball}"
  checksum  node[:sqlite][:checksum]
  mode      "0644"
  not_if    { ::File.exists?("/usr/local/bin/sqlite3") }
end

bash "build sqlite" do
  cwd       cache_path
  code      <<-BUILD
    tar -zxf #{tarball}
    (cd sqlite-autoconf-#{version} && ./configure #{configure_opts})
    (cd sqlite-autoconf-#{version} && make && make install)
    (cd sqlite-autoconf-#{version} && ldconfig)
  BUILD
  not_if    { ::File.exists?("/usr/local/bin/sqlite3") }
end