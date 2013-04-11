module I18nJs
  class Engine < ::Rails::Engine

    initializer "i18n-js.asset_dependencies", :after => "sprockets.environment" do
      next unless Rails.env.development?
      
      Rails.application.assets.register_preprocessor "application/javascript", :"i18n-js-preproc" do |context,data|
        puts context.inspect
        if context.logical_path == "i18n"
          json = {}
          ::I18n.load_path.each do |lp|
            y = YAML.load(File.read(lp))
            y.each do |k,v|
              json[k] ||= {}
              json[k].merge! v
            end
          end
          "window.i18n = {}; i18n._trans = " + json.to_json + "\n" + data
        else
          ::I18n.load_path.each do |lp|
            puts "#{lp}"
          end
          data
        end
      end
    end
  end
end
