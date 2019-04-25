require_relative "After.rb"

module AfterEachCall
    
  include After
  
  attr_accessor :afters, :defining_after_method
  
  def afters
    @afters ||= []
  end
  
  def after_each_call after
    afters << after
  end
  
  def method_added name
    unless @defining_after_method
      @defining_after_method = true
      redefine_method_with_afters name, @afters
      defined?(super) && super
      @defining_after_method = false
    end
  end
end