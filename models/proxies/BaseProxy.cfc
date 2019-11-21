/**
 * Functional interface base dynamically compiled via dynamic proxy
 */
component accessors="true"{

	/**
	 * The target function to be applied via dynamic proxy to the required Java interface(s)
	 */
	property name="target";

    /**
     * Constructor
     *
     * @target The target function to be applied via dynamic proxy to the required Java interface(s)
     */
    function init( required target ){
    	
		// Store target closure/lambda
		variables.target 				= arguments.target;
		variables.System 				= createObject( "java", "java.lang.System" );
		variables.Thread 				= createObject( "java", "java.lang.Thread" );
		variables.UUID 					= createUUID();

		// Preapre for parallel executions to enable the right fusion context
		if( server.keyExists( "lucee") ){
			variables.cfContext = getCFMLContext().getApplicationContext();
			variables.pageContext = getCFMLContext();
		} else {
			variables.fusionContextStatic = createObject( 'java', 'coldfusion.filter.FusionContext' );
		    variables.originalFusionContext = fusionContextStatic.getCurrent();
		    variables.originalPageContext = getCFMLContext();
			variables.originalPage = variables.originalPageContext.getPage();
			
			//out( "==> Storing contexts for thread: #getCurrentThread().toString()#." );
		}

        return this;
	}

	/**
	 * Ability to load the context into the running thread
	 */
	function loadContext(){
		// Only load it, if in a streamed thread.
		if( inStreamThread() ){

			//out( "==> Context NOT loaded for thread: #getCurrentThread().toString()# loading it..." );

			// Lucee vs Adobe Implementations
			if( server.keyExists( "lucee" ) ){
				getCFMLContext().setApplicationContext( variables.cfContext );
			} else {
				var fusionContext = variables.originalFusionContext.clone();
				var pageContext = variables.originalPageContext.clone();
				pageContext.resetLocalScopes();
				var page = variables.originalPage._clone();
				page.pageContext = pageContext;
				fusionContext.parent = page;
			
				variables.fusionContextStatic.setCurrent( fusionContext );
				fusionContext.pageContext = pageContext;
				pageContext.setFusionContext( fusionContext );
				pageContext.initializeWith( page, pageContext, pageContext.getVariableScope() );		
			}

		} // end if in stream thread
	}

	/**
	 * Ability to unload the context out of the running thread
	 */
	function unLoadContext(){
		// Only unload it, if in a streamed thread.
		if( inStreamThread() ){

			//out( "==> Removing context for thread: #getCurrentThread().toString()#." );

			// Lucee vs Adobe Implementations
			if( server.keyExists( "lucee" ) ){
				// Nothing right now
			} else {
			   variables.fusionContextStatic.setCurrent( javaCast( 'null', '' ) );
			}

		} // end if in stream thread
	}

	/**
	 * This function is used for the engine to compile the page context bif into the page scope
	 */
	function getCFMLContext(){
		return getPageContext();
	}

	/**
	* Check if you are in cfthread or not for any CFML Engine
	*/
	boolean function inStreamThread(){
		return ( findNoCase( "fork", getThreadName() ) NEQ 0 );
	}

	/**
	 * Get the current thread instance
	 *
	 * @return java.lang.Thread
	 */
	function getCurrentThread(){
		return variables.Thread.currentThread();
	}

	/**
	 * Get the current Thread name
	 *
	 * @text
	 */
	function getThreadName(){
		return getCurrentThread().getName();
	}

	/**
	 * Our helper for debugging, else all is in vain
	 *
	 * @var
	 */
	function out( required var ){
		variables.System.out.printLn( arguments.var.toString() );
	}

	/**
	 * Error helper for debugging, else all is in vain
	 *
	 * @var
	 */
	function err( required var ){
		variables.System.err.printLn( arguments.var.toString() );
	}


	/**
	 * Engine-specific lock name. For Adobe, lock is shared for this CFC instance.  On Lucee, it is random (i.e. not locked).
	 * This singlethreading on Adobe is to workaround a thread safety issue in the PageContext that needs fixed.
	 * Ammend this check once Adobe fixes this in a later update
	 */
	function getConcurrentEngineLockName(){
		if( server.keyExists( "lucee") ){
			return createUUID();
		} else {
			return variables.UUID;
		}		
	}

}