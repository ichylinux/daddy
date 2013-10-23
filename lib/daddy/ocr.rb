# coding: UTF-8

module Daddy
  class Ocr
    
    def self.scan(image_path)
      out = Time.now.strftime("%Y%m%d%H%M%S") + (Time.now.usec / 1000.0).to_s
      system("tesseract #{image_path} tmp/#{out} -l jpn")
      File.read("tmp/#{out}.txt")
    end

  end
end