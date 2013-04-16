# coding: UTF-8

module Daddy
  module Cucumber
    module Diff
      
      def git_diff(file, options = {})
        git = Daddy::Git.new
        a = File.read(file).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        b = git.show_previous(file, true).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        diff = format_diff(Differ.diff(a, b))

        if options[:as] == 'new'
          puts "<span class=\"new\">#{file}</span>"
        else
          puts file
        end
        puts "<pre>#{diff}</pre>"
      end
      
      def git_diff_name(*includes)
        git = Daddy::Git.new
        puts '<pre>' + git.git_diff_name(*includes) + '</pre>'
      end
      
      def diff(file_a, file_b)
        a = File.read(file_a)
        b = File.read(file_b)
        diff = format_diff(Differ.diff(a, b))

        puts file_a
        puts "<pre>#{diff}</pre>"
      end

      def show(file)
        puts file
        puts "<pre>#{File.read(file).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')}</pre>"
      end
      
      private
      
      def format_diff(diff)
        lines = []

        diff_lines = diff.to_s.split("\n")
        diff_lines.each_with_index do |line, i|
          if line.index('</del><ins class="differ">') 
            split = line.split('</del><ins class="differ">')
            lines << split[0]
            if split[1].start_with?('"')
              lines << '</del><ins class="differ">"'
              lines << split[1][1..-1]
            else
              lines << '</del><ins class="differ">' + split[1]
            end
          else
            lines << line
          end
        end
        
        lines.join("\n")
      end

    end
  end
end

World(Daddy::Cucumber::Diff)
