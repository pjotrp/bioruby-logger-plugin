
require 'bio/log/loggersublevels'
require 'bio/log/loggerusers'

module Bio

  module Log

    include Log4r

    # Derived from the Log4r Logger class
    class LoggerPlus < Logger
      include LoggerSubLevels

      def debug_ msg, options = {}
        if options[:act]
          options[:act].debug(self,msg)
        else
          debug msg
        end
      end

      def info_ msg, options = {}
        if options[:act]
          options[:act].info(self,msg)
        else
          info msg
        end
      end

      def warn_ msg, options = {}
        if options[:act]
          options[:act].warn(self,msg)
        else
          warn msg
        end
      end

      def error_ msg, options = {}
        if options[:act]
          options[:act].error(self,msg)
        else
          error msg
        end
      end

      def fatal_ msg, options = {}
        if options[:act]
          options[:act].fatal(self,msg)
        else
          fatal msg
        end
      end

    end

  end

end
