module Rubygrep
  class Outputter
    attr_accessor :options

    def initialize(options)
      @options = options
    end

    def out(match_data, line_data)
      $stdout << format_with_options(match_data, line_data)
    end

    private

    #  puts line_data[:str_num].to_s + ' ' + line_data[:str].insert(match_data.begin(0),'|').insert(match_data.end(0) + 1,'|')
    def format_with_options(match_data, line_data)
      result = "#{line_data[:str]}"
      if options[:line_number]
        result = "#{line_data[:str_num]}: #{result}"
      end
      result
    end

  end
end