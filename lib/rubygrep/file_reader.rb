module Rubygrep
  class FileReader

    attr_accessor :file_names, :skip_current_file, :options

    def initialize(file_names, options = {})
      @options = options
      @file_names = FileSearcher.new(options).search(file_names)
    end

    def each_line
      file_names.each do |file_name|
        next_file = open_file(file_name)
        num = 0
        if next_file
          next_file.each_line do |str|
            yield({str: str, path: file_name, str_num: num+=1})
            if skip_current_file
              @skip_current_file = false
              break
            end
          end
        end
      end
    end

    def next_file!
      @skip_current_file = true
    end

    private

    def open_file(file_name)
      File.open(file_name)
    rescue Errno::ENOENT
      puts "No such file or directory #{file_name}"
      false
    rescue Errno::EACCES
      puts "Permission denied: #{file_name}"
      false
    end

  end
end