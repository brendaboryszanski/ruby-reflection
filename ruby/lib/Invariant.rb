module Contratos
  def invariant(&block)
    after_each_call(block)
  end
end