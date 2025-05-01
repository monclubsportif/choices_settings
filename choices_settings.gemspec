Gem::Specification.new do |gem|
  gem.name    = 'choices_settings'
  gem.version = '0.5.0'

  gem.add_dependency 'hashie', '>= 0.4.0'
  gem.add_development_dependency 'minitest', '~> 5.0.6'

  gem.summary = 'Easy settings for your app'
  # gem.description = "Longer description."

  gem.authors  = ['Mislav Marohnić', 'MonClubSportif']
  gem.email    = 'info@monclubsportif.com'
  gem.homepage = 'https://github.com/monclubsportif/choices_settings'
  gem.license  = 'MIT'

  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*', 'README*', '*LICENSE*']
  gem.test_files = Dir.glob('test/test_*.rb')
end
