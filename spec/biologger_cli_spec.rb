# RSpec for bio-logger plugin. Run with something like:
#
#   rspec logger_spec.rb 
#
# Copyright (C) 2011 Pjotr Prins <pjotr.prins@thebird.nl>
#

$: << "../lib"

require 'bio-logger'
include Bio::Log

describe Bio::Log::CLI, "bio-logger command line parsing" do

  before(:all) do
    # @mylog = Bio::Log::LoggerPlus.root
    @mylog = LoggerPlus.new 'mylog'
    @mylog.outputters = Outputter.stderr
    @global = LoggerPlusGlobal.instance
  end

  it "should parse --logger stderr and set the global" do
    CLI.logger("stderr")
    LoggerPlusGlobal.instance.outputter_type.should == :stderr
  end
  it "should parse --logger filen to set filename logger" do
    CLI.logger("test.log")
    @global.outputter_type[:file].should == {:filename => 'test.log'}
  end
  it "should parse --trace  debug to show all messages" do
    CLI.trace("debug")
    @global.trace[:default].should == { :level => 'debug', :sub_level => nil } 
  end
  it "should parse --trace  warn to show how messages more serious than 'warn'" do
    CLI.trace("warn")
    @global.trace[:default].should == { :level => 'warn', :sub_level => nil } 
  end
  it "should parse --trace  warn:3 to show messaged more serious that 'warn' level 3" do
    CLI.trace("warn:3")
    @global.trace[:default].should == { :level => 'warn', :sub_level => 3 } 
  end
  it "should parse --trace  gff3:info:5 to override level for 'gff3' to info level 5"
  it "should parse --trace  blast:debug to override level for 'blast'"
  it "should parse --trace  blast,gff3:debug to override level for 'blast' and 'gff3'"
  it "should parse --trace  stderr:blast:debug to override level for 'blast' on stderr" 
end


