require_relative 'BeforeAndAfter.rb'
require_relative 'Invariant.rb'
class Guerrero

  extend Contratos
  attr_accessor :vida, :fuerza

  def initialize(vida, fuerza)
    vida =vida
    fuerza= fuerza
  end
  invariant { puts self}
  invariant { fuerza > 0 && fuerza < 100 }


  def atacar(otro)
    otro.vida -= fuerza
  end

  def decir_hola
    puts "hola"
  end
end

bren = Guerrero.new(-40, 30)
zana = Guerrero.new(40,2)
bren.atacar(zana)
