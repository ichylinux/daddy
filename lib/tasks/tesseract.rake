# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :tesseract do
    task :install do
      # leptonica
      name = 'leptonica-1.69'
      file = "#{name}.tar.bz2"
      unless File.exist?("tmp/#{file}")
        system("wget http://leptonica.googlecode.com/files/#{file} -O tmp/#{file}")
      end
      system("rm -Rf tmp/#{name}")
      system("cd tmp && tar jxf #{file}")

      ['./configure', 'make', 'sudo make install'].each do |command|
        puts command
        fail unless system("cd tmp/#{name} && #{command}")
      end

      # tesseract-ocr
      name = 'tesseract-ocr'
      file = "#{name}-3.02.02.tar.gz"
      unless File.exist?("tmp/#{file}")
        system("wget http://tesseract-ocr.googlecode.com/files/#{file} -O tmp/#{file}")
      end
      system("rm -Rf tmp/#{name}")
      system("cd tmp && tar zxf #{file}")

      ['./configure', 'make', 'sudo make install'].each do |command|
        puts command
        fail unless system("cd tmp/#{name} && #{command}")
      end
    end
    
    task :lang do
      ['eng', 'jpn'].each do |lang|
        name = "tesseract-ocr-3.02.#{lang}"
        file = "#{name}.tar.gz"
        unless File.exist?("tmp/#{file}")
          system("wget http://tesseract-ocr.googlecode.com/files/#{file} -O tmp/#{file}")
        end
        system("rm -Rf tmp/#{name}")
        system("cd tmp && tar zxf #{file}")
        system("sudo cp -f tmp/tesseract-ocr/tessdata/#{lang}.traineddata /usr/local/share/tessdata/")
      end
    end
  end
end
