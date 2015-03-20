# coding: UTF-8

module Daddy
  module Cucumber
    module Diff
      
      def git_diff(file, options = {})
        options[:as] = 'edit' unless options.has_key?(:as)
        remote = options.has_key?(:remote) ? options[:remote] : true 

        git = Daddy::Git.new
        
        if options[:between]
          a = git.show_previous(file, :commit => options[:between], :remote => remote)
        else
          a = File.read(file)
        end
        a = a.gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')

        if options[:and]
          b = git.show_previous(file, :commit => options[:and], :remote => remote)
        else
          b = git.show_previous(file, :remote => remote)
        end
        b = b.gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')

        diff = format_diff(Differ.diff(a, b), options)

        show_filename(file, options)
        puts "<pre>#{diff}</pre>"
      end

      def git_diff_name(*includes)
        git = Daddy::Git.new
        puts '<pre>' + git.git_diff_name(*includes) + '</pre>'
      end
      
      def diff(file_a, file_b, options = {})
        a = File.read(file_a).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        b = File.read(file_b).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        diff = format_diff(Differ.diff(a, b))

        show_filename(file_a, options)
        puts "<pre>#{diff}</pre>"
      end

      def show(file, options = {})
        show_filename(file, options)

        if options[:commit].present?
          git = Daddy::Git.new
          content = git.show_previous(file, :commit => options[:commit], :remote => options[:remote])
          lines = content.split(/\r\n|\r|\n/).map{|line| line + "\n"}
        else
          lines = File.readlines(file)
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

        lines = lines.join.gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        puts "<pre>#{lines}</pre>"

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
        diff_lines = diff.to_s.split("\n")

        if options[:from] and options[:to]
          from = options[:from] - 1
          to = options[:to] - 1
          diff_lines = diff_lines[from..to]
        elsif options[:from]
          from = options[:from] - 1
          diff_lines = diff_lines[from..-1]
        elsif options[:to]
          to = options[:to] - 1
          diff_lines = diff_lines[0..to]
        end

        diff_lines.join("\n")
      end

    end
  end
end

World(Daddy::Cucumber::Diff)