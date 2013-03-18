# coding: UTF-8

Dir::glob(File.dirname(__FILE__) + '/git/*.rb').each do |file|
  require file
end

module Daddy
  
  class Git
    def branches(remote = false)
      branches = []
      `git branch -a`.split("\n").each do |b|
        next if b.index('HEAD')
        next if b.index('gh-pages')
        next unless b.index('remotes/origin/')
        
        if remote
          branches << b.strip
        else
          branches << b.strip.sub('remotes/origin/', '')
        end
      end
      
      branches.sort! do |a, b|
        if a == 'master'
          -1
        elsif b == 'master'
          1
        else
          b <=> a
        end
      end
      
      branches
    end
    
    def current_branch
      `git branch`.split("\n").each do |b|
        return b.split.last if b.start_with?('*')
      end
    end
    
    def previous_branch(remote = false)
      current_branch = self.current_branch
      branches = self.branches(remote)

      branches.each_with_index do |b, i|
        return nil if i == branches.size - 1

        if b == current_branch
          return branches[i+1]
        end
      end
    end
    
    def show_previous(file, remote = false)
      `git show #{previous_branch(remote)}:#{file}`
    end
    
    def diff(file, remote = false)
      b = self.previous_branch(remote)
      ret = `git diff -b #{b} -- #{file}`
      puts 'ああああ'
      puts b
      puts ret
      ret
    end
  end

end
