require_relative 'BeforeAndAfter.rb'
require_relative 'Invariant.rb'
class Guerrero
  extend Contratos

  attr_accessor :vida, :fuerza


  invariant { vida > 0 }
  invariant { fuerza > 0 && fuerza < 100 }

  def initialize(vida, fuerza)
    self.vida =vida
    self.fuerza= fuerza
  end


  def ser_atacado(otro)
    self.vida = vida - otro.fuerza
    puts "estoy atacando"
    # otro.vida -= fuerza
  end

end

bren = Guerrero.new(20, 30)
zana = Guerrero.new(20,30)

#bren.ser_atacado(zana)
