
module Bio
  module Log

    # The filter logger changes behaviour
    module LoggerFilter

      def filter &filter_func
        @outputters.each do | out | 
          # p [:adding_filter_to,out]
          out.class.send(:define_method, :filtered?) do |l,s,m|
            # p [:called,l,s,m]
            filter_func.call(l,s,m)
          end
          raise 'hell' if !out.class.method_defined?(:filtered?)
        end
        @level = default_level  # will recreate logger methods
        @sub_level = default_sub_level
      end

      def reset_filter
        @outputters.each do | out | 
          if out.class.method_defined?(:filtered?)
            out.class.send(:remove_method, :filtered?)
          end
        end
        @level = default_level  # will recreate logger methods
        @sub_level = default_sub_level
      end

    end

  end
end
