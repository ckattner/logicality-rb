require "./lib/logicality/version"

Gem::Specification.new do |s|

  s.name        = 'logicality'
  s.version     = Logicality::VERSION
  s.summary     = "String-based boolean expression evaluator"

  s.description = <<-EOS
    A common problem that many frameworks have is the ability to give developers
    an expressive intermediary scripting language or DSL.
    Logicality helps solve this problem by providing a simple boolean
    expression evaluator.
  EOS

  s.authors     = [ 'Matthew Ruggio' ]
  s.email       = [ 'mruggio@bluemarblepayroll.com' ]
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.homepage    = 'https://github.com/bluemarblepayroll/logicality-rb'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.3.1'

  s.add_development_dependency('rspec')

end
