# coding: UTF-8

module Daddy
  module Cucumber
    module Diff
      
      def git_diff(local_file, git_path)
#        git = Daddy::Git.new
#        puts "<pre>#{git.diff(git_path, true)}</pre>"

        git = Daddy::Git.new
        a = File.read(local_file).gsub('<', '&lt;').gsub('>', '&gt;')
        b = git.show_previous(git_path, true).gsub('<', '&lt;').gsub('>', '&gt;')
        
        puts "<pre>#{Differ.diff(a, b)}</pre>"
      end

    end
  end
end

World(Daddy::Cucumber::Diff)
