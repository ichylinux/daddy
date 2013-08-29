begin
  require 'database_cleaner'
  require 'database_cleaner/cucumber'

  DatabaseCleaner.strategy = :truncation
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Before do
  DatabaseCleaner.start

  ActiveRecord::Fixtures.reset_cache
  fixtures_folder = File.join(Rails.root, 'test', 'fixtures')
  fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
  ActiveRecord::Fixtures.create_fixtures(fixtures_folder, fixtures)
  if defined? RailsCsvFixtures
    fixtures = Dir[File.join(fixtures_folder, '*.csv')].map {|f| File.basename(f, '.csv') }
    ActiveRecord::Fixtures.create_fixtures(fixtures_folder, fixtures)
  end
end

After do |scenario|
  DatabaseCleaner.clean
end
