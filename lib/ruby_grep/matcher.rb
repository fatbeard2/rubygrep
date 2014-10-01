module RubyGrep
  class Matcher
    attr_accessor :options, :regexp

    def initialize(regexp, options)
      @options = options
      @regexp = process_with_options(regexp)

    end

    def matches?(string_data)
      regexp.match(string_data[:str])
    end

    private

    def process_with_options(regexp)
      Regexp.compile(regexp, options[:ignore_case])
    end
  end
end