Gem::Specification.new do |gem|
  gem.name    = 'choices_settings'
  gem.version = '0.5.1'

  gem.required_ruby_version = '>= 2.0'
  gem.add_runtime_dependency 'hashie', '~> 5.0.0'
  gem.add_development_dependency 'minitest', '~> 5.0.6'

  gem.summary = 'Easy settings for your app'
  gem.description = '_Forked from [mislav/choices](https://github.com/mislav/choices)_'

  gem.authors  = ['Mislav Marohnić', 'MonClubSportif']
  gem.email    = 'info@monclubsportif.com'
  gem.homepage = 'https://github.com/monclubsportif/choices_settings'
  gem.license  = 'MIT'

  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*', 'README*', '*LICENSE*']
  gem.test_files = Dir.glob('test/test_*.rb')
end
