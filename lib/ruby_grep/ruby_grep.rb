require 'optparse'

module RubyGrep

  def self.grep
    options = RubyGrepOptions.new(ARGV)
    raise 'Expression is required' unless ARGV[0]
    raise 'At least one file is required' unless ARGV[1]
    GrepManager.new(options, ARGV.shift, ARGV).run
  end

end