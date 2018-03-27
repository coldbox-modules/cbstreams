component{ 

    /**
     * Constructor
     *
     * @f a function to be applied to to the previous element to produce a new element
     */
    function init( required f ){
        variables.target = arguments.f;
        return this;
    }

    /**
     * Functional interface for the apply functionional interface
     * See https://docs.oracle.com/javase/8/docs/api/java/util/function/Function.html#apply-T-
     */
    function apply( required target ){
        return variables.target( arguments.target );
    }
}