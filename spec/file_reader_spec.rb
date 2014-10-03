RSpec.describe Rubygrep::FileReader do

  let (:one_file) { 'text1.txt' }
  let (:several_files) {%w(text1.txt ./text2.txt ../text3.txt ../folder/text4.txt /root/woop/foo/bar/text5.txt)}

  let (:init_dirs) { %w(folder1 /home/user/me) }
  let (:inner_files) {%w(folder1/text1.txt folder1/text2.txt /home/user/me/1.txt /home/user/me/2.txt)}
  let (:inner_files_tree) { {'folder1' => %w(text1.txt text2.txt), '/home/user/me' => %w(1.txt 2.txt)}}

  def get_entries(dir_name)
    inner_files_tree[dir_name]
  end

  it 'lookup for one file' do
    allow(File).to receive(:file?).with(one_file).and_return(true)
    reader = Rubygrep::FileReader.new([one_file])
    expect(reader.file_names).to eq(%w(text1.txt))
  end

  context 'with several files' do
    let (:reader) {Rubygrep::FileReader.new(several_files)}
    before do
      allow(File).to receive(:file?) { |file_name| several_files.include?(file_name) }
      allow(File).to receive(:open) { |file_name| StringIO.new("#{file_name}\n#{file_name}") }
    end

    it 'should lookup for several files' do
      expect(reader.file_names).to eq(several_files)
      expect { |l| reader.each_line(&l) }.to yield_control.at_least(10).times
    end

  end

  context 'with -recursive option' do
    let (:reader) {Rubygrep::FileReader.new(init_dirs, {:recursive => true})}
    before do
      allow(File).to receive(:file?) { |file_name| inner_files.include?(file_name) }
      allow(File).to receive(:directory?) { |dir_name| init_dirs.include?(dir_name) }
      allow(Dir).to receive(:entries) { |dir_name| puts(get_entries(dir_name)); get_entries(dir_name) }
      allow(File).to receive(:open) { |file_name| StringIO.new("#{file_name}\n#{file_name}") }
    end

    it 'should recursivly pick up files' do
      expect(reader.file_names).to eq(inner_files)
      expect { |l| reader.each_line(&l) }.to yield_control.at_least(2).times
    end
  end



end