require 'closer/helpers'

Dir::glob(File.dirname(__FILE__) + '/helpers/*.rb').each do |file|
  require file
end

Dir::glob(File.dirname(__FILE__) + '/step_definitions/*.rb').each do |file|
  load file
end
