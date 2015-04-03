Gem::Specification.new do |s|
  s.name        = 'meetup'
  s.version     = '0.1.0'
  s.date        = '2015-04-02'
  s.summary     = "A ruby API wrapper for Meetup"
  s.authors     = ["Adam Butler"]
  s.email       = 'adam@lab.io'
  s.files       = Dir["{lib}/**/*", "Gemfile"]
  s.homepage    =
    'http://rubygems.org/gems/meetup'
  s.license       = 'MIT'
  s.add_dependency "activesupport", ["~> 4.2.1"]
  s.add_dependency "httparty", ["~> 0.13.3"]
end
