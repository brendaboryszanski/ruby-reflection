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
      #Adding params of methods
      param_names = old_method.parameters.map(&:last).map(&:to_s)
      puts param_names.to_s
      params = param_names.zip(args)
      methods_overrided = Hash.new
      params.each { |param|
        if self.respond_to? param[0]
          methods_overrided[param[0]] = self.method(param[0])
        end
        define_singleton_method(param[0]) { param[1] }
      }
      method = proc { old_method.bind(self).call(*args) }
      self.instance_exec { operation.call(method, self) }

      #Deleting params of methods
      methods_overrided.each{ |param| define_singleton_method(param[0]) { param[1] }}
    end

  end
  def method_added(name)
    puts name.to_s
    unless redefiniendo
      @redefiniendo = true
      operations.each{ |operation| redefine_method(operation, name) }
      @redefiniendo = false
    end

  end
end
