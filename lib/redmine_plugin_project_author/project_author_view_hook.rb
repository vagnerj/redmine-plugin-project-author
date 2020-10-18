module RedminePluginProjectAuthor

  class ProjectAuthorViewHook < Redmine::Hook::ViewListener

    # adds select box with users to select project author
    #
    # view:  <%= call_hook(:view_projects_form, :project => @project, :form => f) %>
    def view_projects_form(context = {})

      proj = context[:project]
      form = context[:form]

      author_id = ProjectAuthor.project_author_id(proj)

      output = ''
      output << form.label(l(:field_author), {:for => "project_author_id"})
      output << form.collection_select(:author_id, ProjectAuthor.users_for_author_selextbox(proj), :id, :name, {prompt: true, blank:true, :selected => author_id})

      return tag.p(output.html_safe)

    end

  end

end