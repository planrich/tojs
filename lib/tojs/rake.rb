module ToJs
  class RakeHook < Rails::Railtie
    rake_tasks do
      load "lib/tasks/tojs_tasks.rake"
    end
  end
end
