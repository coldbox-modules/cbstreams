/**
 * Functional interface that maps to java.util.Comparator
 * See https://docs.oracle.com/javase/8/docs/api/java/util/Comparator.html
 */
component{ 

    /**
     * Constructor
     *
     * @f Target lambda or closure
     */
    function init( required f ){
        variables.target = arguments.f;
        return this;
    }

    /**
     * Compares its two arguments for order.
     */
    function compare( o1, o2 ){
        return variables.target( arguments.o1, arguments.o2 );
    }

    function comparing(keyExtractor){}
    function comparing(keyExtractor, keyComparator){}
    function comparingDouble( keyExtractor){}
    function comparingInt(keyExtractor){}
    function comparingLong(keyExtractor){}
    function equals(Object obj){}
    function naturalOrder(){}
    function nullsFirst(comparator){}
    function nullsLast(comparator){}
    function reversed(){}
    function reverseOrder(){}
    function thenComparing(other){}
    function thenComparing(keyExtractor){}
    function thenComparing(keyExtractor, keyComparator){}
    function thenComparingDouble(keyExtractor){}
    function thenComparingInt(keyExtractor){}
    function thenComparingLong(keyExtractor){}

}