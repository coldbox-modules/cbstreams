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
				out = createObject( "java", "java.lang.System" ).out;
			});


			xit( "testing parallel threads", function(){

				var results = new cbstreams.models.Stream( [
					"one", "two", "three", "four", "six", "seven", "eight", "nine"
					] )
					.parallel()
					.filter( function( item ){
						try{
							out.println( "**** Filter (#arguments.item#) Thread Name: #createObject( "java", "java.lang.Thread" ).currentThread().getName()#" );
						 	return arguments.item.len() > 3;
						} catch( any e ){
							out.println( e.message );
							out.println( e.detail );
							rethrow;
						}
					} )
					//.map( function( item ){
					//	out.println( "**** Map (#arguments.item#) Thread Name: #createObject( "java", "java.lang.Thread" ).currentThread().getName()#" );
					//	return ucase( arguments.item );
					//} )
					.collect();

				expect( results ).toHaveLength( 5 );
			});

		});

	}

}