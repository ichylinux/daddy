# coding: UTF-8

if defined?(RailsCsvFixtures)
  namespace :db do
    namespace :fixtures do
      desc "Load fixtures into the current environment's database. Load specific fixtures using FIXTURES=x,y. Load from subdirectory in test/fixtures using FIXTURES_DIR=z. Specify an alternative path (eg. spec/fixtures) using FIXTURES_PATH=spec/fixtures."
      task :load => [:environment, :load_config] do
        require 'active_record/fixtures'
  
        base_dir     = File.join [Rails.root, ENV['FIXTURES_PATH'] || %w{test fixtures}].flatten
        fixtures_dir = File.join [base_dir, ENV['FIXTURES_DIR']].compact
  
        (ENV['FIXTURES'] ? ENV['FIXTURES'].split(/,/) : Dir["#{fixtures_dir}/**/*.{yml,csv}"].map {|f| f[(fixtures_dir.size + 1)..-5] }).each do |fixture_file|
          ActiveRecord::Fixtures.create_fixtures(fixtures_dir, fixture_file)
        end
      end
    end
  end
end
