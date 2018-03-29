/**
 * Functional interface that maps to java.util.function.ToDoubleFunction
 * See https://docs.oracle.com/javase/8/docs/api/java/util/function/ToDoubleFunction.html
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
     */
    function applyAsDouble( required value ){
        return variables.target( arguments.value );
    }

}