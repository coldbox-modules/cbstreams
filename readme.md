# CB Streams

Welcome to the wonderful world of Java Streams ported for the CFML world!

> One of the major new features in Java 8 is the introduction of the stream functionality – java.util.stream – which contains classes for processing sequences of elements.

The beauty of streams is that the elements in a stream are processed and passed across the processing pipeline. Unlike traditional CFML functions like `map(), reduce() and filter()` which create completely new collections until all items in the pipeline are processed.  With streams, the elements are streamed across the pipeline to increase efficiency and performance.

You can also leverage streams in parallel for parallel execution and take it further with concurrent programming.

```js
// Lucee 5 lambdas 

streamBuilder.new( "d2", "a2", "b1", "b3", "c" )
    .map( (s) => {
        writedump( "map: " + s );
        return s.ucase();
    } )
    .filter( (s) => {
        writedump( "filter: " + s );
        return s.startsWith( "A" );
    } )
    .forEach( (s) => {
        writedump( "forEach: " + s );
    } );
```
The output is in this order.  Note how the `map()`, `filter()`, and `forEach()` are running simultaneously!
```
map:     d2
filter:  D2
map:     a2
filter:  A2
forEach: A2
map:     b1
filter:  B1
map:     b3
filter:  B3
map:     c
filter:  C

```

## Installation

To install `cbstreams`, you need [CommandBox](https://www.ortussolutions.com/products/commandbox/) :rocket:

Once you have that set-up, just run `box install cbstreams` in your shell and :boom:

You're now ready to leverage streams!

## Dr. Venkat Subramaniam - The Real Powerhouse in Java 8

<iframe width="560" height="315" src="https://www.youtube.com/embed/HVID35J7h_I" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

## In-Depth Tutorial

These tutorials on Java Streams are fantastic. We encourage you to read them to see the power of streams. You can also find the `cbstreams` API Docs to be a great source of information: [http://apidocs.ortussolutions.com/#/coldbox-modules/cbstreams](http://apidocs.ortussolutions.com/#/coldbox-modules/cbstreams)

- http://winterbe.com/posts/2014/07/31/java8-stream-tutorial-examples/
- http://www.baeldung.com/java-8-streams-introduction
- http://www.baeldung.com/java-8-streams

## Usage

In order to start working with streams you must leverage WireBox and inject `StreamBuilder@cbstreams`.  This factory has two methods for your streaming pleasure:

- `new( any collection="", isNumeric=false, predicate=""  )` - Returns a new `Stream.cfc` according to passed arguments
- `builder()` - Returns a Stream Builder that maps to the `Builder.cfc` so you can build a stream manually.

We encourage you to learn our [API Docs](http://apidocs.ortussolutions.com/#/coldbox-modules/cbstreams) to see how to interact with streams.  We try our best to map static Java types to loose typed ColdFusion types. If you find anything that doesn't work, please create issues here: [Issues](https://github.com/coldbox-modules/cbstreams/issues)

********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
#### HONOR GOES TO GOD ABOVE ALL
Because of His grace, this project exists. If you don't like this, then don't read it, its not for you.

>"Therefore being justified by faith, we have peace with God through our Lord Jesus Christ:
By whom also we have access by faith into this grace wherein we stand, and rejoice in hope of the glory of God.
And not only so, but we glory in tribulations also: knowing that tribulation worketh patience;
And patience, experience; and experience, hope:
And hope maketh not ashamed; because the love of God is shed abroad in our hearts by the 
Holy Ghost which is given unto us. ." Romans 5:5

### THE DAILY BREAD
 > "I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12
