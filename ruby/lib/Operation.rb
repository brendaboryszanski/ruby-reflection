module Operation
    
    attr_accessor :operations, :defining_operation_method
    
    def operations
      @operations ||= []
    end

    def add_operation(operation)
      operations << operation
    end

    def method_added name
      unless @defining_operation_method
        @defining_operation_method = true
        operations.each {|op| op.call(name)}
        defined?(super) && super
        @defining_operation_method = false
        @operations = nil
      end
    end
end