# coding: UTF-8

module Daddy
  module Git
    class GitUtils
      
      def self.get_branches
        branches = []
        `git branch -a`.split("\n").each do |b|
          next if b.index('HEAD')
          next if b.index('gh-pages')
          next unless b.index('remotes/origin/')
          branches << b.strip.sub('remotes/origin/', '')
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
      
      def self.current_branch
        `git branch`.split("\n").each do |b|
          return b.split.last if b.start_with?('*')
        end
      end
    end
  end
end
  