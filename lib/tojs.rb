
require "tojs/hook"

module ToJs
  extend self
  def preprocess paths, data
    json = {}
    paths.each do |lp|
      y = YAML.load(File.open(lp,'r'))
      y.each do |k,v|
        json[k] ||= {}
        json[k].merge! v
      end
    end
    data + "i18n._trans = " + json.to_json + "\n"
  end
end
