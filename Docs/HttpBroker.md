The HttpBroker class is an intermediary for interacting with [HttpService](http://wiki.roblox.com/index.php?title=API:Class/HttpService) that adds request limiting and recovery from limit exhaustion.

HttpBroker supports optional asynchronous requests via the [Promise](Promise.md) module. See [module loading](Load.md#module-dependencies) for information on how this is loaded. If promises are not available, asynchronous requests will not be available. 

## API
### HttpBroker HttpBroker.new(int limit = 100)
Returns a new HttpBroker with a maximum budget of `limit`. The HttpBroker will never incur more than `limit` requests within a minute.

### boolean, string HttpBroker:Get(string url, bool nocache = false, Dictionary<string, string> headers = nil)
Performs a HTTP GET request. If the first return value is `true`, the second value is the string value of the HTTP request. If it is `false`, the second value is the error message that caused the request to fail.

### boolean, string HttpBroker:Post(string url, string data, [HttpContentType](http://wiki.roblox.com/index.php?title=API:Enum/HttpContentType) contentType = ApplicationJson, boolean compress = false, Dictionary<string, string> headers = nil)
Performs a HTTP POST request. If the first return value is `true`, the second value is the string value of the HTTP request. If it is `false`, the second value is the error message that caused the request to fail.

### Promise<boolean, string> HttpBroker:GetAsync(string url, bool nocache = false, Dictionary<string, string> headers = nil)
Performs an asynchronous HTTP GET request and returns a promise that resolves to the same results as its synchronous counterpart.

### Promise<boolean, string> HttpBroker:PostAsync(string url, string data, [HttpContentType](http://wiki.roblox.com/index.php?title=API:Enum/HttpContentType) contentType = ApplicationJson, boolean compress = false, Dictionary<string, string> headers = nil)
Performs an asynchronous HTTP POST request and returns a promise that resolves to the same results as its synchronous counterpart.

