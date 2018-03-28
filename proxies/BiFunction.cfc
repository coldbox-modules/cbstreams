/**
 * Functional interface that maps to java.util.function.BiFunction
 * See https://docs.oracle.com/javase/8/docs/api/java/util/function/BiFunction.html
 */
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
     * See https://docs.oracle.com/javase/8/docs/api/java/util/function/BiFunction.html#apply-T-U-
     */
    function apply( required previous, required item ){
        return variables.target( arguments.previous, arguments.item );
    }

    function andThen( required after ){}

}