# Original source https://github.com/sebastianmoreno/chef-cookbooks/blob/master/sqlite

maintainer        "Felix"
maintainer_email  "felix@tout.com"
license           "Apache 2.0"
description       "Installs sqlite from source"
version           "0.0.1"

recipe "sqlite-source", "Installs sqlite from source"

%w{ubuntu debian}.each do |os|
  supports os
end