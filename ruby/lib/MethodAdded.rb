module Contratos

  def redefiniendo
    @redefiniendo ||= false
  end

  def operations
    @operations ||= Array.new
  end

  def run_on_method_added(operation)
    operations.push(operation)
  end

  def redefine_method(operation, name)
    old_method = instance_method(name)
    define_method(name) do |*args|
      method = proc { old_method.bind(self).call(*args)}
      self.instance_exec { operation.call(method, self) }
    end

  end
  def method_added(name)
    unless redefiniendo
      @redefiniendo = true
      operations.each{ |operation| redefine_method(operation, name) }
      @redefiniendo = false
    end

  end
end
