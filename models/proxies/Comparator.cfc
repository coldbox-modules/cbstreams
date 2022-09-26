/**
 * Functional interface that maps to java.util.Comparator
 * See https://docs.oracle.com/javase/8/docs/api/java/util/Comparator.html
 */
component extends="BaseProxy"{

    /**
     * Constructor
     *
     * @f Target lambda or closure
     */
    function init( required f ){
		super.init( arguments.f );
        variables[ "equals" ] = variables.isEqual;
        return this;
    }

    /**
     * Compares its two arguments for order.
     */
    function compare( o1, o2 ){
		loadContext();
		try {
			lock name='#getConcurrentEngineLockName()#' type="exclusive" timeout="60" {
     			return variables.target( arguments.o1, arguments.o2 );
     		}
        }catch ( any e ) {
			// Log it, so it doesn't go to ether
			err( "Error running Comparator: #e.message & e.detail#" );
			err( "Stacktrace for Comparator: #e.stackTrace#" );
			rethrow;
		} finally {
			unLoadContext();
		}
    }

    function comparing(keyExtractor, keyComparator){}
    function comparingDouble( keyExtractor){}
    function comparingInt(keyExtractor){}
    function comparingLong(keyExtractor){}
    function isEqual(Object obj){}
    function naturalOrder(){}
    function nullsFirst(comparator){}
    function nullsLast(comparator){}
    function reversed(){}
    function reverseOrder(){}
    function thenComparing(other){}
    function thenComparingDouble(keyExtractor){}
    function thenComparingInt(keyExtractor){}
    function thenComparingLong(keyExtractor){}

}
