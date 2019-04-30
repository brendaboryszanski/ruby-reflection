module Operation

  attr_accessor :operations, :defining_operation_method

  def operations
    @operations ||= []
  end

  def run_on_method_added(once = false, &operation)
    operations << [once, operation]
  end

  def method_added(name)
    unless @defining_operation_method
      @defining_operation_method = true
      operations.each {|op| op[1].call(name)}
      if defined?(super)
        super
      end
      @defining_operation_method = false
      operations.reject! {|operation| operation[0]}
    end
  end
end