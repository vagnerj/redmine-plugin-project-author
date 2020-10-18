# pridat callback na ukladani/mazani projektu, implementace se deleguje do ProjectAuthor
module RedminePluginProjectAuthor
  module ProjectPatch
    def self.included(base) # :nodoc:
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

                            # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      # TODO bohuzel ale po ulozeni nemam(e) pristup k tem datum z formulare
      # ale ted zkousim namapovat krz ten has_one nize
      after_save :update_project_author
      after_destroy :drop_project_author

      has_one :author, class_name: 'ProjectAuthor', :dependent => :destroy

      # pridat k "bezpecnym" atributum, jinak to controller orizne TODO rly?
      safe_attributes 'author_id'

      puts "opice zaplatuje Project model!"
    end

    end

    module ClassMethods
    end

    module InstanceMethods
      # update_project_author(project, user_id)
      def update_project_author

        puts "opice rika trigger after_savee"

        self.reload # zpropagovat zmeny, ktere se ukladaji, do instance
        puts self.author.to_s
        # TODO pokud je v databazi, tak tu chodi namapovana .. takze pridat do view, aby se to naplnilo se zalozenim

        # TODO nekdo to musi validaovat, takze asi tady, kdyz ma byt controller 'thin'
        # puts "invalid user id" unless User.find(self.author_id)

        # TODO az to bude behat :)
        # ProjectAuthor.update_from_project(self.id, self.author_id)
        return true
      end

      def drop_project_author
        ProjectAuthor.destroy_all(['project_id = (?)', self.id]) if self.id
      end
    end
  end
end
