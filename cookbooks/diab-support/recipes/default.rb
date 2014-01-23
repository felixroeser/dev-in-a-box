# Install some required packages
%w{
  mc htop tmux screen xtail
  git-core git-flow
  build-essential python2.7-dev automake libcppunit-dev libunwind7-dev
  libncurses5-dev openssl libssl-dev libsasl2-dev libmcrypt-dev mcrypt
  graphviz imagemagick graphicsmagick-libmagick-dev-compat libmagickwand-dev
  libqt4-dev qt4-qmake libcurl4-gnutls-dev
  s3cmd nfs-common
}.each do |pkg|
  package pkg do
    action :install
  end
end