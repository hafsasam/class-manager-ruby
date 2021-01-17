class Auteurs
  @@id_author = 0

  attr_accessor :id_author, :name

  def self.current_id
    @@id_author
  end

  def initialize(name)
    @@id_author += 1
    @id_author = self.class.current_id
    @name = name
  end

  def to_s
    puts "ID : #{@id_author} \t Nom & prénom : #{name}"
  end
end