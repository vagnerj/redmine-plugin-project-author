require 'redmine'

ActiveSupport::Reloader.to_prepare do

  require 'redmine_plugin_project_author/project_model_patch'

  require_dependency 'project'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  unless Project.included_modules.include? RedminePluginProjectAuthor::ProjectsModelPatch
    Project.send(:include, RedminePluginProjectAuthor::ProjectsModelPatch)
  end

  require 'redmine_plugin_project_author/project_controller_patch'

  unless ProjectsController.included_modules.include? RedminePluginProjectAuthor::ProjectsControllerPatch
    ProjectsController.send(:include, RedminePluginProjectAuthor::ProjectsControllerPatch)
  end
end

require 'redmine_plugin_project_author/project_author_view_hook'

Redmine::Plugin.register :redmine_plugin_project_author do
  name 'Project with Author field'
  author 'Jakub Vagner'
  description 'This is a plugin for Redmine which adds author field to the project configuration'
  version '0.0.1'
  url 'https://github.com/vagnerj/redmine-plugin-project-author'
  author_url 'https://www.linkedin.com/in/jakubvagner/'
end
