# = Class: mymodule

class mymodule (
  $template = undef,
  $options  = undef,
  #$options  = hiera('$options', undef),
  #$options  = hiera_hash('$options', undef),
){

  file { "mymodule_config":
    path    => '/tmp/mymodule.conf',
    content => template($template),
  }
}
