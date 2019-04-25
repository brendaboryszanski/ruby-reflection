module After

  attr_accessor :l_variables

  def redefine_method_with_afters(name, afters)
    old_method = instance_method(name)
    define_method(name) {|*args, &block|
      @l_variables = {}
      old_method.parameters.map(&:last).map(&:to_s).each_with_index {|param_name, index|
        @l_variables[param_name] = args[index]
      }

      def self.method_missing(name, *args, &block)
        super name unless @l_variables.key?(name.to_s)
        @l_variables[name.to_s]
      end

      result = old_method.bind(self).call(*args, &block)
      if afters != nil
        afters.each {|after|
          if after.arity == 1
            self.instance_exec result, &after
          else
            self.instance_exec &after
          end
        }
      end
      result
    }
  end
end