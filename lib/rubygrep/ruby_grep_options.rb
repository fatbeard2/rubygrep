module Rubygrep
  class RubyGrepOptions
    attr_accessor :file_reader_options, :matcher_options, :outputter_options,
                  :general_output_options, :file_names, :expression

    def initialize(args)
      @file_reader_options, @matcher_options, @outputter_options = {}, {}, {}
      parse_options(args)
    end

    def set_multi_file_mode
      outputter_options[:with_filename] = true
    end

    private

    def parse_options(args)
      options_parser.parse!(args)
      end_grep('Expression is required') unless args[0]
      @expression = args.shift
      end_grep('At least one file in required') unless args[0]
      @file_names = args
      end

    def end_grep(message)
      raise message
    end

    def options_parser
      OptionParser.new do |opts|
        opts.banner = 'Usage: rubygrep.grep [options] expression [file1 file2] ...'

        #file_reader_options
        opts.on( '-r', '--recursive', 'recursively read directories' ) do
          file_reader_options[:recursive] = true
        end

        #matcher_options
        opts.on( '-i', '--ignore-case', 'Ignore case when matching strings.' ) do
          matcher_options[:ignore_case] = true
        end

        opts.on( '-v', '--invert-selection', 'Invert the sense of matching, to select non-matching lines.') do
          matcher_options[:invert_selection] = true
        end

        #outputter_options
        # opts.on( '-m', '--mark', 'mark matched string' ) do |symbol|
        #   outputter_options[:mark_selection] = symbol || '|'
        # end

        opts.on('-n','--line-number','Prefix each line of output with the 1-based line number within its input file.') do
          outputter_options[:line_number] = true
        end

        opts.on('-H','--with-filename', 'Print the file name for each match. This is the default when there is more than one file to search.') do
          outputter_options[:with_filename] = true
        end
      end
    end

   end
end