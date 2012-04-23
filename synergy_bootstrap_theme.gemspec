Gem::Specification.new do |s|
  s.name         = 'synergy_bootstrap_theme'
  s.version      = '0.0.0'
  s.date         = '2012-04-23'
  s.summary      = "Synergy theme with twitter bootstrap"
  s.description  = "A simple synergy theme based on synergy_default_theme with twitter bootstrap"
  s.author       = "Ramil Mustafin"
  s.email        = 'rommel.rmm@gmail.com'

  s.files        = `git ls-files`.split("\n")
  s.require_path = 'lib'
  s.homepage     = 'https://github.com/R0mmel/synergy_bootstrap_theme'

  s.required_ruby_version = '>= 1.8.7'
  s.requirements << 'none'

  #s.add_dependency('synergy', '~> 0.60.0')
  #s.add_dependency('dalli', '~> 1.0.3')
end

