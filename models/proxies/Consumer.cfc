/**
 * Functional Interface that maps to java.util.function.Consumer
 * See https://docs.oracle.com/javase/8/docs/api/java/util/function/Consumer.html
 */
component extends="BaseProxy"{

    /**
     * Constructor
     *
     * @f The lambda or closure to be used in the <code>accept()</code> method
     */
    function init( required f ){
        super.init( arguments.f );
        return this;
    }

    /**
     * Performs this operation on the given argument.
     */
    void function accept( t ){
		loadContext();
		try {
			lock name='#getConcurrentEngineLockName()#' type="exclusive" timeout="60" {
        		variables.target( t );
        	}
        } finally {
        	unLoadContext();
        }
    }

    function andThen( after ){}

}