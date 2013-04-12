# coding: UTF-8

Dir::glob(File.dirname(__FILE__) + '/git/*.rb').each do |file|
  require file
end

module Daddy
  
  class Git
    @@sub_dir = nil

    def self.sub_dir=(sub_dir)
      @@sub_dir = sub_dir
    end

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
        if a == 'master' or a == 'remotes/origin/master'
          -1
        elsif b == 'master' or b == 'remotes/origin/master'
          1
        else
          if remote
            b.sub('remotes/origin/p', '').to_i <=> a.sub('remotes/origin/p', '').to_i
          else
            b.sub('p', '').to_i <=> a.sub('p', '').to_i
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
    
    def show_previous(file, remote = false)
      if @@sub_dir
        sub_dir = @@sub_dir
        sub_dir += '/' unless @@sub_dir.end_with?('/')
        `git show #{previous_branch(remote)}:#{sub_dir}#{file}`
      else
        `git show #{previous_branch(remote)}:#{file}`
      end
    end

    def git_diff_name(*includes)
      diff = `git diff origin/#{previous_branch} --name-only #{includes.join(' ')}`
      return diff unless @@sub_dir

      ret = []
      diff.split("\n").each do |line|
        index = line.index(@@sub_dir)
        if index
          sub_file = line[@@sub_dir.length..-1]
          sub_file = sub_file[1..-1] if sub_file.start_with?('/')
          ret << sub_file
        else
          ret << line
        end
      end

      ret.join("\n")
    end
  end

end
