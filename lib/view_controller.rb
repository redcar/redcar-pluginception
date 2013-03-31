module Redcar
  class Pluginception
    class ViewController
      include Redcar::HtmlController

      def initialize plugin_json
        @json = plugin_json
      end

      def title
        "Plugin Finder"
      end

      def index
        rhtml = ERB.new(File.read(File.join(File.dirname(__FILE__), "..","views","index.html.erb")))
        rhtml.result(binding)
      end

      def install_plugin name, url
        user_plugin_dir = Redcar.user_dir + "/plugins/"
        plugin_dir = user_plugin_dir + url.split("/").last
        `git clone --depth 1 #{url} #{plugin_dir}`
        # Redcar::Runnables.run_process(".","git clone --depth 1 #{url} #{plugin_dir}", "Plugin Fetch","none")
        Redcar.plugin_manager.add_plugin_source(user_plugin_dir)
        PluginManagerUi::OpenCommand::Controller.new.enable_plugin(name)
      end
    end
  end
end