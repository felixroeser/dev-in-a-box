# shared stuff between the different Vagrantfiles
def add_recipes_to_chef(chef)
  %w(
    apt diab-support 
    ruby_build rbenv::user rbenv::vagrant
    nodejs nodejs::npm coffeescript
    phantomjs::default
    memcached redisio::install redisio::enable
    mysql::client mysql::server sqlite-source
    mongodb::10gen_repo mongodb
    java::openjdk ark maven kestrel
  ).each { |recipe| chef.add_recipe recipe }
end

def recipe_config
  { 'rbenv' =>  {
      "user_installs" => [
        { 'user' => 'vagrant',
          'rubies'  => ['1.9.3-p484', '2.0.0-p353'],
          'global'  => '1.9.3-p484',
          'gems' => { 
            '1.9.3-p484' => [
              {'name' => 'bundler'},
              {'name' => 'rake' },
              {'name' => 'thor' },
              {'name' => 'foreman' },
              {'name' => 'puma' },
              {'name' => 'pry' }
            ],
            '2.0.0-p353' => [
              {'name' => 'bundler'},
              {'name' => 'thor' },
              {'name' => 'foreman' },
              {'name' => 'puma' },
              {'name' => 'pry' }
            ] 
          }
        }
      ]
    },
    'nodejs' => { 
      'version' => '0.10.24',
      'npm' => '1.3.24'
    },
    'coffeescript' => { 'version' => '1.6.3' },
    'redisio' => { 
      'version' => '2.8.4',
      'mirror' => 'http://download.redis.io/releases'
    },
    'mongodb' => {
        'dbpath' => 'data/mongo',
        'version' => '2.4.9'
      },    
    'java' => { 'jdk_version' => '7' },
    'maven' => { 
      'version' => 3,
      'setup_bin' => true,
      '3' => {
        'version' => '3.0.5'
      }
    },
    'mysql' => {
      'server_root_password' => '',
      'allow_remote_root' => true,
      'bind_address' => '0.0.0.0'
    },
    'memcached' => {
      'memory' => '64M'
    },
    'phantomjs' => {
      'version' => '1.9.0'
    }
  }
end  
