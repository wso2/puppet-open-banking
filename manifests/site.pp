stage { 'custom': }
stage { 'final': }

# Order stages
Stage['main'] -> Stage['custom'] -> Stage['final']

node default{
  class { "::${::profile}": }
  class { "::${::profile}::custom":
    stage => 'custom'
  }
  class { "::${::profile}::startserver":
    stage => 'final'
  }
}

