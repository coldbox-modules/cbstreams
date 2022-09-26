/**
 * Functional interface that maps to java.util.function.ToLongFunction
 * See https://docs.oracle.com/javase/8/docs/api/java/util/function/ToLongFunction.html
 */
component extends="BaseProxy" {

	/**
	 * Constructor
	 *
	 * @f a function to be applied to to the previous element to produce a new element
	 */
	function init( required f ){
		super.init( f );
		return this;
	}

	/**
	 * Functional interface for the apply functionional interface
	 */
	function applyAsLong( required value ){
		loadContext();
		try {
			lock name="#getConcurrentEngineLockName()#" type="exclusive" timeout="60" {
				return variables.target( arguments.value );
			}
		} catch ( any e ) {
			// Log it, so it doesn't go to ether
			err( "Error running toLongFunction: #e.message & e.detail#" );
			err( "Stacktrace for toLongFunction: #e.stackTrace#" );
			rethrow;
		} finally {
			unLoadContext();
		}
	}

}
