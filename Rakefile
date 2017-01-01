require 'bundler'
require 'yard'
Bundler::GemHelper.install_tasks

require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.test_files = FileList['test/*_test.rb']
  test.verbose = true
end

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
end
