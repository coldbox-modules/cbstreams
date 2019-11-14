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
		variables.loadedContextHashCode = "";
		variables.System 				= createObject( "java", "java.lang.System" );
		variables.Thread 				= createObject( "java", "java.lang.Thread" );

		// Preapre for parallel executions to enable the right fusion context
		if( server.keyExists( "lucee") ){
			variables.cfContext = getCFMLContext().getApplicationContext();
		} else {
			variables.cfContext = getCFMLContext().getFusionContext();
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
				// Get Fusion Context loaded
				var context = getCFMLContext();
				context.getFusionContext().setCurrent( variables.cfContext );
				context.setFusionContext( variables.cfContext );
			}

		} // end if in stream thread
	}

	/**
	 * Verify if context is loaded or not
	 */
	boolean function isContextLoaded(){
		return structKeyExists( request, "cbstreams-pcloaded-#getThreadName()#" );
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
	 * Out helper for debugging, else all is in vain
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

}