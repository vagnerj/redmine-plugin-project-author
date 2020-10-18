# pridat callback na mazani projektu, pro pripad ze to nekdo vola pres API> implementace se deleguje do ProjectAuthor
module RedminePluginProjectAuthor
  module ProjectPatch
    def self.included(base)
      # :nodoc:
      base.extend(ClassMethods)

      base.send(:include, InstanceMethods)

      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development

        after_destroy :drop_project_author

        has_one :author, class_name: 'ProjectAuthor', :dependent => :destroy

        safe_attributes 'author'

        puts "opice zaplatuje Project model!"
      end

    end

    module ClassMethods
    end

    module InstanceMethods

      def drop_project_author
        if self.id
          ProjectAuthor.where('project_id = (?)', self.id).destroy_all
        end
      end
    end
  end
end
