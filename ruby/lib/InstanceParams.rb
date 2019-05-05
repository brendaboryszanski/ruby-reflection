module Contratos
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
end
