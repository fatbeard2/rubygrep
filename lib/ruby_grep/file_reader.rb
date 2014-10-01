module RubyGrep
  class FileReader
    attr_accessor :file_names, :skip_current_file

    def initialize(file_names, options)
      @file_names = file_names
      @options = options
    end

    def each_line
      file_names.each do |file_name|
        next_file = open_file(file_name)
        if next_file
          next_file.each_line do |str|
            yield({str: str})
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

    def open_file(file_name)
      path = File.expand_path(file_name, Dir.getwd)
      File.open(path)
    rescue Errno::ENOENT
      puts "No such file or directory #{file_name}"
      false
    rescue Errno::EACCES
      puts "Permission denied: #{file_name}"
      false
    end

  end
end