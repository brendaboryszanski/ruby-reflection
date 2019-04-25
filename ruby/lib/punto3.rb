require_relative "Pre.rb"
require_relative "Post.rb"

class Operaciones
    
  extend Pre
  extend Post
  
  #precondición de dividir
  pre { divisor != 0 }
  #postcondición de dividir
  post { |result| result * divisor == dividendo }
  def dividir(dividendo, divisor)
      dividendo / divisor
  end
  
  # este método no se ve afectado por ninguna pre/post condición
  def restar(minuendo, sustraendo)
      minuendo - sustraendo
  end

  post { |result| result > 0 }
  def restar_solo_resultado_positivo(minuendo, sustraendo)
    restar(minuendo, sustraendo)
  end
end

puts Operaciones.new.dividir(10, 5)
puts Operaciones.new.restar(0, 100)
#puts Operaciones.new.restar_solo_resultado_positivo(0, 100)