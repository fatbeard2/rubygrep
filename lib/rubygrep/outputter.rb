module Rubygrep
  class Outputter

    COLORS = {red: 31, magenta: 35}

    attr_accessor :options

    def initialize(options = {})
      @options = options
    end

    def out(match_data, line_data)
      $stdout << format_with_options(match_data, line_data)
    end

    def error(message, line_data)
      $stdout << "#{colorize(line_data[:path])}: #{message}\n"
    end

    private

    def format_with_options(match_data, line_data)
      result = colorize_match(match_data, "#{line_data[:str]}")
      if options[:line_number]
        result = "#{colorize(line_data[:str_num], :magenta)}: #{result}"
      end
      if options[:with_filename]
        result = "#{colorize(line_data[:path], :magenta)}: #{result}"
      end
      result.include?("\n") ? result : "#{result}\n"
    end

    def colorize(string, color = :red)
      "\033[#{COLORS[color]}m#{string}\033[0m"
    end

    def colorize_match(match_data, string)
      string.gsub(match_data.regexp) do |match|
        colorize(match)
      end
    end
  end
end