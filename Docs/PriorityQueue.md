The PriorityQueue class is an implementation of a [priority queue](https://en.wikipedia.org/wiki/Priority_queue). It allows you to enqueue items in the queue with varying priorities, and pull out the highest-priority item.

Items are returned in first-in-first-out order - the first item inserted into a priority queue, provided it is the lowest priority, will be returned first.

## API

### PriorityQueue.new()
Creates an empty priority queue and returns it.

### readonly int PriorityQueue.Count
The total number of items used in the priority queue. This field is technically writeable; nevertheless, **do not change this.** If changed by anything other than the priority queue, this count will no longer be accurate. The priority queue will still function even if the count is modified (so long as it remains a number value), but the Count property will be meaningless.

### void PriorityQueue:Enqueue(Variant item, number priority)
Adds `item` to the priority queue with priority `priority`.

### Variant PriorityQueue:Peek()
Returns the first element in the priority queue; does not remove it.

### Variant PriorityQueue:DequeueFirst()
Removes and returns the first element in the priority queue.

## Example
This example assumes that the priority queue module has already been loaded and assigned to the variable `PriorityQueue`.
```lua
local queue = PriorityQueue.new()
queue:Enqueue("Priority 1", 1)
queue:Enqueue("Priority 2", 2)
queue:Enqueue("Priority 1 #2", 1)

print(queue:Peek())
-- Output: Priority 1
print(queue:DequeueFirst())
-- Output: Priority 1
print(queue:DequeueFirst())
-- Output: Priority 1 #2
print(queue.Count)
-- Output: 1
print(queue:DequeueFirst())
-- Output: Priority 2
print(queue.Count)
-- Output: 0
```

## Notes

### Performance
`Enqueue` exhibits `O(n)` performance in all cases, where `n` is the number of *discrete priorities within the queue*. This means that if you have 500 items across 4 different priorities, `Enqueue` will be fast, but if you have 500 items across 500 different priorities, it will be noticeably slower.

`Peek` and `DequeueFirst` both exhibit `O(1)` performance in all cases.

### Implementation
Internally a priority queue consists of two tables: the `items` table and the `counts` table. `items` is responsible for storing the items within the queue, while `counts` stores the counts of the priorities within the queue. Consider the queue shown in the example above:
```lua
local queue = PriorityQueue.new()
queue:Enqueue("Priority 1", 1)
queue:Enqueue("Priority 2", 2)
queue:Enqueue("Priority 1 #2", 1)
```

This queue's `items` table would look like this:
```lua
{ "Priority 1", "Priority 1 #2", "Priority 2" }
```

Its `counts` table would look like this:
```lua
{ [1] = 2, [2] = 1 }
```

The `counts` table is used when inserting into the queue. When inserting with priority `p` it loops through each priority in `counts`. If the priority is less than or equal to `p` it increments the index by the number of items with that priority. In the queue above, if `Enqueue` were called with priority 2, it would find `[1] = 2` and add 2 to the index, then find `2` and add 1 to the index, giving it a total index of 4 (the index starts at 1). The item would then be inserted at index `4`.

`Peek` simply returns the item at index 1 in the `items` table. `DequeueFirst` does the same, plus some additional bookkeeping.