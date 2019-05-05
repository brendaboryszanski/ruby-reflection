require_relative 'BeforeAndAfter.rb'
require_relative 'Invariant.rb'
class MiClase

  extend Contratos

  before_and_after_each_call(
      # Bloque Before. Se ejecuta antes de cada mensaje
      proc{ puts "Entre a un mensaje" },
      # Bloque After. Se ejecuta después de cada mensaje
      proc{ puts "Sali de un mensaje" }
  )

  before_and_after_each_call(
      # Bloque Before. Se ejecuta antes de cada mensaje
      proc{ puts "Entre a otro mensaje" },
      # Bloque After. Se ejecuta después de cada mensaje
      proc{ puts "Sali de otro mensaje" }
  )

  def mensaje_1
    puts "mensaje_1"
    return 5
  end

  def mensaje_2
    puts "mensaje_2"
    return 3
  end

end


MiClase.new.mensaje_1