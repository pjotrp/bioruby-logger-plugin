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

  before(:each) do
    LoggerPlusGlobal.instance.trace = {}
    LoggerPlusGlobal.instance.outputter_type = :stdout
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
    @global.trace[:default].should == { :level => 'debug' } 
  end
  it "should parse --trace  warn to show how messages more serious than 'warn'" do
    CLI.trace("warn")
    @global.trace[:default].should == { :level => 'warn' } 
  end
  it "should parse --trace  warn:3 to show messaged more serious that 'warn' level 3" do
    CLI.trace("warn:3")
    @global.trace[:default].should == { :level => 'warn', :sub_level => 3 } 
  end
  it "should parse --trace =3 to show level 3 only" do
    CLI.trace("=3")
    @global.trace[:default].should == { :filter => "sub_level==3" } 
  end
  it "should parse --trace \"=sub_level == 3 or level <= ERROR\"" do
    CLI.trace("=sub_level == 3 or level <= ERROR")
    @global.trace[:default].should == { :filter => "sub_level == 3 or level <= ERROR" } 
  end
  it "should parse --trace  blast:debug to override level for 'blast'" do
    CLI.trace("blast:debug")
    @global.trace.should == {"blast"=>{:level=>"debug"}}
  end
  it "should parse --trace  gff3:info:5 to override level for 'gff3' to info level 5" do
    CLI.trace("gff3:info:5")
    @global.trace.should == {"gff3"=>{:level=>"info", :sub_level=>5}}
  end
  it "should parse --trace  blast,gff3:debug to override level for 'blast' and 'gff3'" do
    CLI.trace("blast,gff3:debug:5")
    @global.trace.should == {"blast"=>{:level=>"debug", :sub_level=>5}, "gff3"=>{:level=>"debug", :sub_level=>5}} 
  end
  it "should parse --trace \"blast:=sub_level == 3 or level <= ERROR\"" do
    CLI.trace("blast:=sub_level == 3 or level <= ERROR")
    @global.trace['blast'].should == { :filter => "sub_level == 3 or level <= ERROR" } 
  end
  it "should parse --trace  stderr:blast:debug to override level for 'blast' on stderr" do
    CLI.trace("stderr:blast:debug")
    @global.trace.should ==
      {"blast"=>{:level=>"debug", :outputter_name=>"stderr"}}
  end
  it "should parse --trace  stderr:blast,gff3:debug:1 to override level for 'blast' on stderr" do
    CLI.trace("stderr:blast,gff3:debug:1")
    @global.trace.should ==
      {"blast"=>{:level=>"debug", :sub_level=>1, :outputter_name=>"stderr"}, "gff3"=>{:level=>"debug", :sub_level=>1, :outputter_name=>"stderr"}}
  end
  it "should realize setting warn:3" do
    CLI.trace("blast:warn:3")
    LoggerPlus.new('blast')
    CLI.configure
    log = LoggerPlus['blast']
    log.level.should == WARN
    log.sub_level.should == 3
  end
end


