# coding: UTF-8

module Daddy
  
  class Git

    def branches(remote = false)
      branches = []
      `git branch -a`.split("\n").each do |b|
        next unless b.index('remotes/origin/master') or b.index(/remotes\/origin\/p[0-9]+(\.[0-9]+)?/)
        
        if remote
          branches << b.strip
        else
          branches << b.strip.sub('remotes/origin/', '')
        end
      end
      
      branches.sort! do |a, b|
        if a == 'master' or a == 'remotes/origin/master'
          -1
        elsif b == 'master' or b == 'remotes/origin/master'
          1
        else
          if remote
            b.sub('remotes/origin/p', '').to_f <=> a.sub('remotes/origin/p', '').to_f
          else
            b.sub('p', '').to_f <=> a.sub('p', '').to_f
          end
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

        if b == current_branch or b == "remotes/origin/#{current_branch}"
          return branches[i+1]
        end
      end
    end
    
    def show_previous(file, options = {})
      remote = options[:remote]
      commit = options[:commit]

      if commit
        `git show #{commit}:#{file}`
      else
        `git show #{previous_branch(remote)}:#{file}`
      end
    end

    def git_diff_name(*includes)
      `git diff origin/#{previous_branch} --name-only #{includes.join(' ')}`
    end
  end

end
