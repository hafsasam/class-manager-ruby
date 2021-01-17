class Document
  @@isbn = 0
  attr :titre, :isbn

  def self.current_id
    @@isbn
  end

  def initialize(title)
    @titre = title
    @@isbn += 1
    @isbn = self.class.current_id
  end

  def to_s
    puts "ISBN : #{@isbn} \t Titre : #{titre}"
  end
end

class Volume < Document
  attr :auteur

  def initialize(auteur, titre)
    super(titre)
    @auteur = auteur
  end

  def to_s
    puts "ISBN : #{@isbn} \t Titre : #{titre} \t Auteur : #{auteur}"
  end

end

class Revue < Document
  attr_accessor :numero

  def initialize(numero, titre)
    super(titre)
    @numero = numero
  end

  def to_s
    puts "ISBN : #{@isbn} \t Titre : #{titre} \t Numéro : #{numero}"
  end
end

class BandeDessinee < Volume
  attr_accessor :dessinateur

  def initialize(dessinateur, auteur, titre)
    super(auteur,titre)
    @dessinateur = dessinateur
  end

  def to_s
    puts "ISBN : #{@isbn} \t Titre : #{titre} \t Auteur : #{auteur} \t Dessinateur : #{dessinateur}"
  end
end

class Livre < Volume
  include Empruntable
  def initialize(auteur, titre, disponible = true)
    super(auteur, titre)
    @disponible = true
  end

  def to_s
    puts "ISBN : #{@isbn} \t Titre : #{titre} \t Auteur : #{auteur} \t Disponibile : #{disponible}"
  end

end