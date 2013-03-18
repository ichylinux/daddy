# coding: UTF-8

module Daddy
  module Cucumber
    module Diff
      
      def git_diff(local_file, git_path)
        git = Daddy::Git.new
        a = File.read(local_file).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        b = git.show_previous(git_path, true).gsub(/[<>]/, '<' => '&lt;', '>' => '&gt;')
        puts "<pre>#{Differ.diff(a, b)}</pre>"
      end

    end
  end
end

World(Daddy::Cucumber::Diff)
