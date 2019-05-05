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

  def add_params(instance, method, *args)
    @methods_overrided = Hash.new
    params = get_params(method, *args)
    params.each { |name, value|
      if instance.respond_to? name
        @methods_overrided[name] = instance.method(name)
      end
      instance.define_singleton_method(name) { value }
    }
  end

  def remove_params(instance, params)
    params.each{ |param_name, value| instance.singleton_class.send :remove_method, param_name }
    #Deleting params of methods
    @methods_overrided.each{ |name, method|
      define_singleton_method(name) { method.call } }
  end

  def redefine_method(operation, name)
    old_method = instance_method(name)
    define_method(name) do |*args|
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
      operations.keys.each{ |operation| redefine_method(operation, name) }
      @operations = operations.delete_if{|operation, once| once}
      @redefiniendo = false
    end

  end
end
