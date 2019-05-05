require_relative 'MethodAdded.rb'
module Contratos

  def before_each_call(before)
    operation = proc{ |method|
      self.instance_exec { before.call }
      method.call
    }
    run_on_method_added(operation)
  end

  def after_each_call(after)
    operation = proc{ |method|
      method.call
      self.instance_exec { after.call }
    }
    run_on_method_added(operation)
  end

  def before_and_after_each_call(before, after)
    before_each_call(before)
    after_each_call(after)
  end

end