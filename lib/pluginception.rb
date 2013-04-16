require_relative 'view_controller'

module Redcar
  class Pluginception

    def self.menus
      Menu::Builder.build do
        sub_menu "Plugins" do
          sub_menu "Pluginception" do
            item "Find New Plugins", PluginceptionCommand
          end
        end
      end
    end

    def self.keymaps
      osx = Redcar::Keymap.build("main", [:osx]) do
        link "Cmd+Shift+P", PluginceptionCommand
      end
      lin = Redcar::Keymap.build("main", [:windows,:linux]) do
        link "Ctrl+Shift+P", PluginceptionCommand
      end
      [osx,lin]
    end

    class PluginceptionCommand < Redcar::Command
      def fetched_plugins
        JSON.parse(File.read(File.join(File.dirname(__FILE__), "..","spec","fixtures","plugins.json")))
      end

      def execute
        controller = Pluginception::ViewController.new(fetched_plugins)
        tab = win.new_tab(HtmlTab)
        tab.html_view.controller = controller
        tab.focus
      end
    end
  end
end