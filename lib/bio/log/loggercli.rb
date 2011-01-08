require 'singleton'

module Bio
  module Log

    class LoggerPlusGlobal
      include Singleton

      attr_accessor :outputter_type, :trace

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
        sub_level = nil

        opts = {}
        a = s.split(':')
        if a.last =~ /^\d+$/
          sub_level = a.pop.to_i
        end
        level = a.pop
        outputter = 
          if a.size == 2 
            a.shift
          end
        if a.size == 0
          a = [:default] 
        else
          a = a[0].split(',')
        end
        a.each do | type |
          opts[type] = { :level => level, :sub_level => sub_level }
          opts[type][:outputter_name] = outputter if outputter
        end
        LoggerPlusGlobal.instance.trace ||= {}
        LoggerPlusGlobal.instance.trace = LoggerPlusGlobal.instance.trace.merge(opts)
      end
    end
  end
end
