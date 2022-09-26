/**
 * Functional interface base dynamically compiled via dynamic proxy
 */
component accessors="true" extends="coldbox.system.async.proxies.BaseProxy"{

	/**
	 * Ability to load the context into the running thread
	 */
	function loadContext(){
		// Only load it, if in a streamed thread.
		if( inStreamThread() ){
			super.loadContext();
		} // end if in stream thread
	}

	/**
	 * Ability to unload the context out of the running thread
	 */
	function unLoadContext(){
		// Only unload it, if in a streamed thread.
		if( inStreamThread() ){
			super.unloadContext();
		} // end if in stream thread
	}

	/**
	* Check if your are using the fork join pool or cfthread.
	*/
	boolean function inStreamThread(){
		return ( findNoCase( "ForkJoinPool", getThreadName() ) NEQ 0 );
	}

}
