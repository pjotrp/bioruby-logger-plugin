
require 'bio/log/loggersublevels'

module Bio

  module Log

    include Log4r

    # Derived from the Log4r Logger class
    class LoggerPlus < Logger
      include LoggerSubLevels

      attr_accessor :sub_level

      def warn1(s)
        warn(s) if !sub_level or sub_level >= 1
      end
      def warn2(s)
        warn(s) if !sub_level or sub_level >= 2
      end
      def warn3(s)
        warn(s) if !sub_level or sub_level >= 3
      end
      def warn4(s)
        warn(s) if !sub_level or sub_level >= 4
      end
      def warn5(s)
        warn(s) if !sub_level or sub_level >= 5
      end
      def warn6(s)
        warn(s) if !sub_level or sub_level >= 6
      end
      def warn7(s)
        warn(s) if !sub_level or sub_level >= 7
      end
      def warn8(s)
        warn(s) if !sub_level or sub_level >= 8
      end
      def warn9(s)
        warn(s) if !sub_level or sub_level >= 9
      end
    end

  end

end
