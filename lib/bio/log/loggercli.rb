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
        level = nil
        sub_level = nil
        filter = nil

        opts = {}
        # ---- split fields
        a = s.split(':')
        if a.last =~ /^=(\d+)$/
          # ---- set exact filter
          filter = "sub_level==#{$1}"
          a.pop
        elsif a.last =~ /^=/
          # ---- set filter
          filter = $'
          a.pop
        elsif a.last =~ /^\d+$/
          # ---- the last field is the sub level
          sub_level = a.pop.to_i
          # ---- The fore-last field is the level
          level = a.pop.downcase
        else
          level = a.pop.downcase
        end
        # ---- If there is another field it contains logger name(s)
        #      otherwise it is a global
        outputter = 
          if a.size == 2 
            a.shift
          end
        if a.size == 0
          a = [:default]  # global
        else
          a = a[0].split(',') # one or more logger name(s)
        end
        # ---- update every logger
        a.each do | type |
          opts[type] = {}
          opts[type][:level] = level if level
          opts[type][:sub_level] = sub_level if sub_level
          opts[type][:filter] = filter if filter
          opts[type][:outputter_name] = outputter if outputter
          # p [type,opts[type]]
        end
        # ---- Set the globals
        LoggerPlusGlobal.instance.trace ||= {}
        LoggerPlusGlobal.instance.trace = LoggerPlusGlobal.instance.trace.merge(opts)
      end

      def CLI::configure logname = nil
        include Bio::Log

        type = LoggerPlusGlobal.instance.outputter_type
        trace = LoggerPlusGlobal.instance.trace
        trace ||= {}
        default = {}
        default = trace[:default] if trace[:default]
        trace[logname] ||= {} if logname
        trace.each do | name, opts |
          next if name == :default
          logger_type = type
          logger_type = default[:outputter_name] if default[:outputter_name]
          logger_type = opts[:outputter_name] if opts[:outputter_name]
          logger = LoggerPlus[name]
          raise "Unknown logger <#{name}>" if logger == nil
          logger.outputters = 
            case logger_type
              when 'stderr', :stderr then logger.outputters = Outputter.stderr
              when nil, 'stdout', :stdout then logger.outputters = Outputter.stdout
              else 
                # p [name, logger_type]
                FileOutputter.new(name, logger_type[:file])
            end
          set_levels(logger, default) if default
          set_levels(logger, opts)
          eval "logger.filter { | level,sub_level,msg | #{opts[:filter]} ) }"
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
