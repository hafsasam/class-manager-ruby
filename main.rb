require_relative 'bibliotheque'
require 'csv'

class Main
  maBiblio = Bibliotheque.new

  puts "***************************************************************"
  puts "*                   GESTION DE BIBLIOTHEQUE                   *"
  puts "***************************************************************"
  puts "* 1. Lancer le menu 2                                         *"
  puts "* 2. Lancer le test de toutes les fonctions                   *"
  puts "* 3. Lancer un Web Service fournissant le menu 2              *"
  puts "***************************************************************"
  puts "*                         VOTRE CHOIX :                       *"

  choice = gets.strip

  if choice == '1'
    loop do
      puts "***************************************************************"
      puts "* 1. Créer un adhérent et l'ajouter à la bibliothèque         *"
      puts "* 2. Créer un livre et l'ajouter à la bibliothèque            *"
      puts "* 3. Créer un pc et l'ajouter à la bibliothèque               *"
      puts "* 4. Retourner un adhérent correspondant à un id              *"
      puts "* 5. Retourner un document correspondant à un ISBN            *"
      puts "* 6. Retourner un matériel correspondant à un id              *"
      puts "* 7. Retourner la collection des adhérents                    *"
      puts "* 8. Retourner la collection des documents                    *"
      puts "* 9. Retourner la collection des matériels                    *"
      puts "* 10. Ajouter une personne aux auteurs                        *"
      puts "* 11. Retourner un auteur correspondant à un id               *"
      puts "* 12. Retourner l'ensemble des ids des auteurs                *"
      puts "* 13. Retourner l'ensemble des ids des matériels              *"
      puts "* 14. Supprimer un adhérent de la bibliothèque                *"
      puts "* 15. Supprimer un matériel de la bibliothèque                *"
      puts "* 16. Supprimer un document de la bibliothèque                *"
      puts "* 17. Emprunter un ordinateur                                 *"
      puts "* 18. Emprunter un livre                                      *"
      puts "* 19. Rendre un ordinateur                                    *"
      puts "* 20. Rendre un livre                                         *"
      puts "* 21. Charger une bibliothèque à partir des .csv              *"
      puts "* 22. Enregistrer la bibliothèque dans des .csv               *"
      puts "* 23. Nombre d'occurences d'un mot dans War & Peace           *"
      puts "* 24. Afficher les 10 mots les plus utilisés dans War & Peace *"
      puts "* 25. Quitter                                                 *"
      puts "***************************************************************"
      puts "*                       VOTRE CHOIX                           *"
      puts "***************************************************************"

      choice2 = gets.strip

      case choice2
      when '1'
        puts "Nom :  "
        nom = gets.strip
        puts "Prénom :  "
        prenom = gets.strip
        puts "Statut :  \t\t1- Etudiant \t2- Enseignant\n"
        statut = gets.strip
        if statut == "1"
          adherent = Adherent.new(nom, prenom,"Etudiant")
        end
        if statut == "2"
          adherent = Adherent.new(nom, prenom,"Enseignant")
        end
        if maBiblio.add_adherent?(adherent)
          puts "Adhérent ajouté avec succès"
        else
          puts "Problème lors de l'ajout de l'adhérent !"
        end

      when '2'
        puts "Titre :  "
        titre = gets.strip
        puts "Auteur :  "
        auteur = gets.strip
        livre = Livre.new(titre,auteur)

        if maBiblio.add_document?(livre)
          puts "Livre ajouté avec succès"
        else
          puts "Problème lors de l'ajout du livre !"
        end

      when '3'
        puts "Marque :  "
        marque = gets.strip
        puts "Sustème d'exploitation :  \t\t1- Linux \t2- Windows\n"
        os = gets.strip
        puts "En panne :  \t\t1- Oui \t2- Non\n"
        panne = gets.strip

        if os == "1"
          if panne == "1"
            ordi = OrdinateurPortable.new(marque,"Linux", true)
          else
            ordi = OrdinateurPortable.new(marque,"Linux", false)
          end
        end
        if os == "2"
          if panne == "1"
            ordi = OrdinateurPortable.new(marque,"Windows",true)
          else
            ordi = OrdinateurPortable.new(marque,"Windows",false)
          end
        end

        if maBiblio.add_materiel?(ordi)
          puts "Ordinateur ajouté avec succès"
        else
          puts "Problème lors de l'ajout de l'ordinateur !"
        end

      when '4'
        puts "ID : "
        id = gets.strip.to_i
        adh = maBiblio.search_adh(id)
        if adh != nil
          adh.to_s
        else
          puts "Cet id ne correspond à aucun adhérent !"
        end

      when '5'
        puts "ISBN : "
        isbn = gets.strip.to_i
        doc = maBiblio.search_doc(isbn)
        if doc != nil
          doc.to_s
        else
          puts "Cet ISBN ne correspond à aucun document !"
        end

      when '6'
        puts "ID : "
        id = gets.strip.to_i
        mat = maBiblio.search_material(id)
        if mat != nil
          mat.to_s
        else
          puts "Cet id ne correspond à aucun matériel !"
        end

      when '7'
        maBiblio.all_adherents

      when '8'
        maBiblio.afficher_docs

      when '9'
        maBiblio.afficher_materiel

      when '10'
        puts "\nNom complet de l'auteur :  "
        name = gets.strip
        auteur = Auteur.new(name)
        maBiblio.add_author(auteur)

      when '11'
        puts "ID : "
        id = gets.strip.to_i
        aut = maBiblio.search_author(id)
        if aut != nil
          aut.to_s
        else
          puts "Cet id ne correspond à aucun auteur !"
        end

      when '12'
        maBiblio.id_authors

      when '13'
        maBiblio.id_materials

      when '14'
        puts "ID : "
        id = gets.strip.to_i
        maBiblio.del_adh(id)

      when '15'
        puts "ID : "
        id = gets.strip.to_i
        maBiblio.del_mat(id)

      when '16'
        puts "ISBN : "
        isbn = gets.strip.to_i
        maBiblio.del_doc(isbn)

      when '17'
        puts "ID de l'adhérent demandant l'emprunt : "
        id = gets.strip.to_i
        puts "ID de l'ordinateur : "
        immatr = gets.strip
        if maBiblio.search_adh(id) != nil
          mat = maBiblio.search_material(immatr)
          if id_mat != -1
            adh = maBiblio._adh[id]
            adh.emprunter_ordi(mat,maBiblio)
            adh.afficher_emprunts
          else
            raise(Indisponible.new)
          end
        else
          raise(Inconnu.new("cet adherent n'existe pas"))
        end

      when '18'
        puts "ID de l'adhérent demandant l'emprunt : "
        id = gets.strip.to_i
        puts "ISBN : "
        isbn = gets.strip.to_i
        livre = maBiblio.search_doc(isbn)
        if maBiblio.search_adh(id) != nil
          if isbn != -1
            adh = maBiblio._adh[id]
            adh.emprunter_livre(livre,maBiblio)
            adh.afficher_emprunts
          else
            raise(Indisponible.new)
          end
        else
          raise(Inconnu.new("Cet adherent n'existe pas"))
        end

      when '19'
        puts "ID de l'adhérent retournant l'ordinateur' : "
        id = gets.strip.to_i
        puts "ID de l'ordinateur : "
        immatr = gets.strip.to_i
        ordi = maBiblio.search_material(immatr)
        if id != -1
          if maBiblio._adh[id].emprunts.include?(maBiblio._material[immatr])
            adh = maBiblio._adh[id]
            adh.rendre(ordi,maBiblio)
            adh.afficher_emprunts

          else
            raise(Inconnu.new("Cet adherent n'a pas emprunté ce livre"))
          end
        else
          raise(Indisponible.new)
        end

      when '20'
        puts "ID de l'adhérent retournant le livre : "
        id = gets.strip.to_i
        puts "ISBN : "
        isbn = gets.strip.to_i
        livre = maBiblio.search_doc(isbn)
        if isbn != -1
          if maBiblio._adh[id].emprunts.include?(maBiblio._docs[isbn])
            adh = maBiblio._adh[id]
            adh.rendre(livre,maBiblio)
            adh.afficher_emprunts

          else
            raise(Inconnu.new("Cet adherent n'a pas emprunté ce livre"))
          end
        else
          raise(Indisponible.new)
        end

      when '21'
        CSV.foreach("adherents.csv", :headers => true) do |row|
          nom = row["nom"]
          prenom = row["prenom"]
          statut = row["statut"]
          adh = Adherent.new(nom, prenom, statut)
          maBiblio.add_adherent?(adh)
        end

        CSV.foreach("volumes.csv", :headers => true) do |row|
          titre = row["titre"]
          auteur = row["auteur"]
          doc = Volume.new(auteur, titre)
          maBiblio.add_document?(doc)
        end

        CSV.foreach("bd.csv", :headers => true) do |row|
          titre = row["titre"]
          auteur = row["auteur"]
          dessinateur = row["dessinateur"]
          bd = BandeDessinee.new(dessinateur, auteur, titre)
          maBiblio.add_document?(bd)
        end

        CSV.foreach("dict.csv", :headers => true) do |row|
          titre = row["titre"]
          auteur = row["auteur"]
          theme = row["dessinateur"]
          dict = Dictionnaire.new(auteur, titre, theme)
          maBiblio.add_document?(dict)
        end

        CSV.foreach("revue.csv", :headers => true) do |row|
          titre = row["titre"]
          num = row["numero"]
          rev = Revue.new(num, titre)
          maBiblio.add_document?(rev)
        end

        CSV.foreach("materiel.csv", :headers => true) do |row|
          marque = row["marque"]
          os = row["os"]
          panne = row["enPanne"]
          mat = OrdinateurPortable.new(marque, os, enPanne)
          maBiblio.add_materiel?(mat)
        end

        puts "Bibliothèque chargée"

      when '22'
        CSV.open("adherents.out.csv","a") do |row|
          maBiblio._adh.each do |adh|
            row << [adh.id_adh, adh.nom, adh.prenom, adh.statut]
          end
        end

        CSV.open("documents.out.csv","a") do |row|
          maBiblio._docs.each do |doc|
            if doc.is_a?(Livre)
              row << [doc.isbn, doc.titre, doc.auteur,'','']
            elsif doc.is_a?(Revue)
              row << [doc.isbn, doc.titre, '', '','']
            elsif doc.is_a?(BandeDessinee)
              row << [doc.isbn, doc.titre, doc.auteur, doc.dessinateur,'']
            elsif doc.is_a?(Dictionnaire)
              row << [doc.isbn, doc.titre, doc.auteur, '',doc.theme]
            end
          end
        end

        CSV.open("materiel.out.csv","a") do |row|
          maBiblio._material.each do |mat|
            row << [mat.immatr, mat.marque, mat.os, mat.enPanne]
          end
        end

        puts "Bibliothèque enregistrée dans adherents.out.csv , documents.out.csv et materiel.out.csv"

      when '23'
        puts "Mot cherché : "
        mot = gets.strip
        freq = maBiblio.occurence(mot)
        if freq[mot] != nil
          puts "#{mot} est #{freq[mot]} fois présent dans le livre"
        else
          puts "#{mot} n'existe pas dans le livre"
        end

      when '24'
        puts "Les 10 mots les plus utilisés dans le livre :"
        h1 = maBiblio.most_used_10_words()
        h1.each {|k, v| puts "Mot :'#{k}'    Ocurrence : #{v}" }


      else
        puts "Choix incorrect !"
        break if choice2.to_i > 24

      end
    end
  end

  if choice == '2'

    puts "*****************************************************"
    puts "*               TEST DES FONCTIONS                  *"
    puts "*****************************************************"
    puts
    puts "*****************************************************"
    puts "*           CREATION ET AJOUT D'ADHERENTS           *"
    puts "*****************************************************"

    adh1 = Adherent.new("Alaoui","Karim","Etudiant")
    adh2 = Adherent.new("Malki","Sara","Enseignant")
    if maBiblio.add_adherent?(adh1)
      puts "Adhérent #{adh1.nom} #{adh1.prenom} ajouté avec succès !"
    end

    if maBiblio.add_adherent?(adh2)
      puts "Adhérent #{adh2.nom} #{adh2.prenom} ajouté avec succès !"
    end

    puts
    puts "*****************************************************"
    puts "*           CREATION ET AJOUT DE DOCUMENTS          *"
    puts "*****************************************************"

    book1 = Livre.new("Stephen King","It", true)
    book2 = Livre.new("Stephen King","The shining", true)
    rev1 = Revue.new(1,"Science & Vie")
    rev2 = Revue.new(15,"Science & Vie Junior")
    dict1 = Dictionnaire.new("author1","Dictionary1","Histoire")
    dict2 = Dictionnaire.new("author2","Dictionary2","Mythologie")
    bd1 = BandeDessinee.new("artist1","author3","BD 1")
    bd2 = BandeDessinee.new("artist2","author4","BD 2")

    if maBiblio.add_document?(book1)
      puts "Livre #{book1.titre} ajouté avec succès !"
    end
    if maBiblio.add_document?(book2)
      puts "Livre #{book2.titre} ajouté avec succès !"
    end
    if maBiblio.add_document?(bd1)
      puts "Bande dessinée #{bd1.titre} ajouté avec succès !"
    end
    if maBiblio.add_document?(bd2)
      puts "Bande dessinée #{bd2.titre} ajouté avec succès !"
    end
    if maBiblio.add_document?(rev1)
      puts "Revue #{rev1.titre} ajouté avec succès !"
    end
    if maBiblio.add_document?(rev2)
      puts "Revue #{rev2.titre} ajouté avec succès !"
    end
    if maBiblio.add_document?(dict1)
      puts "Dictionnaire #{dict1.titre} ajouté avec succès !"
    end
    if maBiblio.add_document?(dict2)
      puts "Dictionnaire #{dict2.titre} ajouté avec succès !"
    end

    puts
    puts "*****************************************************"
    puts "*           CREATION ET AJOUT DE MATERIEL           *"
    puts "*****************************************************"

    ordi1 = OrdinateurPortable.new("Dell","Windows",true)
    ordi2 = OrdinateurPortable.new("Hp","Linux",false)

    if maBiblio.add_materiel?(ordi1)
      puts "Ordinateur portable #{ordi1.marque} ajouté avec succè !"
    end

    if maBiblio.add_materiel?(ordi2)
      puts "Ordinateur portable #{ordi2.marque} ajouté avec succè !"
    end

    puts
    puts "*****************************************************"
    puts "*            CREATION ET AJOUT D'AUTEURS            *"
    puts "*****************************************************"

    auteur1 = Auteurs.new("Stephen King")
    auteur2 = Auteurs.new("Marie Lou")

    maBiblio.add_author(auteur1)
    puts "Auteur #{auteur1.name} ajouté avec succè !"
    maBiblio.add_author(auteur2)
    puts "Auteur #{auteur2.name} ajouté avec succè !"

    puts
    puts "*****************************************************"
    puts "*                LISTE DES ADHERENTS                *"
    puts "*****************************************************"
    maBiblio.all_adherents
    puts
    puts "*****************************************************"
    puts "*                LISTE DES DOCUMENTS                *"
    puts "*****************************************************"
    maBiblio.afficher_docs
    puts
    puts "*****************************************************"
    puts "*                LISTE DES MATERIELS                *"
    puts "*****************************************************"
    maBiblio.afficher_materiel
    puts
    puts "*****************************************************"
    puts "*                      EMPRUNTS                     *"
    puts "*****************************************************"
    adh1.emprunter_livre(book1,maBiblio)
    puts "Livre #{book1.titre} emprunté par l'adhérent #{adh1.nom} #{adh1.prenom}"
    adh2.emprunter_livre(book2,maBiblio)
    puts "Livre #{book2.titre} emprunté par l'adhérent #{adh2.nom} #{adh2.prenom}"
    adh1.emprunter_ordi(ordi2,maBiblio)
    puts "Ordinateur portable #{ordi2.marque} emprunté par l'adhérent #{adh1.nom} #{adh1.prenom}"
    puts
    puts "*****************************************************"
    puts "*                       RENDUS                      *"
    puts "*****************************************************"
    adh1.rendre(book1,maBiblio)
    puts "Livre #{book1.titre} rendu"
    adh1.rendre(ordi2,maBiblio)
    puts "Ordinateur portable #{ordi2.marque} rendu"
    puts
    puts "*****************************************************"
    puts "*                    RECHERCHES                     *"
    puts "*****************************************************"
    maBiblio.search_adh(1)
    maBiblio.search_doc(3)
    maBiblio.search_material(2)
    maBiblio.search_author(2)

    puts
    puts "*****************************************************"
    puts "*                        IDS                        *"
    puts "*****************************************************"
    maBiblio.id_authors
    maBiblio.id_materials

    puts
    puts "*****************************************************"
    puts "*                    SUPPRESSION                    *"
    puts "*****************************************************"
    maBiblio.del_adh(1)
    maBiblio.del_doc(5)
    maBiblio.del_mat(2)

    puts
    puts "*****************************************************"
    puts "*                   WAR AND PEACE                   *"
    puts "*****************************************************"
    dream = maBiblio.occurence("dream")
    puts "Le mot dream a été répété #{dream} fois"
    puts
    puts "Les 10 mots les plus répétés sont :"
    ten_words = maBiblio.most_used_10_words
    for word in ten_words
      puts word.value
    end

    puts
    puts "*****************************************************"
    puts "*                 ENREGISTREMENT CSV                *"
    puts "*****************************************************"
    CSV.open("adherents.out.csv","a") do |row|
      maBiblio._adh.each do |adh|
        row << [adh.id_adh, adh.nom, adh.prenom, adh.statut]
      end
    end

    CSV.open("documents.out.csv","a") do |row|
      maBiblio._docs.each do |doc|
        if doc.is_a?(Livre)
          row << [doc.isbn, doc.titre, doc.auteur,'','']
        elsif doc.is_a?(Revue)
          row << [doc.isbn, doc.titre, '', '','']
        elsif doc.is_a?(BandeDessinee)
          row << [doc.isbn, doc.titre, doc.auteur, doc.dessinateur,'']
        elsif doc.is_a?(Dictionnaire)
          row << [doc.isbn, doc.titre, doc.auteur, '',doc.theme]
        end
      end
    end

    CSV.open("materiel.out.csv","a") do |row|
      maBiblio._material.each do |mat|
        row << [mat.immatr, mat.marque, mat.os, mat.enPanne]
      end
    end

    puts "Bibliothèque enregistrée dans adherents.out.csv , documents.out.csv et materiel.out.csv"
    puts
    puts "*****************************************************"
    puts "*                   CHARGEMENT CSV                   *"
    puts "*****************************************************"
    CSV.foreach("adherents.csv", :headers => true) do |row|
      nom = row["nom"]
      prenom = row["prenom"]
      statut = row["statut"]
      adh = Adherent.new(nom, prenom, statut)
      maBiblio.add_adherent?(adh)
    end

    CSV.foreach("volumes.csv", :headers => true) do |row|
      titre = row["titre"]
      auteur = row["auteur"]
      doc = Volume.new(auteur, titre)
      maBiblio.add_document?(doc)
    end

    CSV.foreach("bd.csv", :headers => true) do |row|
      titre = row["titre"]
      auteur = row["auteur"]
      dessinateur = row["dessinateur"]
      bd = BandeDessinee.new(dessinateur, auteur, titre)
      maBiblio.add_document?(bd)
    end

    CSV.foreach("dict.csv", :headers => true) do |row|
      titre = row["titre"]
      auteur = row["auteur"]
      theme = row["dessinateur"]
      dict = Dictionnaire.new(auteur, titre, theme)
      maBiblio.add_document?(dict)
    end

    CSV.foreach("revue.csv", :headers => true) do |row|
      titre = row["titre"]
      num = row["numero"]
      rev = Revue.new(num, titre)
      maBiblio.add_document?(rev)
    end

    CSV.foreach("materiel.csv", :headers => true) do |row|
      marque = row["marque"]
      os = row["os"]
      panne = row["enPanne"]
      mat = OrdinateurPortable.new(marque, os, enPanne)
      maBiblio.add_materiel?(mat)
    end


    puts "Bibliothèque chargée depuis les .csv"


  end

  if choice == '3'
    puts "Unavailable for now :("
  end


end