# coding: UTF-8

module Daddy
  module Cucumber
    module Diff
      
      def git_diff(local_file, git_path)
        git = Daddy::Git.new
        a = File.read(local_file).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        b = git.show_previous(git_path, true).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        diff = Differ.diff(a, b)

        puts local_file
        puts "<pre>#{diff}</pre>"
      end
      
      def show(file)
        puts file
        puts "<pre>#{File.read(file).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')}</pre>"
      end

    end
  end
end

World(Daddy::Cucumber::Diff)
