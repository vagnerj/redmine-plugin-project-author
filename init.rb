require 'redmine'

ActiveSupport::Reloader.to_prepare do

  require 'redmine_plugin_project_author/project_model_patch'

  require_dependency 'project'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  unless Project.included_modules.include? RedminePluginProjectAuthor::ProjectPatch
    Project.send(:include, RedminePluginProjectAuthor::ProjectPatch)
  end

end

require 'redmine_plugin_project_author/project_author_view_hook'

Redmine::Plugin.register :redmine_plugin_project_author do
  name 'Project with Author field'
  author 'Jakub Vagner'
  description 'This is a plugin for Redmine which adds author field to project configuration'
  version '0.0.1'
  url 'https://github.com/vagnerj/redmine-plugin-project-author'
  author_url 'https://snekovo.info/'
end
