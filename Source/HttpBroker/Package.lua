return {
	Name = "httpbroker",
	Version = "1.0.0",
	Description = "Rate-limited, fault-tolerant HTTP request handling.",
	Author = {
		Name = "MemoryPenguin",
		UserId = 41345114,
		GitHub = "https://github.com/MemoryPenguin/"
	},
	License = "MIT",
	Main = "HttpBroker",
	Dependencies = {
		promise = "https://github.com/MemoryPenguin/MiscLibs/tree/master/Source/Promise"
	},
	Repository = "https://github.com/MemoryPenguin/MiscLibs",
	Platform = {
		Client = false,
		Server = true
	}
}