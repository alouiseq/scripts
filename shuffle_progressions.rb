require 'bundler/inline'

TEST_MODE = ENV.key?("TEST")
TEST_INPUT_CSV_FILE_PATH = File.join(File.dirname(__FILE__), "test_technique.csv")
OUTPUT_CSV_FILE_PATH = File.join(File.dirname(__FILE__), "shuffled_progressions.csv")

def test
  puts "THIS IS A TEST"
  require "tempfile"
  test_output_file = Tempfile.new
  begin
  #run()
  puts "Difference of #{TEST_INPUT_CSV_FILE_PATH} and #{test_output_file}"
  puts `diff #{TEST_INPUT_CSV_FILE_PATH} #{test_output_file}`
  ensure
    test_output_file.close
    test_output_file.unlink
  end

end

def run(exercise = ARGV[0], input_csv_file_path = ARGV[1])
  exit_because_of("EXERCISE") unless exercise
  exit_because_of("INPUT CSV FILE PATH") unless input_csv_file_path
  require "csv"
  puts "SUCCESSFUL"
end

def exit_because_of(arg_name)
  puts "Missing #{arg_name}"
  exit
end

TEST_MODE ? test : run
