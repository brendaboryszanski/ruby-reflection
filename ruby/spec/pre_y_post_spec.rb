
describe Pre do

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


  let(:operacion) { Operaciones.new }

  describe '.dividir' do
    it 'al llamarlo con divisor 0 deberia romper' do
      expect { operacion.dividir(10,0) }.to raise_exception
    end

    it 'al dividir correctamente no deberia romper' do
      expect(operacion.dividir(10,5)).to be(2)
    end
  end

  describe '.restar_solo_resultado_positivo' do
    it 'al llamarlo con minuendo menor a sustraendo deberia romper' do
      expect { operacion.restar_solo_resultado_positivo(10,20) }.to raise_exception
    end

    it 'al llamarlo con minuendo mayor a sustraendo no deberia romper' do
      expect(operacion.restar_solo_resultado_positivo(10,5)).to be(5)
    end
  end
end