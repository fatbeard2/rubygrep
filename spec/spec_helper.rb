require 'rubygrep/version'
require 'rubygrep/grep_manager'
require 'rubygrep/ruby_grep_options'
require 'rubygrep/file_reader'
require 'rubygrep/matcher'
require 'rubygrep/outputter'
require 'optparse'

RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true

  # Use the specified formatter
  config.formatter = :progress # :progress, :html, :textmate
end