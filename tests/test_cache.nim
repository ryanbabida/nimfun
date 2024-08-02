import std/options, unittest

import cacheserver

test "can create a new cache":
  var cache = newCache[string, int]()
  check(cache != nil)

test "can add and get an entry":
  var cache = newCache[string, int]()
  cache.add("key1", 1)
  var found = cache.get("key1")
  check(found.isSome)
  check(found.get() == 1)

test "no entry found":
  var cache = newCache[string, int]()
  var found = cache.get("key1")
  check(found.isNone)
