require 'singleton'

module Bio
  module Log

    class LoggerPlusGlobal
      include Singleton

      attr_accessor :outputter_type, :trace

      def initialize
      end
 
    end

    module CLI
      # Parse and store global logger type
      def CLI::logger name
        LoggerPlusGlobal.instance.outputter_type = case name
          when 'stderr' then :stderr
          when 'stdout' then :stdout
          else 
            {:file => { :filename => name }}
        end
      end

      # Parse and store trace options
      def CLI::trace s
        opts = {}
        type = :default
        level, sub_level = s.split(':')
        sub_level = sub_level.to_i if sub_level 
        opts[type] = { :level => level, :sub_level => sub_level }
        LoggerPlusGlobal.instance.trace = opts
      end
    end
  end
end
