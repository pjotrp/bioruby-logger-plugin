
module Bio

  module Log

    # NormalUser logs, but does not fail
    class NormalUser
      # include LoggerSubLevels

      def debug logger,msg
        logger.debug msg
      end
      def info logger,msg
        logger.info msg
      end
      def warn logger,msg
        logger.warn msg
      end
      def error logger,msg
        logger.error msg
      end
      def fatal logger,msg
        logger.fatal msg
      end
    end

    class FailOnErrorException < RuntimeError
    end

    class FailOnError < NormalUser
      def error logger, msg
        logger.error msg
        raise FailOnErrorException
      end

      def fatal logger, msg
        logger.fatal msg
        raise FailOnErrorException
      end
    end

    # Developer acts so that errors raise an exception.
    class Developer < FailOnError
    end

  end

end
