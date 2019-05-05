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
    if block.arity == 1
      check_post = proc { |result|
        result = self.instance_exec result, &block
        unless result
          raise "No se cumple el post"
        end
      }
    else
      check_post = proc {
        result = self.instance_exec &block
        unless result
          raise "No se cumple el post"
        end
      }
    end

    after_each_call(check_post, true)
  end
end
