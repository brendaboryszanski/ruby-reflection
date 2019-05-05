require_relative 'InstanceParams.rb'
module Contratos

  def redefiniendo
    @redefiniendo ||= false
  end

  def operations
    @operations ||= Hash.new
  end

  def run_on_method_added(operation, once)
    operations[operation] = once
  end

  def redefine_method(operation, old_method)
    define_method(old_method.name) do |*args|
      #Adding params of methods
      params = self.class.add_params(self, old_method, *args)
      method = proc { old_method.bind(self).call(*args) }
      result = self.instance_exec { operation.call(method, self) }
      self.class.remove_params(self, params)
      result
    end

  end

  def method_added(name)
    unless redefiniendo
      @redefiniendo = true
      old_method = instance_method(name)
      operations.keys.each{ |operation| redefine_method(operation, old_method) }
      @operations = operations.delete_if{|operation, once| once}
      @redefiniendo = false
    end

  end
end
