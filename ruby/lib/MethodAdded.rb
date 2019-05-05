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

  def get_params(method, *args)
    param_names = method.parameters.map(&:last).map(&:to_s)
    param_names.zip(args)
  end

  def redefine_method(operation, name)
    old_method = instance_method(name)
    define_method(name) do |*args|
      params = self.class.get_params(old_method, *args)
      #Adding params of methods
      methods_overrided = Hash.new
      params.each { |name, value|
        if self.respond_to? name
          methods_overrided[name] = self.method(name)
        end
        define_singleton_method(name) { value }
      }
      method = proc { old_method.bind(self).call(*args) }
      result = self.instance_exec { operation.call(method, self) }

      params.each{ |param_name, value| self.singleton_class.send :remove_method, param_name }
      #Deleting params of methods
      methods_overrided.each{ |name, method|
        define_singleton_method(name) { method.call } }
      result
    end

  end
  def method_added(name)
    unless redefiniendo
      @redefiniendo = true
      operations.keys.each{ |operation| redefine_method(operation, name) }
      @operations = operations.delete_if{|operation, once| once}
      @redefiniendo = false
    end

  end
end
