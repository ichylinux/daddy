begin
  require 'database_cleaner'
  require 'database_cleaner/cucumber'

  DatabaseCleaner.strategy = :truncation
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Before do
  DatabaseCleaner.start

  if ::ActiveRecord::VERSION::MAJOR < 4
    fixture_class = ActiveRecord::Fixtures
  else
    fixture_class = ActiveRecord::FixtureSet
  end

  fixture_class.reset_cache
  fixtures_folder = File.join(Rails.root, 'test', 'fixtures')
  fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
  fixture_class.create_fixtures(fixtures_folder, fixtures)
  if defined? RailsCsvFixtures
    fixtures = Dir[File.join(fixtures_folder, '*.csv')].map {|f| File.basename(f, '.csv') }
    fixture_class.create_fixtures(fixtures_folder, fixtures)
  end
end

After do |scenario|
  DatabaseCleaner.clean
end
