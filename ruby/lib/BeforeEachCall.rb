require_relative "Before.rb"
require_relative "Operation.rb"

module BeforeEachCall

  include Before
  include Operation

  def before_each_call(before)
    run_on_method_added { |name|
      redefine_method_with_before name, before
    }
  end
end