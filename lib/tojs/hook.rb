module ToJs
  class Engine < ::Rails::Engine

    initializer "i18n-js.asset_dependencies", :after => "sprockets.environment" do
      next unless Rails.env.development?
      
      Rails.application.assets.register_preprocessor "application/javascript", :"tojs-preproc" do |context,data|
        if context.logical_path == "i18n"
          json = {}
          ::I18n.load_path.each do |lp|
            context.depend_on(lp)
            y = YAML.load(File.open(lp,'r'))
            y.each do |k,v|
              json[k] ||= {}
              json[k].merge! v
            end
          end
          "window.i18n = {}; i18n._trans = " + json.to_json + "\n" + data
        else
          data
        end
      end
    end
  end
end
