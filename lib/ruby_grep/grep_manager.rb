module RubyGrep
  class GrepManager
    attr_reader :file_reader, :matcher, :outputter

    def initialize(options, expression, file_names)
      @file_reader = FileReader.new(file_names, options[RubyGrep.file_read_options_key])
      @expression = Regexp.new(expression)
      @matcher = nil
      @outputter = nil
    end

    def run
      file_reader.each_line do |line_data|
        if (match_data = @expression.match line_data[:str])
          puts line_data[:str].insert(match_data.begin(0),'\033[31m').insert(match_data.end(0)+6,'\033[0m')
        end
      end
    end
  end
end
