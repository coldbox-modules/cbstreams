/**
* Copyright 2013 Ortus Solutions, Corp
* www.ortussolutions.com
* ---
*/
component {

	// Module Properties
	this.title 				= "CB Streams";
	this.author 			= "Ortus Solutions, Corp";
	this.webURL 			= "https://github.com/ortus-solutions/cbstreams";
	this.description 		= "Stream support for cfml";
	// CF Mapping
	this.cfmapping			= "cbstreams";
	this.modelNamespace 	= "cbstreams";
	this.autoMapModels		= false;
	// Module Dependencies That Must Be Loaded First, use internal names or aliases
	this.dependencies		= [];

	/**
	* Configure this module
	*/
	function configure(){
	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
	}

}