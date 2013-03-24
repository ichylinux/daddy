# coding: UTF-8

module Daddy
  module Cucumber
    module Diff
      
      def git_diff(local_file, git_path)
        git = Daddy::Git.new
        a = File.read(local_file).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        b = git.show_previous(git_path, true).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        diff = Differ.diff(a, b)

        diff_lines = diff.to_s.split("\n")
        lines = []
        puts diff_lines.size
        diff_lines.each_with_index do |line, i|
          if line.index('<del ') and line.index('<ins ') 
            split = line.split('<ins ')
            lines << split[0]
            lines << '<ins ' + split[1]
          elsif i > 1 and line[0] == '"' and diff_lines[i-1] == '<ins class="differ">' and diff_lines[i-2].end_with?('</del>')
            lines << '"' + "\n" + line[1..-1]
          else
            lines << line
          end
        end

        puts local_file
        puts "<pre>#{lines.join("\n")}</pre>"
      end

      def show(file)
        puts file
        puts "<pre>#{File.read(file).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')}</pre>"
      end

    end
  end
end

World(Daddy::Cucumber::Diff)
