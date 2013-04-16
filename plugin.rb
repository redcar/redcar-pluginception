Plugin.define do
  name    "Pluginception"
  version "0.1"
  file    "lib", "pluginception"
  object  "Redcar::Pluginception"
  dependencies "git", ">0",
               "application", ">0"
end