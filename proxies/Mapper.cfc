component{ 

    /**
     * Constructor
     *
     * @supplier The lambda or closure that will supply the elements
     */
    function init( required mapper ){
        variables.target = arguments.mapper;
        return this;
    }

    /**
     * Represents a function that accepts one argument and produces a result. 
     * See https://docs.oracle.com/javase/8/docs/api/java/util/function/Function.html
     */
    function apply( required element ){
        return variables.target( element );
    }
}