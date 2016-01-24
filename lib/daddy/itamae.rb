require 'itamae/resource/remote_file'

module Itamae
  module Resource
    class Template

      def find_source_file_with_daddy_convention
        begin
          ret = find_source_file_without_daddy_convention
        rescue SourceNotFoundError => e
          if attributes.source == :auto
            ret = find_source_file_in_templates
          else
            raise e
          end
        end

        ret
      end

      def find_source_file_in_templates
        itamae_dir = ::File.expand_path('../../../itamae', __FILE__)
        path = ::File.join(itamae_dir, source_file_dir, "#{attributes.path}.erb")
        if ::File.exist?(path)
          path
        else
          raise SourceNotFoundError, "source file is not found (searched in daddy path: #{path})"
        end
      end

      alias_method :find_source_file_without_daddy_convention, :find_source_file
      alias_method :find_source_file, :find_source_file_with_daddy_convention
    end
  end
end
