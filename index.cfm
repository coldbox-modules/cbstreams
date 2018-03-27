<cfscript>

    stream = new Stream().file( expandPath( "Stream.cfc" ) );
    writeDump( stream );

    // Of
    stream = new Stream().of( "luis" );
    writeDump( stream );

    // empty stream
    stream = new Stream();
    writedump( stream );

    // array stream
    stream = new Stream( [1,2,3] );
    writedump( stream );

    // list stream
    stream = new Stream( "1,2,3" );
    writedump( stream );

    // Struct stream
    stream = new Stream( {
        name = "luis majano",
        age = 40,
        when = now()
    } );
    writedump( stream );

    
    
    stream = createObject( "java", "java.util.stream.Stream" );
    //writedump( stream.of( 1 ).toArray() );



    
</cfscript>