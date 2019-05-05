require_relative 'MethodAdded.rb'
module Contratos

  def before_each_call(before, once = false)
    operation = proc{ |method, instance|
      methods = instance.methods(false).to_s
      instance.instance_exec &before
      method.call
    }
    run_on_method_added(operation, once)
  end

  def after_each_call(after, once = false)
    operation = proc{ |method, instance|
      methods = instance.methods(false).to_s
      result = method.call
      if(after.arity == 1)
        instance.instance_exec result, &after
      else
        instance.instance_exec &after
      end
      result
    }
    run_on_method_added(operation, once)
  end

  def before_and_after_each_call(before, after)
    before_each_call(before)
    after_each_call(after)
  end

end