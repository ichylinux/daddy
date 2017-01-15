if defined?(RailsERD)
  Rake::Task['db:migrate'].enhance do
    ENV['filename'] = 'doc/db_layout'
    ENV['attributes'] = 'foreign_keys, content, primary_keys, timestamp'

    excludes = ['ActiveRecord::SchemaMigration']
    excludes << 'ActiveRecord::SessionStore::Session' if defined?(ActiveRecord::SessionStore)
    case Rails::VERSION::MAJOR
    when 5
      excludes << 'ActiveRecord::InternalMetadata'
    end
    ENV['exclude'] = excludes.join(',')

    Rake::Task['erd'].invoke
  end if Rails.env.development?
end
