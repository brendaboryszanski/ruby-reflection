describe Invariant do

  class Guerrero

    extend Invariant

    attr_accessor :vida, :fuerza

    invariant {vida >= 0}
    invariant {fuerza > 0 && fuerza < 100}

    def initialize(vida = 100, fuerza = 20)
      self.vida = vida
      self.fuerza = fuerza
    end

    def atacar_a(otro)
      otro.ser_atacado(fuerza)
    end

    def ser_atacado(fuerza)
      self.vida -= fuerza
    end
  end

  let(:fuerte) {Guerrero.new(10, 10)}
  let(:debil) {Guerrero.new(5, 5)}

  describe '.new' do
    it 'corta la ejecucion instanciando con fuerza cero' do
      expect {Guerrero.new(10, 0)}.to raise_error RuntimeError
    end

    it 'corta la ejecucion instanciando con fuerza mayor a cien' do
      expect {Guerrero.new(10, 1000)}.to raise_error RuntimeError
    end

    it 'corta la ejecucion instanciando con vida menor a cero' do
      expect {Guerrero.new(-20, 10)}.to raise_error RuntimeError
    end
  end

  describe '.atacar' do
    it 'corta la ejecucion cuando el fuerte ataca a debil' do
      expect {fuerte.atacar_a debil}.to raise_error RuntimeError
    end

    it 'cuando el debil ataca al fuerte, la vida del fuerte es 5' do
      debil.atacar_a fuerte
      expect(fuerte.vida).to be 5
    end
  end
end