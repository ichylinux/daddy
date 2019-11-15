if defined?(RailsERD)
  Rake::Task['db:migrate'].enhance do
    ENV['filename'] = 'tmp/db_layout'
    ENV['attributes'] = 'foreign_keys, content, primary_keys, timestamp, inheritance'
    ENV['inheritance'] = 'true'

    excludes = ['ActiveRecord::SchemaMigration']
    excludes << 'ActiveRecord::SessionStore::Session' if defined?(ActiveRecord::SessionStore)
    case Rails::VERSION::MAJOR
    when 5
      excludes << 'ActiveRecord::InternalMetadata'
      excludes << 'ActiveStorage::Blob'
      excludes << 'ActiveStorage::Attachment'
    end

    if defined?(Nostalgic)
      excludes << 'Nostalgic::Attr'
    end

    ENV['exclude'] = excludes.join(',')

    Rake::Task['erd'].invoke
  end if Rails.env.development?
end
