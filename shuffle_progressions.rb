require 'bundler/inline'

TEST_MODE = ENV.key?("TEST")
TEST_TECHNIQUE = "test_technique.csv"
TEST_INPUT_PATH = File.join(File.dirname(__FILE__), "test_dir")
OUTPUT_CSV_FILE_PATH = File.join(File.dirname(__FILE__), "shuffled_progressions.csv")

def test
  puts "THIS IS A TEST"
  require "tempfile"
  test_output_file = Tempfile.new
  test_input_file_path_csv = File.join(TEST_INPUT_PATH, TEST_TECHNIQUE)
  begin
    run(TEST_TECHNIQUE, TEST_INPUT_PATH)
    puts "Difference of #{test_input_file_path_csv} and #{test_output_file.path}"
    puts `diff #{test_input_file_path_csv} #{test_output_file.path}`
  ensure
    test_output_file.close
    test_output_file.unlink
  end

end

def run(technique = ARGV[0], input_path = ARGV[1])
  exit_because_of("TECHNIQUE") unless technique
  exit_because_of("INPUT CSV FILE PATH") unless input_path
  require "csv"

  technique_csv = "#{technique}.csv"
  input_file_path_csv = File.join(File.dirname(__FILE__), input_path, technique_csv)
  puts "INPUT FILE PATH CSV: #{input_file_path_csv}"
  progressions = CSV.read(input_file_path_csv)
  shuffled_routine = progressions.shuffle[1..5]
  puts "SHUFFLED ROUTINE: #{shuffled_routine}"

  CSV.open(OUTPUT_CSV_FILE_PATH, "wb") do |csv|
    shuffled_routine.each do |progression|
      csv << progression
    end
  end
end

def exit_because_of(arg_name)
  puts "Missing #{arg_name}"
  exit
end

TEST_MODE ? test : run
