The Promise class encapsulates a value that will be supplied at an unknown time in the future by an external module. An example would be executing a HTTP request asynchronously: instead of blocking the thread while the request is in operation, a promise can be returned immediately that will eventually resolve to the value.

## API
### Function Promise Promise.new()
Creates and returns a promise.

### Function Promise Promise.All(Promise... promises)
Returns a promise that will be fulfilled when all the promises passed to `All` are fulfilled. The promise will be fulfilled with an array of arrays; each subarray will contain all the values passed to a promise when it was fulfilled.

### Function Promise Promise.Any(Promise... promises)
Returns a promise that will be fulfilled when any one of the promises passed to `Any` are fulfilled. The agglomerate promise will be fulfilled with the values of the first promise to be fulfilled.

### Function Promise.FromEvent([RBXScriptSignal](http://wiki.roblox.com/index.php?title=RBXScriptSignal) event)
Returns a promise that will be fulfilled the next time `event` fires with all values passed by `event`.

### Method void Promise:Fulfill(Variant... values)
Fulfills the promise with `values`. This method may be called only once per promise; further calls will be silently discarded.

### Field boolean Promise.IsFulfilled
Whether the promise has been fulfilled or not.

### Field Variant<nil, Array<Variant>> Promise.Values
The values of the promise, in the order that they were passed to `Fulfill`, or `nil` if it has not been fulfilled yet.

### Event Promise.Fulfilled(Variant... values)
An event that will be fired when the promise is fulfilled with all the values passed to `Fulfill`.

## Example
This is a simple example use of promises to perform asynchronous HTTP GET requests. This example assumes that the Promise module has already been loaded into the variable `Promise`.

```lua
local HttpService = game:GetService("HttpService")

local function Get(url)
	local promise = Promise.new()

	spawn(function()
		promise:Fulfill(pcall(HttpService.GetAsync, HttpService, url))
	end)

	return promise
end

local result = Get("http://google.com/")

result.Fulfilled:Connect(function(success, response)
	print(success, response)
end)

print("I will be printed first!")
```

This outputs:

```
I will be printed first!
true [a long HTML string]
```