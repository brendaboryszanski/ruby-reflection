module Contratos
  def invariant(&block)
    check_invariant = proc {
      result = self.instance_exec &block
      unless result
        raise "No se cumplen las invariants"
      end
    }
    after_each_call(check_invariant)
  end
end