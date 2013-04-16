module Redcar
  class Pluginception
    class ViewController
      include Redcar::HtmlController

      attr_reader :plugins

      def initialize json
        @plugins = json["plugins"]
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
        plugin_dir      = user_plugin_dir + url.split("/").last.sub("redcar-","")
        output          = clone(url, plugin_dir)

        if File.exists?(plugin_dir)
          Redcar.plugin_manager.add_plugin_source(user_plugin_dir)
          PluginManagerUi::OpenCommand::Controller.new.enable_plugin(name)
          Redcar::Application::Dialog.message_box("#{name} plugin installed", "Installation Complete")
        else
          Redcar::Application::Dialog.message_box("#{name} could not be installed at this time", "Installation Failed")
        end
      end

      def clone url, destination
        `git clone --depth 1 #{url} #{destination}`
      end
    end
  end
end