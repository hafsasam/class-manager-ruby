class Adherent
  @@id_adh = 0

  attr_accessor :nom, :prenom, :statut, :emprunts, :id_adh

  def self.current_id
    @@id_adh
  end

  def initialize(nom, prenom, statut)
    @nom = nom
    @prenom = prenom
    @statut = statut
    @emprunts = Array.new
    @@id_adh += 1
    @id_adh = self.class.current_id
  end

  def to_s
    puts "ID : #{@id_adh} \t Nom : #{nom} \t Prénom : #{prenom} \t Statut : #{statut}"
  end

  def emprunter_livre(book, store)
    bookCount = 0
    #check if what they want to rent is a book
    if book.class == Livre
      #check that they haven't rented 5 books already
      for emp in emprunts
        if emp.class == Livre
          #count rented books
          bookCount += 1
        end
      end
      #if they can rent a book and it is available, OK
      if bookCount < 5
        if book.is_available?
          book.set_available(false)
          emprunts << book
          #they can rent but the book is unavailable
        else
          puts "Ce livre n'est pas disponible !"
        end
        #they already rented 5 books
      else
        puts "Vous n'avez le droit d'emprunter que 5 livres !"
      end
      #it's not a book
    else
      puts "Vous n'avez pas le droit d'emprunter cet ouvrage !"
    end
  end

  def emprunter_ordi(pc, store)
    if pc.class == OrdinateurPortable
      #check if they rented a pc
      for emp in emprunts
        if emp.class == OrdinateurPortable
          puts "Vous n'avez le droit d'emprunter qu'un seul ordinateur !"
        end
      end
      #they haven't rented a pc, check its availability
      if pc.is_available?
        pc.set_available(false)
        emprunts << pc
      else
        puts "Cet ordinateur est déjà pris !"
      end
      #it's not a pc
    else
      puts "Vous n'avez pas le droit d'emprunter ce matériel !"
    end
  end

  def rendre(object, store)
    #test that the object was rented, if so remove it and set it available
    if object.is_available? == false
      object.set_available(true)
      emprunts.delete(object)
    end
  end

  def afficher_emprunts()
    puts "Emprunts :"
    for emp in emprunts
      puts "#{emp.to_s}"
    end
  end

end