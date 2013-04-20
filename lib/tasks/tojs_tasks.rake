namespace :tojs do
  desc "precompile the translations"
  task :precompile => [:environment] do
    javascript = ToJs::preprocess ::I18n.load_path, ''

    path = Rails.root + 'public' + 'assets' + 'tojs'
    path.mkpath
    path += 'translation.js'

    file = File.open(path, 'w')
    file.write(javascript)
    file.close()
  end
end
