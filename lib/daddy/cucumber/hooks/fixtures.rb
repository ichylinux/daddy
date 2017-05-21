if ::ActiveRecord::VERSION::MAJOR < 4
  fixture_class = ActiveRecord::Fixtures
else
  fixture_class = ActiveRecord::FixtureSet
end

fixtures_folder = File.join('test', 'fixtures')
fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }

Before do
  fixture_class.create_fixtures(fixtures_folder, fixtures)
end

After do |scenario|
  fixture_class.reset_cache
end
