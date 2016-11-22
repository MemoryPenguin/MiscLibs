local Promise = {}
Promise.__index = Promise

function Promise.new()
	local self = setmetatable({
		_fulfilled = false;
		_fulfilledSignal = Instance.new("BindableEvent");
	})
	
	self.Fulfilled = self._fulfilledSignal.Event
end

function Promise:Fulfill(...)
	if not self._fulfilled then
		self.Values = {...}
		self._fulfilled = true
		self._fulfilledSignal:Fire(...)
	end
end

function Promise.All(...)
	local agglomerate = Promise.new()
	local waitingOn = select("#", ...)
	
	for i = 1, select("#", ...) do
		local promise = select(i, ...)
		local connection
		connection = promise.Fulfilled:Connect(function()
			connection:Disconnect()
			waitingOn = waitingOn - 1
			
			if waitingOn == 0 then
				agglomerate:Fulfill()
			end
		end)
	end
	
	return agglomerate
end

function Promise.Any(...)
	local agglomerate = Promise.new()
	local connections = {}
	
	for i = 1, select("#", ...) do
		local promise = select(i, ...)
		table.insert(connections, promise.Fulfilled:Connect(function()
			for _, connection in ipairs(connections) do
				if connection.Connected then
					connection:Disconnect()
				end
			end
			
			agglomerate:Fulfill()
		end))
	end
	
	return agglomerate
end

function Promise.FromEvent(event)
	local connection
	local promise = Promise.new()
	
	connection = event:Connect(function(...)
		promise:Fulfill(...)
		connection:Disconnect()
	end)
	
	return promise
end

return Promise