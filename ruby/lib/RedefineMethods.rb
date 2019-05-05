module Contratos
  def redefine_args(method_name)
    A.instance_method(:method1).parameters.map(&:last).map(&:to_s)
  end

end