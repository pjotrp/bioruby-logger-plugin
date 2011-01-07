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
  end

  it "should have a stderr logger" do
    # logit @mylog
    @mylog.info("This is a message with level INFO").should_not == nil
  end

  it "should have a file logger"
  it "should have a rotating file logger"
  it "should set global loglevel to warn" do
    # @mylog.level = Bio::Log::WARN
    @mylog.level = WARN
    # logit @mylog
    @mylog.info("This is a message with level INFO").should == nil
    @mylog.error("This is a message with level ERROR").should_not == nil
  end
  it "should set global loglevel with number"
  it "should override level for 'gff3' to info level 5"
  it "should override level for 'blast' and 'gff3'"
  it "should override level for 'blast' on stderr "
  it "should modify the logger for development"
end


