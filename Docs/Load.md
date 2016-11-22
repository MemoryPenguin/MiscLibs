The Load module is used for easily loading modules that may be in a variety of places from a single function. It returns a single function that takes any number of string arguments. Each of these arguments should correspond to a module's name located as a child of one of the search locations. By default, Load will search in these locations:

* The Load module itself, 
* game.StarterPlayer.StarterCharacterScripts,
* game.StarterPlayer.StarterPlayerScripts,
* game.ServerScriptService.Modules (if present), and
* game.ReplicatedStorage.Modules (if present).

Of note is that the arguments are the names of the actual ModuleScript objects, not a path to them. Load uses `FindFirstChild(name, true)` to search for the modules.

All modules in this project, should they require other modules, will try to use Load first. All of them assume the Load ModuleScript is a direct child of ReplicatedStorage.