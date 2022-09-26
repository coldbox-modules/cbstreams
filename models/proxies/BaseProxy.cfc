/**
 * This base proxy class inherits from the core ColdBox Base Proxy so we can tap into
 * each engine's approach to asynchronicity.  This class decorates or adds more tooling
 * so stream threads can have more power.
 */
component accessors="true" extends="coldbox.system.async.proxies.BaseProxy" {

	/**
	 * Check if you are in cfthread or not for any CFML Engine
	 */
	boolean function inStreamThread(){
		return ( findNoCase( "fork", getThreadName() ) NEQ 0 );
	}

}
