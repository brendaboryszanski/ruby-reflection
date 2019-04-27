module Before
 
  attr_accessor :l_variables
    
  def redefine_method_with_befores(name, befores)
    old_method = instance_method(name)
    define_method(name) {|*args, &block|
      @l_variables = {}
      old_method.parameters.map(&:last).map(&:to_s).each_with_index {|method_name, index|
        @l_variables[method_name] = args[index]
      }

      def self.method_missing name
        super name unless @l_variables.key?(name.to_s)
        @l_variables[name.to_s]
      end

      unless befores.nil?
        befores.each {|before| self.instance_exec &before}
      end
      old_method.bind(self).call(*args, &block)
    }
  end
end