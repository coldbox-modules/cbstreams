component extends="testbox.system.BaseSpec"{

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
	}

	function afterAll(){
	}

/*********************************** BDD SUITES ***********************************/

	function run(){

		describe( "CB Streams", function(){

			beforeEach(function( currentSpec ){
			});

			story( "I can initialize a stream with many data types", function(){
				given( "nothing to the constructor", function(){
					then( "it should build an empty stream", function(){
						var stream = new cbstreams.Stream();
						expect( stream.count() ).toBe( 0 );
					});
				});

				given( "a list", function(){
					then( "it should build a list stream", function(){
						var stream = new cbstreams.Stream( "1,2,3" );
						expect( stream.count() ).toBe( 3 );
					});
				});

				given( "an array", function(){
					then( "it should build an array stream", function(){
						var stream = new cbstreams.Stream( [1,2,3] );
						expect( stream.count() ).toBe( 3 );
					});
				});

				given( "a struct", function(){
					then( "it should build a collection stream", function(){
						var stream = new cbstreams.Stream( {
							name = "luis majano",
							age = 40
						} );
						expect( stream.count() ).toBe( 2 );
					});
				});
			});

			story( "I can generate streams from different providers", function(){
				given( "a sequential stream using the `of` method", function(){
					then( "an ordered stream will be created", function(){
						var stream = new cbstreams.Stream().of( "1", "2", "3" );
						expect( stream.count() ).toBe( 3 );
					} );
				} );

				given( 
					skip=!server.keyExists( "lucee" ), 
					given="a string", 
					body=function(){
					then( "it can create a character stream", function(){
						var stream = new cbstreams.Stream().ofChars( "luis" );
						expect( stream.count() ).toBe( 4 );
					} );
				} );

				given( "a file path", function(){
					then( "an stream of the file lines will be created", function(){
						var stream = new cbstreams.Stream().ofFile( expandPath( "/cbstreams/box.json" ) );
						expect( stream.findFirst() ).toBe( "{" );
					} );
				} );
			});

			story( "I can generate streams from ranges", function(){
				given( "An open range of 1-4", function(){
					then( "a stream of 3 will be created", function(){
						var stream = new cbstreams.Stream().range( 1, 4 );
						expect( stream.count() ).toBe( 3 );
					});
				});
				given( "A closed range of 1-4", function(){
					then( "a stream of 4 will be created", function(){
						var stream = new cbstreams.Stream().rangeClosed( 1, 4 );
						expect( stream.count() ).toBe( 4 );
					});
				});
			});

			story( "I can limit streams", function(){
				given( "a discrete stream", function(){
					then( "it can be limited", function(){
						var stream = new cbstreams.Stream()
							.range( 1, 4 )
							.limit( 1 );
						expect( stream.count() ).toBe( 1 );
					} );
				} );
			} );

			story( "I can distinct streams", function(){
				given( "a repetitive stream", function(){
					then( "it can be returned in a distinct manner", function(){
						var stream = new cbstreams.Stream( "1,1,1" ).distinct();
						expect( stream.count() ).toBe( 1 );
					} );
				} );
			} );

			story( "I want to build native cf structs from collection entry sets", function(){
				given( "a struct as input to a stream", function(){
					then( "I can get a key/value representation", function(){
						var stream = new cbstreams.Stream( {
							name = "luis majano",
							age = 40
						} );
						var r = stream.findFirst();
						expect( r ).toBeStruct();
					} );
				} );
			} );

			story( "I can skip stream elements", function(){
				given( "a stream with a skip() call", function(){
					then( "it will return only the non-skipped elements", function(){
						var stream = new cbstreams.Stream( "1,2,3" ).skip( 1 );
						expect( stream.count() ).toBe( 2 );
					} );
				} );
			} );

			story( "I can leverage map functions", function(){
				given( "a stream with a map() call", function(){
					then( "it will transform the elements", function(){
						var stream = new cbstreams.Stream( "abc1,abc2,abc3" );

						var r = stream.skip( 1 )
							.map( function( element ){
								return element.substring( 0, 3 );
							} )
							.sorted()
							.count();

						writeDump( var=r );
						writeDump( var=stream.toArray() );
					} );
				} );
			} );

		});

	}

}