require_relative 'BeforeAndAfter.rb'

module Contratos
  def pre(&block)
    check_pre = proc {
      result = self.instance_exec &block
      unless result
        raise "No se cumple el pre"
      end
    }
    before_each_call(check_pre, true)
  end

  def post(&block)
    after_each_call(block, true)
  end
end
