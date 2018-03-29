<cfparam name="url.version" default="0">
<cfparam name="url.path" 	default="#expandPath( "./#request.MODULE_NAME#-APIDocs" )#">
<cfscript>
	docName = "#request.MODULE_NAME#-APIDocs";
	moduleRoot 	= expandPath( "/moduleroot" );
	docbox 	= new docbox.DocBox( properties = {
		projectTitle 	= "#request.MODULE_NAME# v#url.version#",
		outputDir 		= url.path
	} );
	docbox.generate( 
		source 		= moduleRoot, 
		mapping 	= request.MODULE_NAME,
		excludes 	= "(build|test\-harness)"
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

