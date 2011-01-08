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
        level = a.pop.downcase
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

      def CLI::configure
        type = LoggerPlusGlobal.instance.outputter_type
        trace = LoggerPlusGlobal.instance.trace
        default = {}
        default = trace[:default] if trace[:default]
        trace.each do | name, opts |
          next if name == :default
          logger_type = type
          logger_type = default[:outputter_name] if default[:outputter_name]
          logger_type = opts[:outputter_name] if opts[:outputter_name]
          logger = LoggerPlus[name]
          logger.outputters = 
            case logger_type
              when 'stderr', :stderr then logger.outputters = Outputter.stderr
              when nil, 'stdout', :stdout then logger.outputters = Outputter.stdout
              else FileOutputter.new(name, logger_type)
            end
          set_levels(logger, default) if default
          set_levels(logger, opts)
        end
      end

      private

      def CLI::set_levels logger, opts
        logger.level = case opts[:level]
          when 'debug' then DEBUG
          when 'info' then INFO
          when 'warn' then WARN
          when 'error' then ERROR
          when 'fatal' then FATAL
        end if opts[:level]
        logger.sub_level = opts[:sub_level] if opts[:sub_level]
      end
    end
  end
end
