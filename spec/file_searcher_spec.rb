RSpec.describe Rubygrep::FileSearcher do

  let (:one_file) { 'text1.txt' }
  let (:several_files) {%w(text1.txt ./text2.txt ../text3.txt ../folder/text4.txt /root/woop/foo/bar/text5.txt)}

  let (:init_dirs) { %w(folder1 /home/user/me) }
  let (:inner_files_tree) {{
      'folder1' => %w(inner1 inner2 inner3),
      'folder1/inner1' => %w(inner1.txt inner2.txt),
      'folder1/inner2' => %w(inner1.txt inner2.txt),
      'folder1/inner3' => %w(inner1.txt inner2.txt),
      '/home/user/me' => %w(1.txt 2.txt 1 2),
      '/home/user/me/1' => %w(1.txt 2.txt),
      '/home/user/me/2' => %w(1.txt 2.txt)
  }}
  let (:result_files) do
    inner_files_tree.map do |dir, files|
      files.collect { |file_name| "#{dir}/#{file_name}" if file_name =~ /\.txt/ }
    end.flatten.compact
  end

  def get_entries(dir_name)
    inner_files_tree[dir_name]
  end

  let (:searcher) { Rubygrep::FileSearcher.new }
  let (:recursive_searcher) { Rubygrep::FileSearcher.new({:recursive => true}) }

  it 'lookup for one file' do
    allow(File).to receive(:file?).with(one_file).and_return(true)
    expect(searcher.search([one_file])).to eq(%w(text1.txt))
  end

  context 'with several files' do
    it 'should lookup for several files' do
      allow(File).to receive(:file?) { |file_name| several_files.include?(file_name) }
      expect(searcher.search(several_files)).to eq(several_files)
    end
  end

  context 'with -recursive option' do
    before do
      allow(File).to receive(:file?) { |file_name| file_name =~ /\.txt/ }
      allow(File).to receive(:directory?) { |dir_name| !(dir_name =~ /\.txt/) }
      allow(Dir).to receive(:entries) { |dir_name| get_entries(dir_name) }
    end

    it 'should recursivly pick up files' do
      expect(recursive_searcher.search(init_dirs)).to eq(result_files)
    end
  end



end