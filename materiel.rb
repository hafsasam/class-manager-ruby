class Materiel
  @@immatr = 0
  attr_accessor :enPanne, :immatr

  def self.current_id
    @@immatr
  end

  def initialize(enPanne = false)
    @enPanne = enPanne
    @@immatr += 1
    @immatr = self.class.current_id
  end

  def to_s
    puts "ID : #{@immatr} \t En panne : #{enPanne}"
  end
end

class OrdinateurPortable < Materiel
  include Empruntable
  attr_accessor :marque, :os

  def initialize(marque, os, enPanne, disponible = true)
    super(enPanne)
    @marque = marque
    @os = os
    @disponible = true
  end

  def to_s
    puts "ID : #{@immatr} \t En Panne : #{enPanne} \t Marque : #{marque} \t OS : #{os} \t Disponible : #{disponible}"
  end

end