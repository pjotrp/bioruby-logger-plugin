
module Bio
  module Log

    # Support for numbered sub-levels. We could have used
    # method_missing, or something similar, but this rather
    # clean.
    module LoggerSubLevels
      attr_accessor :sub_level

      def debug1(s)
        return nil if @use_filter and !@use_filter.call(DEBUG,1,s)
        debug(s) if !sub_level or sub_level >= 1
      end
      def debug2(s)
        return nil if @use_filter and !@use_filter.call(DEBUG,2,s)
        debug(s) if !sub_level or sub_level >= 2
      end
      def debug3(s)
        return nil if @use_filter and !@use_filter.call(DEBUG,3,s)
        debug(s) if !sub_level or sub_level >= 3
      end
      def debug4(s)
        return nil if @use_filter and !@use_filter.call(DEBUG,4,s)
        debug(s) if !sub_level or sub_level >= 4
      end
      def debug5(s)
        return nil if @use_filter and !@use_filter.call(DEBUG,5,s)
        debug(s) if !sub_level or sub_level >= 5
      end
      def debug6(s)
        return nil if @use_filter and !@use_filter.call(DEBUG,6,s)
        debug(s) if !sub_level or sub_level >= 6
      end
      def debug7(s)
        return nil if @use_filter and !@use_filter.call(DEBUG,7,s)
        debug(s) if !sub_level or sub_level >= 7
      end
      def debug8(s)
        return nil if @use_filter and !@use_filter.call(DEBUG,8,s)
        debug(s) if !sub_level or sub_level >= 8
      end
      def debug9(s)
        return nil if @use_filter and !@use_filter.call(DEBUG,9,s)
        debug(s) if !sub_level or sub_level >= 9
      end

      def info1(s)
        return nil if @use_filter and !@use_filter.call(INFO,1,s)
        info(s) if !sub_level or sub_level >= 1
      end
      def info2(s)
        return nil if @use_filter and !@use_filter.call(INFO,2,s)
        info(s) if !sub_level or sub_level >= 2
      end
      def info3(s)
        return nil if @use_filter and !@use_filter.call(INFO,3,s)
        info(s) if !sub_level or sub_level >= 3
      end
      def info4(s)
        return nil if @use_filter and !@use_filter.call(INFO,4,s)
        info(s) if !sub_level or sub_level >= 4
      end
      def info5(s)
        return nil if @use_filter and !@use_filter.call(INFO,5,s)
        info(s) if !sub_level or sub_level >= 5
      end
      def info6(s)
        return nil if @use_filter and !@use_filter.call(INFO,6,s)
        info(s) if !sub_level or sub_level >= 6
      end
      def info7(s)
        return nil if @use_filter and !@use_filter.call(INFO,7,s)
        info(s) if !sub_level or sub_level >= 7
      end
      def info8(s)
        return nil if @use_filter and !@use_filter.call(INFO,8,s)
        info(s) if !sub_level or sub_level >= 8
      end
      def info9(s)
        return nil if @use_filter and !@use_filter.call(INFO,9,s)
        info(s) if !sub_level or sub_level >= 9
      end

      def warn1(s)
        return nil if @use_filter and !@use_filter.call(WARN,1,s)
        warn(s) if !sub_level or sub_level >= 1
      end
      def warn2(s)
        return nil if @use_filter and !@use_filter.call(WARN,2,s)
        warn(s) if !sub_level or sub_level >= 2
      end
      def warn3(s)
        return nil if @use_filter and !@use_filter.call(WARN,3,s)
        warn(s) if !sub_level or sub_level >= 3
      end
      def warn4(s)
        return nil if @use_filter and !@use_filter.call(WARN,4,s)
        warn(s) if !sub_level or sub_level >= 4
      end
      def warn5(s)
        return nil if @use_filter and !@use_filter.call(WARN,5,s)
        warn(s) if !sub_level or sub_level >= 5
      end
      def warn6(s)
        return nil if @use_filter and !@use_filter.call(WARN,6,s)
        warn(s) if !sub_level or sub_level >= 6
      end
      def warn7(s)
        return nil if @use_filter and !@use_filter.call(WARN,7,s)
        warn(s) if !sub_level or sub_level >= 7
      end
      def warn8(s)
        return nil if @use_filter and !@use_filter.call(WARN,8,s)
        warn(s) if !sub_level or sub_level >= 8
      end
      def warn9(s)
        return nil if @use_filter and !@use_filter.call(WARN,9,s)
        warn(s) if !sub_level or sub_level >= 9
      end

      def error1(s)
        return nil if @use_filter and !@use_filter.call(ERROR,1,s)
        error(s) if !sub_level or sub_level >= 1
      end
      def error2(s)
        return nil if @use_filter and !@use_filter.call(ERROR,2,s)
        error(s) if !sub_level or sub_level >= 2
      end
      def error3(s)
        return nil if @use_filter and !@use_filter.call(ERROR,3,s)
        error(s) if !sub_level or sub_level >= 3
      end
      def error4(s)
        return nil if @use_filter and !@use_filter.call(ERROR,4,s)
        error(s) if !sub_level or sub_level >= 4
      end
      def error5(s)
        return nil if @use_filter and !@use_filter.call(ERROR,5,s)
        error(s) if !sub_level or sub_level >= 5
      end
      def error6(s)
        return nil if @use_filter and !@use_filter.call(ERROR,6,s)
        error(s) if !sub_level or sub_level >= 6
      end
      def error7(s)
        return nil if @use_filter and !@use_filter.call(ERROR,7,s)
        error(s) if !sub_level or sub_level >= 7
      end
      def error8(s)
        return nil if @use_filter and !@use_filter.call(ERROR,8,s)
        error(s) if !sub_level or sub_level >= 8
      end
      def error9(s)
        return nil if @use_filter and !@use_filter.call(ERROR,9,s)
        error(s) if !sub_level or sub_level >= 9
      end

      def fatal1(s)
        return nil if @use_filter and !@use_filter.call(FATAL,1,s)
        fatal(s) if !sub_level or sub_level >= 1
      end
      def fatal2(s)
        return nil if @use_filter and !@use_filter.call(FATAL,2,s)
        fatal(s) if !sub_level or sub_level >= 2
      end
      def fatal3(s)
        return nil if @use_filter and !@use_filter.call(FATAL,3,s)
        fatal(s) if !sub_level or sub_level >= 3
      end
      def fatal4(s)
        return nil if @use_filter and !@use_filter.call(FATAL,4,s)
        fatal(s) if !sub_level or sub_level >= 4
      end
      def fatal5(s)
        return nil if @use_filter and !@use_filter.call(FATAL,5,s)
        fatal(s) if !sub_level or sub_level >= 5
      end
      def fatal6(s)
        return nil if @use_filter and !@use_filter.call(FATAL,6,s)
        fatal(s) if !sub_level or sub_level >= 6
      end
      def fatal7(s)
        return nil if @use_filter and !@use_filter.call(FATAL,7,s)
        fatal(s) if !sub_level or sub_level >= 7
      end
      def fatal8(s)
        return nil if @use_filter and !@use_filter.call(FATAL,8,s)
        fatal(s) if !sub_level or sub_level >= 8
      end
      def fatal9(s)
        return nil if @use_filter and !@use_filter.call(FATAL,9,s)
        fatal(s) if !sub_level or sub_level >= 9
      end

    end
  end
end
