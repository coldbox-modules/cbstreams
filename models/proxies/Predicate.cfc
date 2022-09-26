/**
 * Functional Interface that maps to java.util.function.Predicate
 * See https://docs.oracle.com/javase/8/docs/api/java/util/function/Predicate.html
 */
component extends="BaseProxy" {

	/**
	 * Constructor
	 *
	 * @f The lambda or closure to be used in the <code>apply()</code> method
	 */
	function init( required f ){
		super.init( arguments.f );

		// Stupid ACF Compiler
		variables[ "and" ] = variables[ "$and" ];
		variables[ "or" ]  = variables[ "$or" ];
		this[ "and" ]      = variables[ "$and" ];
		this[ "or" ]       = variables[ "$or" ];

		return this;
	}

	/**
	 * Evaluates this predicate on the given argument.
	 *
	 * @t
	 */
	boolean function test( required t ){
		loadContext();
		try {
			lock name="#getConcurrentEngineLockName()#" type="exclusive" timeout="60" {
				return variables.target( arguments.t );
			}
		} catch ( any e ) {
			// Log it, so it doesn't go to ether
			err( "Error running Predicate: #e.message & e.detail#" );
			err( "Stacktrace for Predicate: #e.stackTrace#" );
			rethrow;
		} finally {
			unLoadContext();
		}
	}


	function isEqual( targetRef ){
	}

	function negate(){
	}

	function $and( other ){
	}
	function $or( other ){
	}

}
