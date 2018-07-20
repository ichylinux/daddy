require 'itamae/resource/file'

module Itamae
  module Resource
    class File < Base

      private

      def send_tempfile
        if !attributes.content && !content_file
          @temppath = nil
          return
        end

        begin
          src = if content_file
                  content_file
                else
                  f = Tempfile.open('itamae')
                  f.write(attributes.content)
                  f.close
                  f.path
                end

          @temppath = ::File.join(runner.tmpdir, Time.now.to_f.to_s)

          if backend.is_a?(Itamae::Backend::Docker)
            run_command(["mkdir", @temppath])
            backend.send_file(src, @temppath)
            @temppath = ::File.join(@temppath, ::File.basename(src))
          else
            backend.send_file(src, @temppath)
          end

          run_specinfra(:change_file_mode, @temppath, '0600')
        ensure
          f.unlink if f
        end
      end

    end
  end
end
