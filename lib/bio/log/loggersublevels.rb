
module Bio
  module Log

    # Support for numbered sub-levels. We could have used
    # method_missing, or something similar, but this rather
    # clean.
    module LoggerSubLevels
      attr_accessor :sub_level

      def debug1(s)
        debug(s) if !sub_level or sub_level >= 1
      end
      def debug2(s)
        debug(s) if !sub_level or sub_level >= 2
      end
      def debug3(s)
        debug(s) if !sub_level or sub_level >= 3
      end
      def debug4(s)
        debug(s) if !sub_level or sub_level >= 4
      end
      def debug5(s)
        debug(s) if !sub_level or sub_level >= 5
      end
      def debug6(s)
        debug(s) if !sub_level or sub_level >= 6
      end
      def debug7(s)
        debug(s) if !sub_level or sub_level >= 7
      end
      def debug8(s)
        debug(s) if !sub_level or sub_level >= 8
      end
      def debug9(s)
        debug(s) if !sub_level or sub_level >= 9
      end

      def info1(s)
        info(s) if !sub_level or sub_level >= 1
      end
      def info2(s)
        info(s) if !sub_level or sub_level >= 2
      end
      def info3(s)
        p self
        if self.class.method_defined?(:filtered?) 
          if !filtered?(logevent.level,nil,logevent.data)
            return nil
          end
        end
        info(s) if !sub_level or sub_level >= 3
      end
      def info4(s)
        info(s) if !sub_level or sub_level >= 4
      end
      def info5(s)
        info(s) if !sub_level or sub_level >= 5
      end
      def info6(s)
        info(s) if !sub_level or sub_level >= 6
      end
      def info7(s)
        info(s) if !sub_level or sub_level >= 7
      end
      def info8(s)
        info(s) if !sub_level or sub_level >= 8
      end
      def info9(s)
        info(s) if !sub_level or sub_level >= 9
      end

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

      def error1(s)
        error(s) if !sub_level or sub_level >= 1
      end
      def error2(s)
        error(s) if !sub_level or sub_level >= 2
      end
      def error3(s)
        error(s) if !sub_level or sub_level >= 3
      end
      def error4(s)
        error(s) if !sub_level or sub_level >= 4
      end
      def error5(s)
        error(s) if !sub_level or sub_level >= 5
      end
      def error6(s)
        error(s) if !sub_level or sub_level >= 6
      end
      def error7(s)
        error(s) if !sub_level or sub_level >= 7
      end
      def error8(s)
        error(s) if !sub_level or sub_level >= 8
      end
      def error9(s)
        error(s) if !sub_level or sub_level >= 9
      end

      def fatal1(s)
        fatal(s) if !sub_level or sub_level >= 1
      end
      def fatal2(s)
        fatal(s) if !sub_level or sub_level >= 2
      end
      def fatal3(s)
        fatal(s) if !sub_level or sub_level >= 3
      end
      def fatal4(s)
        fatal(s) if !sub_level or sub_level >= 4
      end
      def fatal5(s)
        fatal(s) if !sub_level or sub_level >= 5
      end
      def fatal6(s)
        fatal(s) if !sub_level or sub_level >= 6
      end
      def fatal7(s)
        fatal(s) if !sub_level or sub_level >= 7
      end
      def fatal8(s)
        fatal(s) if !sub_level or sub_level >= 8
      end
      def fatal9(s)
        fatal(s) if !sub_level or sub_level >= 9
      end

    end
  end
end
