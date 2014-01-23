site :opscode

cookbook 'apt'
cookbook 'ark', path: 'cookbooks/ark'
cookbook 'maven'
cookbook 'diab-support', path: 'cookbooks/diab-support'

cookbook 'ruby_build', git: 'git@github.com:fnichol/chef-ruby_build.git'
cookbook 'rbenv',      git: 'git://github.com/fnichol/chef-rbenv.git'
cookbook 'nodejs'

cookbook 'redisio',    git: 'git://github.com/brianbianco/redisio.git'
cookbook 'memcached',  git: 'git://github.com/opscode-cookbooks/memcached.git'
cookbook 'mongodb', git: 'git://github.com/edelight/chef-mongodb.git'

cookbook 'phantomjs', git: 'git@github.com:customink-webops/phantomjs.git'

%w(mysql java sqlite-source coffeescript kestrel).each do |r|
  cookbook r, path: "cookbooks/#{r}"
end
