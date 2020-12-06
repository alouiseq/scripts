require 'bundler/inline'

TEST_MODE = ENV.key?("TEST")
TEST_TECHNIQUE = "test_technique"
TEST_INPUT_PATH = File.join(File.dirname(__FILE__), "test_dir")
OUTPUT_CSV_FILE_PATH = File.join(File.dirname(__FILE__), "output_shuffled_progressions.csv")
ROUTINE_COUNT = 5

def test
  puts "THIS IS A TEST"
  require "tempfile"
  test_output_file = Tempfile.new
  test_input_file_path_csv = "#{File.join(TEST_INPUT_PATH, TEST_TECHNIQUE)}.csv"
  begin
    run(TEST_INPUT_PATH, TEST_TECHNIQUE)
    puts "Difference between #{test_input_file_path_csv} AND #{test_output_file.path}:"
    puts `diff #{test_input_file_path_csv} #{test_output_file.path}`
  ensure
    test_output_file.close
    test_output_file.unlink
  end
end

def print_usage
  puts "---- Proper script execution ----"
  puts "ruby shuffle_progressions.rb INPUT_CSV_FILE_PATH TECHNIQUE [ROUTINE_COUNT]"
end

def run(input_path = ARGV[0], technique = ARGV[1], routine_count = Integer(ARGV[2] || ROUTINE_COUNT))
  exit_because_of("INPUT CSV FILE PATH") unless input_path
  exit_because_of("TECHNIQUE") unless technique

  require "csv"
  technique_csv = "#{technique}.csv"
  input_file_path_csv = File.join(File.dirname(__FILE__), input_path, technique_csv)
  puts "INPUT FILE PATH CSV: #{input_file_path_csv}"

  begin
    progressions = CSV.read(input_file_path_csv)
    puts "ROUTINE COUNT: #{routine_count}"
    shuffled_routine = progressions.shuffle[1..routine_count]
    puts "SHUFFLED ROUTINE: #{shuffled_routine}"

    puts "WRITING TO FILE..."

    CSV.open(OUTPUT_CSV_FILE_PATH, "wb") do |csv|
      shuffled_routine.each do |progression|
        csv << progression
      end
    end
  rescue SystemCallError => e
    puts "ERROR: #{e}"
  else
    puts "DONE!"
  end
end

def exit_because_of(arg_name)
  puts "Missing #{arg_name}"
  print_usage
  exit
end

TEST_MODE ? test : run
