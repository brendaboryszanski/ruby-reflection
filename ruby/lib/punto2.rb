require_relative "Invariant.rb"

class Guerrero
    
  extend Invariant
  
  attr_accessor :vida, :fuerza
  
  invariant { vida >= 0 }
  invariant { fuerza > 0 && fuerza < 100 }
  
  def initialize(vida = 100, fuerza = 20) 
    self.vida= vida
    self.fuerza= fuerza
  end
  
  def atacar(otro)
    otro.ser_atacado(fuerza)
  end

  def ser_atacado(fuerza)
    self.vida-= fuerza
  end
end

# Invariant no corta
atacante = Guerrero.new(5, 5)
boludo = Guerrero.new(10, -50)
#atacante.atacar(boludo)

# Invariant corta
# boludo = Guerrero.new(5, 5)
# atacante = Guerrero.new(10, 10)
# atacante.atacar(boludo)