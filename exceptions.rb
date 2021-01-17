module Exceptions
  class Inconnu < RuntimeError
    def initialize(msg)
      puts msg
    end
  end

  class Indisponible < RuntimeError
    def initialize()
      puts "Indisponible dans cette bibliothéque"
    end
  end

  class MaxEmprunts < RuntimeError
    def initialise()
      puts "Vous avez atteint le nombre max d'emprunts !"
    end
  end

end