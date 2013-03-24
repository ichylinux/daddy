# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :cucumber do

    task :steps do
      word = ENV['WORD']
      keywords = %w{ 前提 もし ならば かつ しかし 但し ただし }

      steps = []    
      Dir::glob("features/step_definitions/**/*.rb").each do |file|
        File.readlines(file).each_with_index do |line, i|
          keywords.each do |keyword|
            if line.start_with?(keyword)
              steps << {:keyword => keyword, :line_no => i + 1, :line => line.strip, :file => file}
            end
          end
        end
      end
      
      steps.sort{|a, b| a[:line] <=> b[:line]}.each do |step|
        next if word and not step[:line].index(word)

        puts
        puts "#{step[:file]}:#{step[:line_no]}"
        puts step[:line]
      end
      puts
    end

  end
end
