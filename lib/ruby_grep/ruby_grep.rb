require 'optparse'

module RubyGrep

  def self.grep
    options = RubyGrepOptions.new(ARGV)
    GrepManager.new(options, options.expression, options.file_names).run
  end

end