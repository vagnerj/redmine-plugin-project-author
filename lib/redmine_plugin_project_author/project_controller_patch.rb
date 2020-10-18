# pridat callback na ukladani/mazani projektu, implementace se deleguje do ProjectAuthor
module RedminePluginProjectAuthor
  module ProjectsControllerPatch
    def self.included(base)
      # :nodoc:
      base.extend(ClassMethods)

      base.send(:include, InstanceMethods)

      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development

        # TODO copy ?
        # delete - se chytne action na modelu
        after_action :update_project_author, only: [:update, :create, :copy]

        puts "opice zaplatuje Project controller!"
      end

    end

    module ClassMethods
    end

    module InstanceMethods
      def update_project_author
        puts "opice rika trigger after_action"
        new_author = params[:project][:author_id]
        ProjectAuthor.update_for_project(@project, new_author) unless new_author.nil?
        return true
      end

    end
  end
end
