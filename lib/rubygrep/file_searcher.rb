module Rubygrep
  class FileSearcher
    attr_accessor :options, :found_file_names

    def initialize(options = {})
      @options = options
      @found_file_names = []
    end

    def search(file_names)
      search_with_options(file_names)
      found_file_names
    end

    private

    def search_with_options(file_names, current_folder = '.')
      file_names.each do |file_name|
        file_path = relative_path(file_name, current_folder)
        if File.directory?(file_path) && options[:recursive]
          search_with_options(inner_files(file_path), file_path)
        elsif text_file?(file_path)
          found_file_names << file_path
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

    def text_file?(file_name)
      File.file?(file_name)
    end

  end
end