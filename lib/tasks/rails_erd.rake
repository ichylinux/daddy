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
    when 6
      excludes << 'ActiveRecord::InternalMetadata'
      excludes << 'ActiveStorage::Blob'
      excludes << 'ActiveStorage::Attachment'
      excludes << 'ActiveStorage::VariantRecord'
    end

    if defined?(Nostalgic)
      excludes << 'Nostalgic::Attr'
    end

    ENV['exclude'] = (ENV['rails_erd.exclude'].to_s.split(',') + excludes).join(',')

    Rake::Task['erd'].invoke
  end if Rails.env.development?
end
