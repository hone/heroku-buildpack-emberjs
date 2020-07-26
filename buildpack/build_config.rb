def gem_config(conf)
  #conf.gembox 'default'

  # be sure to include this gem (the cli app)
  conf.gem File.expand_path(File.dirname(__FILE__))
  conf.gem core: 'mruby-sprintf'
  conf.gem core: 'mruby-time'
  conf.gem core: 'mruby-print'
  conf.gem mgem: 'mruby-simple-random'
  conf.gem github: 'hone/mruby-io', branch: 'popen_status'
  conf.gem github: 'hone/mruby-process', branch: 'header'
  conf.gem github: 'mattn/mruby-onig-regexp', checksum_hash: '4873e87fc1842e8e2a417f6071b63a7d91523ef4'
  #conf.enable_cxx_abi
end

MRuby::Build.new do |conf|
  toolchain :gcc

  conf.enable_bintest
  conf.enable_debug
  conf.enable_test

  gem_config(conf)
end

MRuby::Build.new('x86_64-pc-linux-gnu') do |conf|
  toolchain :gcc

  ["-static-libgcc", "-static-libstdc++"].each do |flag|
    conf.linker.flags << flag
  end

  gem_config(conf)
end
