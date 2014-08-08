# Install Ruby
if [ "$(rpm -q ruby)" = "package ruby is not installed" ]; then
  yum install -y ruby rubygems ruby-devel
fi

# Install Puppet

if [ "$(gem search -i puppet)" = "false" ]; then
    gem install puppet -v 3.4.2 --no-ri --no-rdoc
fi

# Setup Hiera

if [ "$(gem search -i deep_merge)" = "false" ]; then
    # deep merge gem required for deeper hiera_hash merging
    # http://docs.puppetlabs.com/hiera/1/lookup_types.html#deep-merging-in-hiera--120
    gem install deep_merge --no-ri --no-rdoc
fi
