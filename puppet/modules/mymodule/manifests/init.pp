# = Class: mymodule

class mymodule (
  $template = undef,
  #$options  = undef,
  $my_options  = hiera_hash('mymodule::options', undef)
){
  $options = $my_options
  # or get rid of $my_options
  # $options  = hiera_hash('mymodule::options', undef)

  file { "mymodule_config":
    path    => '/tmp/mymodule.conf',
    content => template($template),
  }
}
