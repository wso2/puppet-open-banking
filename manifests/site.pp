
stage { 'custom': }

# Order stages
Stage['main'] -> Stage['custom']

node default {
  class { "::${::profile}": }
  class { "::${::profile}::custom":
    stage => 'custom'
  }
}

