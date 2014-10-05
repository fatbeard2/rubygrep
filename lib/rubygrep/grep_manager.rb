module Rubygrep
  class GrepManager
    attr_reader :file_reader, :matcher, :outputter

    def initialize(options)
      @file_reader = FileReader.new(options.file_names, options.file_reader_options)
      options.set_multi_file_mode if @file_reader.has_several_files?
      @matcher = Matcher.new(options.expression, options.matcher_options)
      @outputter = Outputter.new(options.outputter_options)
    end

    def run
      file_reader.each_line do |line_data|
        begin
          match_data = matcher.matches?(line_data)
          if match_data
            outputter.out(match_data, line_data)
          end
        rescue Exception => e
          file_reader.next_file!
        end
      end
    end
  end
end
