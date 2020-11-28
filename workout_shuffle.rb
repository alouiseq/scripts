require 'bundler/inline'

TEST_MODE = ENV.key?("TEST")
TEST_INPUT_CSV_FILE_PATH = File.join(File.dirname(__FILE__), "")
