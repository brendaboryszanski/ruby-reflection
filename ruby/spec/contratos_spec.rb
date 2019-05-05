
describe BeforeAndAfterEachCall do

  class MiClase

    attr_accessor :contador

    extend BeforeAndAfterEachCall

    def initialize
      self.contador= 0
    end

    before_and_after_each_call(
        # Bloque Before. Se ejecuta antes de cada mensaje
        proc{ self.contador+= 1 },
        # Bloque After. Se ejecuta después de cada mensaje
        proc{ self.contador+= 1 }
    )

    def contador_antes_del_after
      contador
    end
  end


  let(:mi_clase) { MiClase.new }

  describe '.before_and_after_each_call' do
    it 'incrementa en uno el contador antes y despues' do
      expect(mi_clase.contador).to be 0
      expect(mi_clase.contador_antes_del_after).to be 1
      expect(mi_clase.contador).to be 2
    end
  end
end