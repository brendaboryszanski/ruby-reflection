require_relative "BeforeAndAfterEachCall.rb"

class Otra

  extend BeforeAndAfterEachCall
  
  before_and_after_each_call(
    # Bloque Before. Se ejecuta antes de cada mensaje
    proc{ puts "O. Entré a un mensaje" },
    # Bloque After. Se ejecuta después de cada mensaje
    proc{ puts "O. Salí de un mensaje" }
  )
  
  def mensaje_5
    puts "mensaje_5"
  end
end

class MiClase

  extend BeforeAndAfterEachCall
  
  before_and_after_each_call(
    # Bloque Before. Se ejecuta antes de cada mensaje
    proc{ puts "Entré a un mensaje" },
    # Bloque After. Se ejecuta después de cada mensaje
    proc{ puts "Salí de un mensaje" }
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

class MiClase 
  
  def mensaje_3
    puts "mensaje_3"
  end
end

MiClase.new.mensaje_3
Otra.new.mensaje_5