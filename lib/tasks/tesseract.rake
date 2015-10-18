require 'rake'

namespace :dad do
  namespace :leptonica do
    task :install do
      name = 'leptonica-1.72'
      file = "#{name}.tar.gz"

      unless File.exist?("tmp/#{file}")
        run "wget http://www.leptonica.com/source/#{file} -O tmp/#{file}"
      end

      run "rm -Rf tmp/#{name}",
          "cd tmp && tar zxf #{file}",
          "cd tmp/#{name} && ./configure",
          "cd tmp/#{name} && make",
          "cd tmp/#{name} && sudo make install"
    end
  end

  namespace :tesseract do
    task :install do
      name = 'tesseract'
      version = '3.04.00'
      file = "#{name}-#{version}.tar.gz"

      unless File.exist?("tmp/#{file}")
        run "wget https://github.com/tesseract-ocr/tesseract/archive/#{version}.tar.gz -O tmp/#{file}"
      end

      run "rm -Rf tmp/#{name}",
          "cd tmp && tar zxf #{file}",
          "cd tmp/#{name}-#{version} && ./configure",
          "cd tmp/#{name}-#{version} && make",
          "cd tmp/#{name}-#{version} && sudo make install"
    end
    
    task :lang do
      name = 'tessdata'
      version = '3.04.00'
      file = "#{name}-#{version}.tar.gz"

      unless File.exist?("tmp/#{file}")
        run "wget https://github.com/tesseract-ocr/tessdata/archive/#{version}.tar.gz -O tmp/#{file}"
      end

      run "rm -Rf tmp/#{name}-#{version}",
          "cd tmp && tar zxf #{file}"

      ['eng', 'jpn'].each do |lang|
        system("sudo cp -f tmp/#{name}-#{version}/#{lang}.traineddata /usr/local/share/tessdata/")
      end
    end
  end
end
