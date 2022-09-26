component extends="coldbox.system.testing.BaseTestCase" {

	function run(){
		describe( "CBStreams", function(){
			beforeEach( function( currentSpec ){
				setup();
			} );

			it( "can use register the 'stream' helper method", function(){
				var event = get( route = "/main/index", params = {} );
				expect( event.getREnderedContent() ).notToBeEmpty();
			} );

			it( "can use register the 'streamBuilder' helper method", function(){
				var event = get( route = "/main/builder", params = {} );
				expect( event.getHandlerResults() ).toHaveLength( 3 );
			} );
		} );
	}

}
