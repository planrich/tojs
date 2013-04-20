module ToJs
  class Engine < ::Rails::Engine

    initializer "i18n-js.asset_dependencies", :after => "sprockets.environment" do
      next unless Rails.env.development?
      
      Rails.application.assets.register_preprocessor "application/javascript", :"tojs-preproc" do |context,data|
        if context.logical_path == "tojs/translation"
          ::I18n.load_path.each do |path|
            context.depend_on path
          end

          ToJs::preprocess ::I18n.load_path, ''
        else
          data
        end
      end
    end
  end
end
