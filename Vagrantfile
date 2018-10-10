Vagrant.configure('2') do |config|
  config.vm.box = 'genebean/centos-7-puppet5'
  config.vm.hostname = 'vagrant-tester-dev-1.local'
  config.vm.provision 'shell', inline: <<-EOF
    rm -f /etc/yum.repos.d/puppet5.repo
    yum -y remove puppet5-release
    yum -y localinstall https://yum.puppet.com/puppet6/puppet6-release-el-7.noarch.rpm
    yum -y upgrade puppet
    yum -y install pdk
    ln -s /vagrant /etc/puppetlabs/code/modules/classification
    /opt/puppetlabs/bin/puppet module install puppetlabs-stdlib
    /opt/puppetlabs/bin/facter -p classification
  EOF
end
