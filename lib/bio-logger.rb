
require "rubygems"
begin
  gem "log4r" , "> 1.1.8"
rescue
	$stderr.print "log4r not installed, bailing out...\n"
  exit 1
end

require 'log4r'
require 'bio/log/logger'
