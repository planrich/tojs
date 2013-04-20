
require "tojs/hook"
require "tojs/rake"

module ToJs
  def preprocess paths, data
    json = {}
    paths.each do |lp|
      y = YAML.load(File.open(lp,'r'))
      y.each do |k,v|
        json[k] ||= {}
        json[k].merge! v
      end
    end
    "window.i18n = {}; i18n._trans = " + json.to_json + "\n" + data
  end
end
