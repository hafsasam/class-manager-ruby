module Empruntable
  attr :disponible

  def is_available?
    @disponible
  end

  def set_available(dispo)
    @disponible = dispo
  end
end