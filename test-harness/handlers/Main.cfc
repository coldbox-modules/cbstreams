component{

	variables.people = [
		{ "id"=1, "name" = "stream", "color"="blue" },
		{ "id"=2, "name" = "builder", "color"="red" },
		{ "id"=3, "name" = "joe", "color"="green" }
	];

	function index( event, rc, prc ){
		return stream( people )
			.filter( function( item ){
				return item.color eq "red";
			} )
			.map( function( item ){
				return item.name;
			} )
			.findFirst()
			.get();
	}

	function builder( event, rc, prc ){
		var builder = streamBuilder();
		people.each( function( item ){
			builder.add( item );
		} );
		return builder.build().toArray();
	}

}
