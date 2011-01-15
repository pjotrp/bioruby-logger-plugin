
module Bio
  module Log

    # The filter logger changes behaviour
    module LoggerFilter
      def filter &proc
        @level = default_level
        @sub_level = default_sub_level
        Logger.root
        define_log('info')
      end

      def define_log(mname)
        self.class.send(:define_method, mname) { |*args|
          p [:hello,"****",@args]
        }
      end
    end

  end
end
