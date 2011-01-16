require "rubygems"
begin
  gem "log4r" 
rescue
	$stderr.print "log4r not installed, bailing out...\n"
  exit 1
end

require 'log4r'
require 'bio/log/patchlog4r'
require 'bio/log/logger'
require 'bio/log/loggercli'
