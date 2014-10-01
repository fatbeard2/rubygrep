module RubyGrep
  class RubyGrepOptions
    attr_accessor :file_reader_options, :matcher_options, :outputter_options

    def initialize(args)
      @file_reader_options = Hash.new
      @matcher_options = Hash.new
      @outputter_options = Hash.new
      options_parser.parse!(args)
    end

    private

    def options_parser
      OptionParser.new do |opts|
        opts.banner = 'Usage: RubyGrep.grep [options] expression [file1 file2] ...'

        #file_reader_options
        opts.on( '-r', '--recursive', 'recursively read directories' ) do
          file_reader_options[:recursive] = true
        end

        #matcher_options
        opts.on( '-i', '--ignorecase', 'Ignore case when matching strings' ) do
          matcher_options[:ignore_case] = true
        end

        #outputter_options
        opts.on( '-m', '--mark', 'mark matched string' ) do
          outputter_options[:mark_selection] = true
        end
      end
    end

   end
end