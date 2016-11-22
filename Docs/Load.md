## The Load Module
The Load module is used for easily loading modules that may be in a variety of places from a single function. It returns a single function that takes any number of string arguments. Each of these arguments should correspond to a module's name located as a child of one of the search locations. By default, Load will search in these locations:

* The Load module itself, 
* game.StarterPlayer.StarterCharacterScripts,
* game.StarterPlayer.StarterPlayerScripts,
* game.ServerScriptService.Modules (if present), and
* game.ReplicatedStorage.Modules (if present).

Of note is that the arguments are the names of the actual ModuleScript objects, not a path to them. Load uses `FindFirstChild(name, true)` to search for the modules.

All modules in this project, should they require other modules, will try to use Load first. All of them assume the Load ModuleScript is a direct child of ReplicatedStorage.

## Module Dependencies
Some modules require other modules to work properly. Sometimes these dependencies are optional. An example of this is the [HttpBroker](HttpBroker.md) class, which can optionally use the [Promise](Promise.md) module to allow asynchronous HTTP requests.

Modules follow a simple ruleset for loading dependencies:
1. First, they search for the Load module in `game.ReplicatedStorage`. If found, they use that module to load dependencies.
2. If Load is not available, they search for the module in `game.ReplicatedStorage`.
3. If the dependency is not in `game.ReplicatedStorage`, they search the module's children.

If loading is unsuccessful, the behavior depends on whether the module is a required or optional dependency. If it is an optional dependency, a warning will be printed and functionality that depends on that module will be disabled. If it is a required dependency, the module will immediately error before being loaded.
