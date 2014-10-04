require 'rubygrep/version'
require 'rubygrep/grep_manager'
require 'rubygrep/ruby_grep_options'
require 'rubygrep/file_reader'
require 'rubygrep/file_searcher'
require 'rubygrep/matcher'
require 'rubygrep/outputter'
require 'optparse'

module Rubygrep

  def self.grep
    options = RubyGrepOptions.new(ARGV)
    GrepManager.new(options, options.expression, options.file_names).run
  end

end
