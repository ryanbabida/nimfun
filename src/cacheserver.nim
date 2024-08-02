import std/locks
import std/options
import tables

type Cache*[K, V] = ref object
  container:  Table[K, V]
  mutex: Lock

proc newCache*[K, V](): Cache[K, V] = 
  result = new(Cache[K, V])
  result.container = initTable[K, V]()
  result.mutex.initLock()


proc add*[K, V](self: var Cache[K, V], key: K, val: V): void = 
  withLock self.mutex:
    self.container[key] = val;

proc get*[K, V](self: var Cache[K, V], key: K): Option[V]  = 
  withLock self.mutex:
    result = if self.container.hasKey(key): some(self.container[key]) else: none(V)
 