require_relative "Before.rb"

module BeforeEachCall
    
  include Before
  
  attr_accessor :befores, :defining_before_method

  def befores
    @befores ||= []
  end
  
  def before_each_call before
    befores << before
  end
  
  def method_added name
    unless @defining_before_method
      @defining_before_method = true
      redefine_method_with_befores name, @befores
      defined?(super) && super
      @defining_before_method = false
    end
  end
end