

module Log4r
  class Outputter < Monitor

    # Log4r creates the logging methods dynamically - quite cleverly creating
    # only those methods that are required, but not that transparent. 
    #
    # To add filter support we 'monkey patch' the original implementation of
    # +define_log+ in 'outputterfactory.rb' by adding in the filter call.
    # This slows down the run time, but that is not so important.
    #
    class OutputterFactory 
      # original comment: we need to synch the actual write/format for thread saftyness
      def self.define_log(mname, level, out)
        return if mname == 'off' || mname == 'all'
        # p [mname,level,out]
        # 
        # At runtime, self and logevent are available to the method:
        # [:self, #<Log4r::StderrOutputter:0x9f8975c @mon_owner=nil, @mon_count=0, @mon_mutex=#<Mutex:0x9f89694>, @name="stderr", @level=0, @formatter=#<Log4r::DefaultFormatter:0x9f7c174 @depth=7>, @out=#<IO:<STDERR>>>]
        # [:logevent, #<Log4r::LogEvent:0xa198de0 @data="As Developer ERROR should fail", @tracer=nil, @level=4, @name="mylog", @fullname="mylog">]

        mstr = 
            %-
            def out.#{mname}(logevent)
              return nil if self.class.method_defined?(:filtered?) and filtered?(1,2,3)
              canonical_log(logevent)
            end
            -
        module_eval mstr
      end

    end
  end
end

