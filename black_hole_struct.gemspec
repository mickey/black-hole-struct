require File.expand_path('../lib/black_hole_struct', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Michael Bensoussan"]
  gem.email         = ["mbensoussan.is@gmail.com"]
  gem.summary       = "BlackHoleStruct is a data structure"
  gem.description   = "BlackHoleStruct is a data structure similar to an OpenStruct allowing autovivification."
  gem.license       = "MIT"
  gem.homepage      = "https://github.com/mickey/black_hole_struct"

  gem.files         = Dir["{lib}/**/*", "LICENSE", "README.md"]
  gem.test_files    = Dir["test/**/*"]
  gem.name          = "black_hole_struct"
  gem.require_paths = ["lib"]
  gem.version       = BlackHoleStruct::VERSION

  gem.add_development_dependency "minitest"
  gem.add_development_dependency "yard"
end
