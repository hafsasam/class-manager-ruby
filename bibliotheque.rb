require_relative 'adherent'
require_relative 'materiel'
require_relative 'document'
require_relative 'auteurs'
include Exceptions

class Bibliotheque
  attr_accessor :_docs, :_material, :_adh, :_fonds, :_auteurs

  def initialize()
    @_docs = Array.new
    @_material = Array.new
    @_adh = Array.new
    @_fonds = Array.new
    @_auteurs = Array.new
  end

  def add_adherent?(adherent)
    _adh.push(adherent)
    _fonds << adherent
    #if OK return true, else return false
    return !_adh.empty?
  end

  def add_document?(document)
    _docs.push(document)
    _fonds << document
    #if it's a doc with an author, add its author
    if document.is_a?(Volume)
      author = Auteurs.new(document.auteur)
      _auteurs << author
    end
    #if OK return true, else return false
    return !_docs.empty?
  end

  def add_materiel?(materiel)
    _material.push(materiel)
    _fonds << materiel
    #if OK return true, else return false
    return !_material.empty?
  end

  def afficher_fonds
    afficher_materiel
    afficher_docs
  end

  def afficher_materiel
    puts "\t\t**********Ordinateurs portables**********\t\t\n"
    for mat in _material
      puts "#{mat.to_s}\n"
    end
  end

  def afficher_docs
    puts "\t\t**********Livres**********\t\t\n"
    for book in _docs
      if book.is_a?(Livre)
        puts "#{book.to_s}\n"
      end
    end

    puts "\t\t**********Revues**********\t\t\n"
    for rev in _docs
      if rev.is_a?(Revue)
        puts "#{rev.to_s}\n"
      end
    end

    puts "\t\t**********Dictionnaires**********\t\t\n"
    for dict in _docs
      if dict.is_a?(Dictionnaire)
        puts "#{dict.to_s}\n"
      end
    end

    puts "\t\t**********Bandes dessinées**********\t\t\n"
    for bd in _docs
      if bd.is_a?(BandeDessinee)
        puts "#{bd.to_s}\n"
      end
    end

  end

  def add_author(author)
    if author.is_a?(Auteurs)
      _auteurs << author
    else
      puts "Ce n'est pas un auteur !"
    end
  end

  def search_author(id)
    found = false
    for author in _auteurs
      if id == author.id_author
        puts "Auteur trouvé"
        puts "#{author.to_s}"
        found = true
      end
    end
    if !found
      puts "Auteur introuvable !"
    end
  end

  def all_authors
    for auth in _auteurs
      puts "#{auth.to_s}"
    end
  end

  def id_authors
    puts "IDs des auteurs"
    all_authors
  end

  def recherche_titre(mot)
    refs = Array.new
    for doc in _docs
      if doc.titre.include?(mot)
        refs << doc.isbn
      end
    end
    return refs
  end

  def search_adh(id)
    found = false
    for pers in _adh
      if id == pers.id_adh
        puts "Adhérent trouvé"
        puts "#{pers.to_s}"
        found = true
      end
    end
    if !found
      puts "Adhérent introuvable !"
      return nil
    end
    return pers
  end

  def search_doc(isbn)
    found = false
    for doc in _docs
      if isbn == doc.isbn
        puts "Document trouvé"
        puts "#{doc.to_s}"
        found = true
      end
    end
    if !found
      puts "Document introuvable !"
      return nil
    end
    return doc
  end

  def search_material(id)
    found = false
    for mat in _material
      if id == mat.immatr
        puts "Matériel trouvé"
        puts "#{mat.to_s}"
        found = true
      end
    end
    if !found
      puts "Matériel introuvable !"
      return nil
    end
    return mat
  end

  def all_adherents
    puts "Tous les adhérents :"
    for adh in _adh
      puts "#{adh.to_s}"
    end
  end

  def id_materials
    puts "IDs des matériels"
    for mat in _material
      puts "#{mat.to_s}"
    end
  end

  def del_adh(id)
    registered_adh = search_adh(id)
    if registered_adh != nil
      _adh.delete(registered_adh)
      puts "Adhérent supprimé avec succès"
    else
      puts "Adhérent introuvable !"
    end
  end

  def del_doc(isbn)
    registered_doc = search_doc(isbn)
    if registered_doc != nil
      _docs.delete(registered_doc)
      puts "Document supprimé avec succès"
    else
      puts "Document introuvable !"
    end
  end

  def del_mat(id)
    registered_mat = search_mat(id)
    if registered_mat != nil
      _material.delete(registered_mat)
      puts "Matériel supprimé avec succès"
    else
      puts "Matériel introuvable !"
    end
  end

  def occurences()
    freq = Hash.new
    book = File.open("Livre.txt",r)
    #select each line
    book.each_line do |line|
      #store individual words
      words = line.split(' ')
      #check if the word is already added
      words.each do |w|
        #update the word occurence
        if freq.has_key?(w)
          freq[w] += 1
        else
          freq[w] = 1
        end
      end
    end
    book.close
    return freq
  end

  def occurence(mot)
    h = occurences
    for word in h.keys
      if word == mot
        return word.value
      end
    end
  end

  def most_used_10_words
    all_words = occurences
    ten_words_sorted = all_words.sort_by{|k, v| v}.reverse[0..9]
    return ten_words_sorted
  end

end