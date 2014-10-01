require 'optparse'

module RubyGrep

  def self.options
    @options ||= {}
  end

  def self.file_read_options_key
    :file_read_options
  end

  def self.file_read_options_parser
    OptionParser.new do |opts|
      options[file_read_options_key] = {}
      opts.banner = 'Usage: RubyGrep.grep [options] expression [file1 file2] ...'
      opts.on( '-r', '--recursive', 'recursively read directories' ) do
        options[file_read_options_key][:recursive] = true
      end
    end
  end

  def self.grep
    file_read_options_parser.parse!
    raise 'Expression is required' unless ARGV[0]
    raise 'At least one file is required' unless ARGV[1]
    GrepManager.new(options, ARGV.shift, ARGV).run
  end

end