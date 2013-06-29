# coding: UTF-8

module Daddy
  module Cucumber
    module Diff
      
      def git_diff(file, options = {})
        options[:as] ||= 'edit'
        
        git = Daddy::Git.new
        a = File.read(file).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        b = git.show_previous(file, true).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        diff = format_diff(Differ.diff(a, b))

        show_filename(file, options)
        puts "<pre>#{diff}</pre>"
      end
      
      def git_diff_name(*includes)
        git = Daddy::Git.new
        puts '<pre>' + git.git_diff_name(*includes) + '</pre>'
      end
      
      def diff(file_a, file_b, options = {})
        a = File.read(file_a)
        b = File.read(file_b)
        diff = format_diff(Differ.diff(a, b))

        show_filename(file_a, options)
        puts "<pre>#{diff}</pre>"
      end

      def show(file, options = {})
        show_filename(file, options)
        puts "<pre>#{File.read(file).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')}</pre>"
      end
      
      private
      
      def show_filename(filename, options = {})
        if options[:as] == 'new'
          puts "<span class=\"new\">[新規作成] #{filename}</span>"
        elsif options[:as] == 'auto'
          puts "<span class=\"auto\">[自動生成] #{filename}</span>"
        elsif options[:as] == 'edit'
          puts "<span class=\"edit\">[編集] #{filename}</span>"
        else
          puts filename
        end
      end
      
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
