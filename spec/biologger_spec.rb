# RSpec for bio-logger plugin. Run with something like:
#
#   rspec logger_spec.rb 
#
# Copyright (C) 2011 Pjotr Prins <pjotr.prins@thebird.nl>
#

$: << "../lib"

require 'bio-logger'
include Bio::Log

  def logit mylog
    mylog.debug "This is a message with level DEBUG"
    mylog.info "This is a message with level INFO"
    mylog.warn "This is a message with level WARN"
    mylog.error "This is a message with level ERROR"
    mylog.fatal "This is a message with level FATAL"
  end


describe Bio::Log, "logs" do

  before(:all) do
    # @mylog = Bio::Log::LoggerPlus.root
    @mylog = LoggerPlus.new 'mylog'
    @mylog.outputters = Outputter.stderr
    logit @mylog
    blastlog = LoggerPlus.new 'blast'
    blastlog.outputters = Outputter.stderr
  end

  after(:all) do
    File.unlink("file.log")
    File.unlink("TestSize000001.log")
    @mylog.reset_filter
  end

  it "should have a stderr logger" do
    # logit @mylog
    @mylog.info("This is a message with level INFO").should_not == nil
  end

  it "should have a rotating file logger" do
    config = {
      "filename" => "TestSize.log",
      "maxsize" => 16000,
      "trunc" => true
    }
    log2 = LoggerPlus.new 'mylog2'
    log2.outputters = RollingFileOutputter.new("mylog2", config)
    log2.info("This is a message with level INFO").should_not == nil
  end
  it "should have a file logger" do
    log3 = LoggerPlus.new 'filelog'
    log3.outputters = FileOutputter.new('filelog', :filename => 'file.log',:trunc => false)
    log3.info("This is a message with level INFO").should_not == nil
    File.read('file.log').should == " INFO filelog: This is a message with level INFO\n"
  end
  it "should set global loglevel to warn" do
    # @mylog.level = Bio::Log::WARN
    @mylog.level = WARN
    # logit @mylog
    @mylog.info("This is a message with level INFO").should == nil
    @mylog.error("This is a message with level ERROR").should_not == nil
    @mylog.level = DEBUG
  end
  it "should set global loglevel with WARN:3" do
    @mylog.level = WARN
    @mylog.sub_level = 3
    @mylog.info("This is a message with level INFO").should == nil
    @mylog.warn8("This is a message with level WARN:8").should == nil
    @mylog.warn1("This is a message with level WARN:1").should_not == nil
    @mylog.warn("This is a message with level WARN").should_not == nil
    @mylog.error("This is a message with level ERROR").should_not == nil
    @mylog.level = DEBUG
    @mylog.sub_level = nil
    @mylog.info("This is a message with level INFO").should_not == nil
    @mylog.warn8("This is a message with level WARN:8").should_not == nil
  end
  it "should allow for a filter" do
    @mylog.filter { |l,s,m| l==INFO }
    @mylog.info("This is a level filtered message with level INFO")
    @mylog.warn("NO DISPLAY: This is a level filtered message with level WARN")
    @mylog.error("NO DISPLAY: This is a level filtered message with level ERROR")

    @mylog.filter { |l,s,m| m =~ /filtered/ }
    @mylog.info("NO DISPLAY: This is a Filtered message with level XXX")
    @mylog.info3("DISPLAY This is a filtered message with level XXX")
    @mylog.filter { |l,s,m| s==3 }
    @mylog.info("NO DISPLAY: This is a filtered message with level INFO")
    @mylog.info3("DISPLAY This is a filtered message with level INFO:3")
    @mylog.warn8("NO DISPLAY: This is a filtered message with level WARN:8")
    @mylog.warn3("DISPLAY This is a filtered message with level WARN:3")
    @mylog.warn1("NO DISPLAY: This is a filtered message with level WARN:1")
    @mylog.warn("NO DISPLAY: This is a filtered message with level WARN")
    @mylog.error("NO DISPLAY: This is a filtered message with level ERROR")
    @mylog.reset_filter
    @mylog.info("DISPLAY: This is an unfiltered message with level INFO").should_not == nil
    @mylog.warn8("DISPLAY: This is an unfiltered message with level WARN:8").should_not == nil
  end
  it "should override level for 'blast' to info level 5" do
    log = LoggerPlus['blast']
    log.should_not == nil
    log.info("This is a message with level INFO").should_not == nil
    log.level = INFO
    log.sub_level = 5
    log.info("This is a message with level INFO").should_not == nil
    log.info5("This is a message with level INFO:5").should_not == nil
    log.info6("This is a message with level INFO:6").should == nil
  end
  it "should modify the logger for development" do
    @mylog.error_("ERROR should not fail",:act => NormalUser.new).should_not == nil
    dev = Developer.new
    @mylog.info_("INFO should not fail",:act => dev).should_not == nil
    lambda { @mylog.error_("As Developer ERROR should fail",:act => dev) }.should raise_error
    lambda { @mylog.fatal_("As Developer FATAL should fail",:act => dev) }.should raise_error

  end
end


