require 'bundler'
Bundler::GemHelper.install_tasks

task :erd do
  `bundle exec ruby ./etc/erd.rb > ./etc/erd.dot`
  `dot -Tpng ./etc/erd.dot -o ./etc/erd.png`
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test => :spec

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  task :rubocop do
    $stderr.puts 'Rubocop is disabled'
  end
end

require 'yard'
YARD::Rake::YardocTask.new

require 'yardstick/rake/measurement'
Yardstick::Rake::Measurement.new do |measurement|
  measurement.output = 'measurement/report.txt'
end

require 'yardstick/rake/verify'
Yardstick::Rake::Verify.new do |verify|
  verify.threshold = 57.1
end

task :default => [:spec, :rubocop, :verify_measurements]
