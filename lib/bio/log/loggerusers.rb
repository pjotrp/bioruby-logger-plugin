
module Bio

  module Log

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

    class DeveloperException < RuntimeError
    end

    # Developer acts so that errors raise an exception.
    class Developer < NormalUser

      def error logger, msg
        logger.error msg
        raise DeveloperException
      end

      def fatal logger, msg
        logger.fatal msg
        raise DeveloperException
      end
    end

  end

end
