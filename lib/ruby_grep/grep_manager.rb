module RubyGrep
  class GrepManager
    attr_reader :file_reader, :matcher, :outputter

    def initialize(options, expression, file_names)
      @file_reader = FileReader.new(file_names, options.file_reader_options)
      @matcher = Matcher.new(expression, options.matcher_options)
      #@outputter = Outputter.new(options.outputter_options)
    end

    def run
      file_reader.each_line do |line_data|
        if (match_data = matcher.matches?(line_data))
          puts line_data[:str].insert(match_data.begin(0),'|').insert(match_data.end(0) + 1,'|')
        end
      end
    end
  end
end
