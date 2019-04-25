require_relative "BeforeEachCall.rb"
require_relative "AfterEachCall.rb"

module BeforeAndAfterEachCall
    
    include BeforeEachCall
    include AfterEachCall
    
    def before_and_after_each_call(before, after)
      before_each_call(before)
      after_each_call(after)
    end
end