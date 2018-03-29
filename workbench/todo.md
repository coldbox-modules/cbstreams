# Todo

This is the implementation roadmap for streams:

- https://docs.oracle.com/javase/8/docs/api/java/util/stream/Stream.html#peek-java.util.function.Consumer-
- https://docs.oracle.com/javase/8/docs/api/java/util/stream/Collectors.html
- https://docs.oracle.com/javase/8/docs/api/java/util/Arrays.html

## Stream Class Implementations

√ allMatch
√ anyMatch
- builder
√ collect
√ concat
√ count
√ distinct
√ empty
√ findAny
√ findFirst
- flatMap
√ forEach
√ forEachOrdered
√ generate
√ iterate
√ limit
√ map
√ noneMatch
√ of
√ peek
√ reduce
√ reduce with seed
- reduce with accumulator and collection ( needs parallel )
√ skip
√ sorted
√ sorted with comparator
√ toArray
√ close
√ onClose
√ isParallel
√ iterator
√ parallel
√ sequential
√ spliterator
√ unordered

## Predicate Typed Streams

√ average
√ summaryStatistics
√ max
√ min

## Collectors

√ averagingInt()
√ summingInt()
√ summarizingInt()
√ groupingBy()
√ partitioningBy()
