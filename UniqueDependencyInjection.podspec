Pod::Spec.new do |s|
    s.name         = 'UniqueDependencyInjection'
    s.version      = 'v1.0.2'
    s.license = 'Anti-996-License'
    s.requires_arc = true
    s.source = { :git => 'https://github.com/MacsedProtoss/UniqueDependencyInjection.git', :tag => s.version.to_s }
  
    s.summary         = 'UniqueDependencyInjection'
    s.homepage        = 'https://github.com/MacsedProtoss/UniqueDependencyInjection'
    s.license         = { :type => 'Anti-996-License' }
    s.author          = { 'MacsedProtoss' => 'macsedprotoss@gmail.com' }
    s.platform        = :ios,osx
    s.swift_version   = '5.0'
    s.source_files    =  'Sources/**/*.{swift}'
    s.ios.deployment_target = '10.0'
    spec.osx.deployment_target  = '10.15'
    
  end