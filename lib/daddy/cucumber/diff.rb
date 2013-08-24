# coding: UTF-8

module Daddy
  module Cucumber
    module Diff
      
      def git_diff(file, options = {})
        options[:as] ||= 'edit'
        
        git = Daddy::Git.new
        a = File.read(file).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        b = git.show_previous(file, true).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        diff = format_diff(Differ.diff(a, b), options)

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
        labels = []
        if options[:as].is_a?(String) or options[:as].is_a?(Symbol)
          labels << options[:as]
        elsif options[:as].is_a?(Array)
          labels += options[:as]
        end

        html = "<span class=\"#{labels.join(' ')}\">"
        labels.each do |label|
          case label.to_s
          when 'auto'
            html << '[自動生成] '
          when 'new'
            html << '[新規作成] '
          when 'edit'
            html << '[編集] '
          end
        end
        
        html << filename
        html << "</span>"

        puts html
      end
      
      def format_diff(diff, options = {})
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
        
        if options[:from] and options[:to]
          from = options[:from] - 1
          to = options[:to] - 1
          lines = lines[from..to]
        elsif options[:from]
          from = options[:from] - 1
          lines = lines[from..-1]
        elsif options[:to]
          to = options[:to] - 1
          lines = lines[0..to]
        end
        
        lines.join("\n")
      end

    end
  end
end

World(Daddy::Cucumber::Diff)
