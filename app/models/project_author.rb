# instance prirazeni autora k projektu
class ProjectAuthor < ActiveRecord::Base
  unloadable

  belongs_to :project
  belongs_to :user

  # tohle vola Project.after_save, aktualizuje/ulozi vazbu
  def self.update_from_project(project_id, user_id)
    puts "project_id #{project_id} user_id #{user_id}"
    return true if project_id.nil? || user_id.nil?
    project_author = ProjectAuthor.find_or_initialize_by(project_id: project_id)
    project_author.project_id = project_id
    project_author.user_id = user_id

    return project_author.save # persistovat/aktualizovat
  end

end
