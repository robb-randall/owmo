# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new :spec

RuboCop::RakeTask.new(:rubocop) do |task|
  task.requires << 'rubocop-rake'
end

task default: %i[rubocop spec]
