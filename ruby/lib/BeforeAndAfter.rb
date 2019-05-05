require_relative 'MethodAdded.rb'
module Contratos

  def before_each_call(before)
    operation = proc{ |method, instance|
      instance.instance_exec { before }
      method.call
    }
    run_on_method_added(operation)
  end

  def after_each_call(after)
    operation = proc{ |method, instance|
      method.call
      instance.instance_exec { after }
    }
    run_on_method_added(operation)
  end

  def before_and_after_each_call(before, after)
    before_each_call(before)
    after_each_call(after)
  end

end