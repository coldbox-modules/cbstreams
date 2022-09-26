/**
 * Functional interface that maps to java.util.function.ToIntFunction
 * See https://docs.oracle.com/javase/8/docs/api/java/util/function/ToIntFunction.html
 */
component extends="BaseProxy" {

	/**
	 * Constructor
	 *
	 * @f a function to be applied to to the previous element to produce a new element
	 */
	function init( required f ){
		super.init( arguments.f );
		return this;
	}

	/**
	 * Functional interface for the apply functionional interface
	 */
	function applyAsInt( required value ){
		loadContext();
		try {
			lock name="#getConcurrentEngineLockName()#" type="exclusive" timeout="60" {
				return variables.target( arguments.value );
			}
		} catch ( any e ) {
			// Log it, so it doesn't go to ether
			err( "Error running ToIntFunction: #e.message & e.detail#" );
			err( "Stacktrace for ToIntFunction: #e.stackTrace#" );
			rethrow;
		} finally {
			unLoadContext();
		}
	}

}
