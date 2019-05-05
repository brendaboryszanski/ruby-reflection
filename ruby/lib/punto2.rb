require_relative 'BeforeAndAfter.rb'
require_relative 'Invariant.rb'
class Guerrero

  attr_accessor :vida, :fuerza

  def initialize(vida, fuerza)
    vida =vida
    fuerza= fuerza
  end


  extend Contratos

  invariant { vida > 0 }
  invariant { fuerza > 0 && fuerza < 100 }


  def atacar(otro)
    puts "estoy atacando"
    # otro.vida -= fuerza
  end

  def decir_hola
    puts "hola"
  end
end

bren = Guerrero.new(-40, 30)
zana = Guerrero.new(40,2)
bren.atacar(zana)
