Gem::Specification.new do |s|
  s.name        = 'binomial_distribution'
  s.version     = File.read("version")
  s.date        = Time.now.getgm.to_s.split.first
  s.summary     = File.read("CHANGELOG").match(/^v[^\n]+\n((\t[^\n]+\n)+)/m)[1].split("\t").join
  s.description = 'A ruby implementation of the Binomial Distribution'
  s.authors     = ['Nephos (poulet_a)']
  s.email       = ['arthur.poulet@mailoo.org']
  s.files       = %w(
  lib/binomial_distribution.rb

  README.md
  CHANGELOG

  Rakefile
  Gemfile
  Gemfile.lock
  binomial_distribution.gemspec
  version

  test/unit_test.rb
  test/binomial_distribution.rb

  certs/nephos.pem
  )
  s.executables = %w(
  )
  s.homepage    = 'https://github.com/Nephos/BinomialDistribution'
  s.license     = 'WTFPL'

  s.cert_chain  = ['certs/nephos.pem']
  s.signing_key = File.expand_path('~/.ssh/gem-private_key.pem') if $0 =~ /gem\z/

  # s.add_dependency 'nephos', '~> 1.0'
  s.add_dependency 'nomorebeer', '~> 1.1'

end
