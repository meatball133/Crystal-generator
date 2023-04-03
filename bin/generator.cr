require "./generator_help"
require "./formatter"

class Generator
  def initialize(exercise, file_name = "./exercises/practice/#{exercise}/spec/#{exercise.gsub("-", "_")}_spec.cr")
    stuff = GeneratorHelp.new(exercise).to_s
    raise "Spec directory not found: ./exercises/practice/#{exercise}/spec" unless Dir.exists?("./exercises/practice/#{exercise}/spec")
    file = File.new(file_name, mode = "wb")
    File.write(file_name, stuff)
    system("crystal tool format #{file_name}")
    File.write(file_name, Formatter.post_proccesing(file_name))
    system("crystal tool format #{file_name}")
  end
end

if ARGV.empty?
  raise ArgumentError.new("Please provide an exercise")
end

if ARGV.size == 1
  Generator.new(ARGV[0])
else
  Generator.new(ARGV[0], ARGV[1])
end
