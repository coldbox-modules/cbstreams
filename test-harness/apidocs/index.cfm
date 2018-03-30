<cfparam name="url.version" default="0">
<cfparam name="url.path" 	default="#expandPath( "./#request.MODULE_NAME#-APIDocs" )#">
<cfscript>
	docName = "#request.MODULE_NAME#-APIDocs";
	
	docbox 	= new docbox.DocBox( properties = {
		projectTitle 	= "#request.MODULE_NAME# v#url.version#",
		outputDir 		= url.path
	} );

	docbox.generate( 
		source 		= expandPath( "/#request.MODULE_NAME#" ),
		mapping 	= request.MODULE_NAME,
		excludes 	= "(.artifacts|.tmp|build|test\-harness)"
	);
</cfscript>

<!---
<cfzip action="zip" file="#expandPath('.')#/#docname#.zip" source="#expandPath( docName )#" overwrite="true" recurse="yes">
<cffile action="move" source="#expandPath('.')#/#docname#.zip" destination="#url.path#">
--->

<cfoutput>
<h1>Done!</h1>
<a href="#docName#/index.html">Go to Docs!</a>
</cfoutput>

