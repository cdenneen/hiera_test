Exec {
    path => '/usr/local/bin:/usr/bin:/bin',
}

node default {
  include mymodule
}
