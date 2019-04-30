require_relative "After.rb"
require_relative "Operation.rb"

module AfterEachCall

  include After
  include Operation

  def after_each_call(after)
    run_on_method_added { |name|
      redefine_method_with_after name, after
    }
  end
end