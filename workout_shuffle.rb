require 'bundler/inline'

TEST_MODE = ENV.key?("TEST")
TEST_INPUT_CSV_FILE_PATH = File.join(File.dirname(__FILE__), "")

def test
  puts "THIS IS A TEST"
end

def run(exercise = ARGV[0], input_csv_file_path = ARGV[1], output_csv_file_path = ARGV[2] = input_csv_file_path)
  exit_because_of("EXERCISE") unless exercise
  exit_because_of("INPUT CSV FILE PATH") unless input_csv_file_path

  puts "SUCCESSFUL"
end

def exit_because_of(arg_name)
  puts "Missing #{arg_name}"
  exit
end

TEST_MODE ? test : run
