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
  end

  class PluginceptionCommand < Redcar::Command
    def execute
      controller = ViewController.new
      tab = win.new_tab(HtmlTab)
      tab.html_view.controller = controller
      tab.focus
    end
  end
end