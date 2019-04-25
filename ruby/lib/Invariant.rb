require_relative "AfterEachCall.rb"

module Invariant
    
  include AfterEachCall

  def invariant(&an_invariant)
    after_each_call(proc {
      unless self.instance_exec &an_invariant
        raise "¡Invariant!"
      end
    })
  end
end