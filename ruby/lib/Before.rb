module Before
 
  attr_accessor :l_variables
    
  def redefine_method_with_before(name, before)
    old_method = instance_method(name)
    define_method(name) {|*args, &block|
      @l_variables = {}
      old_method.parameters.map(&:last).map(&:to_s).each_with_index {|param_name, index|
        @l_variables[param_name] = args[index]
      }

      def self.respond_to_missing?(symbol, include_private)
        super || @l_variables.key?(name.to_s)
      end

      def self.method_missing name
        super name unless @l_variables.key?(name.to_s)
        @l_variables[name.to_s]
      end

      self.instance_exec &before

      old_method.bind(self).call(*args, &block)
    }
  end
end