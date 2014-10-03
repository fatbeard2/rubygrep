module Rubygrep
  class FileReader
    #this class can be splitted in two
    #one for getting files by name
    #another for outputting them line by line
    attr_accessor :file_names, :skip_current_file, :options

    def initialize(file_names, options = {})
      @options = options
      @file_names = []
      process_with_options(file_names)
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

    def process_with_options(file_names, current_folder = '.')
      file_names.each do |file_name|
        file_path = relative_path(file_name, current_folder)
        if File.directory?(file_path) && options[:recursive]
          process_with_options(inner_files(file_path), file_path)
        elsif text_file?(file_path)
          @file_names << file_path
        elsif !File.exists?(file_path)
          puts "No such file or directory #{file_path}"
        end
      end
    end

    def inner_files(folder_name)
      Dir.entries(folder_name).delete_if {|file| file =~ /^\./}
    end

    def relative_path(file_name, folder)
      if file_name =~ /^\\/ || folder == '.'
        file_name
      else
        "#{folder}/#{file_name}"
      end
    end

    def open_file(file_name)
      File.open(file_name)
    rescue Errno::ENOENT
      puts "No such file or directory #{file_name}"
      false
    rescue Errno::EACCES
      puts "Permission denied: #{file_name}"
      false
    end

    def text_file?(file_name)
      true
    end

  end
end