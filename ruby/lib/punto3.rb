require_relative 'PreYPost.rb'
class OperacionesMatematicas
  extend Contratos
  #precondición de dividir
  pre { divisor != 0 }
  #postcondición de dividir
  #post { |result| result * divisor == dividendo }
  def dividir(dividendo, divisor)
    dividendo * divisor
  end

  def divisor
    4
  end

  # este método no se ve afectado por ninguna pre/post condición
  def restar(minuendo, sustraendo)
    minuendo - sustraendo
  end

end


bren = OperacionesMatematicas.new
bren.divisor
bren.dividir(20,0)
bren.divisor