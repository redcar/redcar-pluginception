module Redcar
  class Pluginception
    class ViewController
      include Redcar::HtmlController

      def title
        "Plugin Finder"
      end

      def index
        rhtml = ERB.new(File.read(File.join(File.dirname(__FILE__), "..","views","index.html.erb")))
        rhtml.result(binding)
      end
    end
  end
end