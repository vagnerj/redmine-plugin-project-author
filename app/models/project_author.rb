# model for link between project and it's author
class ProjectAuthor < ActiveRecord::Base
  unloadable

  belongs_to :project
  belongs_to :user

  # call from ProjectController after CRUD operations on the project itself
  def self.update_for_project(project, user_id)

    raise ArgumentError "Empty project argument" if project.nil?

    if user_id.blank?
      # drop author if set
      return project.author.destroy unless project.author.nil?
    else
      # update author
      project_author = ProjectAuthor.find_or_initialize_by(project_id: project.id)
      project_author.project_id = project.id
      project_author.user_id = user_id
      return project_author.save # persistovat/aktualizovat
    end

  end

  # returns id of related user, if set
  def self.project_author_id(project)
    author_id = project.author.user_id unless project.author.nil?
    return author_id
  end

  # returns all users for "author" select box in project settings
  def self.users_for_author_selextbox(project)
    User.where('status=1') # nebo project.users?
  end
end
