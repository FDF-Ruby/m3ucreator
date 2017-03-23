SOURCE_FOLDER = "D:/music/"
DRIVE = 'D:/'

module M3uCreator
  extend self

  def process
    list = list_main_folders
    create_files(list: list)
  end

  private

  def list_main_folders
    puts "Scanning folders in #{SOURCE_FOLDER}"
    folders_list = Dir.
                   glob("#{SOURCE_FOLDER}*").
                   select { |fn| File.directory?(fn) }
  end

  def create_files(list:)
    list.each do |item|
      name = File.basename(item)
      puts "Creating file for #{name}"
      files = list_files_in_folder(folder: item)
      puts "Files: \n#{files}"
      save_contents(file_name: name, contents: files)
    end
  end

  def list_files_in_folder(folder:)
    puts "Searching in folder: #{folder}"
    Dir.
    glob("#{folder}/**/*.mp3").
    select { |fn| !File.directory?(fn) }.
    map { |full_path| full_path.split(':').last}
  end

  def save_contents(file_name:, contents:)
    file_path = File.join(DRIVE, "#{file_name}.m3u")
    File.open(file_path, 'w') do |f|
      contents.each do |element|
        f.puts(element)
      end
    end
    puts "File #{file_path} created"
  end
end

M3uCreator.process
