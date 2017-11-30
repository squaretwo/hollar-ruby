spec = Gem::Specification.new do |s|
  s.name = 'hollar'
  s.version = '0.0.1'
  s.summary = 'Ruby bindings for the Hollar API (https://hollarfulfillment.docs.apiary.io)'
  s.description = s.summary
  s.authors = ['Kyle Barrett']
  s.email = ['kyle@squaretwo.co']

  s.add_dependency('rest-client', '~> 2.0.2')

  s.add_development_dependency('rspec')
  s.add_development_dependency('rake')

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
end
