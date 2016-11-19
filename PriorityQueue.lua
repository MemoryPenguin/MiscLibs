local PriorityQueue = {}
PriorityQueue.__index = PriorityQueue

function PriorityQueue.new()
	return setmetatable({
		_items = {};
		_counts = setmetatable({}, { __index = function() return 0 end });
		_first = 0;
		Count = 0;
	}, PriorityQueue)
end

function PriorityQueue:Enqueue(item, priority)
	debug.profilebegin("PriorityQueue:Enqueue")
	local index = 1

	debug.profilebegin("Index computation")
	for existingPriority, count in pairs(self._counts) do
		if existingPriority > priority then
			break
		else
			index = index + count
		end
	end
	debug.profileend()

	table.insert(self._items, index, item)
	self._counts[priority] = self._counts[priority] + 1
	self.Count = self.Count + 1

	if self._first > priority then
		self._first = priority
	end
	debug.profileend()
end

function PriorityQueue:Peek()
	return self._items[1]
end

function PriorityQueue:DequeueFirst()
	debug.profilebegin("PriorityQueue:DequeueFirst")
	local item = self:Peek()
	local itemPriority = self._first

	self._counts[itemPriority] = self._counts[itemPriority] - 1
	self.Count = self.Count - 1

	table.remove(self._items, 1)
	debug.profileend()

	return item
end

return PriorityQueue
