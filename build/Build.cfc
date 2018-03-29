component{

    function init(){
        // Setup Pathing
        variables.cwd           = getCWD().reReplace( "\.$", "" );
        variables.artifactsDir  = cwd & "/.artifacts";
        variables.buildDir      = cwd & "/.tmp";
        variables.apiDocsURL    = "http://localhost:60299/apidocs/";
        variables.testRunner    = "http://localhost:60299/tests/runner.cfm";
        // Source Excludes
        variables.excludes      = [
            ".gitignore",
            ".travis.yml",
            ".artifacts",
            ".tmp",
            "build",
            "test-harness",
            ".DS_Store",
            ".git"
        ];

        // Cleanup + Init Build Directories
        [ variables.buildDir, variables.artifactsDir ].each( function( item ){
            if( directoryExists( item ) ){
                directoryDelete( item, true );
            }
            // Create directories
            directoryCreate( item, true, true );
        } );

        return this;
    }

    /**
     * Run the build process
     * 
     * @projectName The project name used for resources and slugs
     * @version The version you are building
     * @buldID The build identifier
     * @branch The branch you are building
     */
    function run( 
        required projectName, 
        version="1.0.0", 
        buildID=createUUID(),
        branch="development"
    ){

        // Tests First, if they fail then exit
        print.blueLine( "Testing the package, please wait..." ).toConsole();
        command( 'testbox run' )
            .params( 
                runner = variables.testRunner,
                verbose = true
            )
            .run();
        // Check Exit Code?
        if( getExitCode() ){
            return error( "Cannot continue building, tests failed!" );
        }

        // Build Notice
        print.line()
            .boldMagentaLine( "Building #arguments.projectName# v#arguments.version#+#arguments.buildID# from #cwd# using the #arguments.branch# branch." )
            .toConsole();

        // Prepare exports directory
        variables.exportsDir = variables.artifactsDir & "/#projectName#/#arguments.version#";
        directoryCreate( variables.exportsDir, true, true );

        // Project Build Dir
        variables.projectBuildDir = variables.buildDir & "/#projectName#";
        directoryCreate( variables.projectBuildDir, true, true );

        // Copy source
        print.blueLine( "Copying source to build folder..." ).toConsole();
        copy( variables.cwd, variables.projectBuildDir );

        // Create build ID
        fileWrite( "#variables.projectBuildDir#/#projectName#-#version#+#buildID#", "Built with love on #dateTimeFormat( now(), "full")#" );

        // Updating Placeholders
        print.greenLine( "Updating version identifier to #arguments.version#" ).toConsole();
        command( 'tokenReplace' )
            .params( 
                path = "/#variables.projectBuildDir#/**",
                token = "@build.version@",
                replacement = arguments.version
            )
            .run();
        
        print.greenLine( "Updating build identifier to #arguments.buildID#" ).toConsole();
        command( 'tokenReplace' )
            .params( 
                path = "/#variables.projectBuildDir#/**",
                token = ( arguments.branch == "master" ? "@build.number@" : "+@build.number@" ),
                replacement = ( arguments.branch == "master" ? arguments.buildID : "-snapshot" )
            )
            .run();

        // Generate Docs
        print.greenLine( "Generating API Docs, please wait..." ).toConsole();
        directoryCreate( variables.buildDir & "/apidocs", true, true );
        cfhttp( 
            url="#variables.apiDocsURL#index.cfm?version=#arguments.version#&path=#URLEncodedFormat( variables.buildDir & "/apidocs" )#",
            result="local.docsOutput" 
        );
        
        if( local.docsOutput.keyExists( "error_detail" ) ){
            return error( "Error producing Docs: #local.docsOutput.toString()#" );
        }
        print.greenLine( "API Docs produced at #variables.buildDir & '/apidocs'#" )
            .cyanLine( "#local.docsOutput.fileContent#" )
            .line()
            .toConsole();
        
        // zip it up
        var destination = "#variables.exportsDir#/#projectName#-#version#.zip";
        print.greenLine( "Zipping code to #destination#" ).toConsole();
        cfzip( 
            action="zip",
            file="#destination#",
            source="#variables.projectBuildDir#",
            overwrite=true,
            recurse=true
        );
        var destination = "#variables.exportsDir#/#projectName#-docs-#version#.zip";
        print.greenLine( "Zipping apidocs to #destination#" ).toConsole();
        cfzip( 
            action="zip",
            file="#destination#",
            source="#variables.buildDir#/apidocs",
            overwrite=true,
            recurse=true
        );

        // checksums
        print.greenLine( "Building checksums" ).toConsole();
        command( 'checksum' )
            .params( path = '#variables.exportsDir#/*.zip', algorithm = 'SHA-512', extension="sha512", write=true )
            .run();
        command( 'checksum' )
            .params( path = '#variables.exportsDir#/*.zip', algorithm = 'md5', extension="md5", write=true )
            .run();
        
        // Copy box.json for convenience
        fileCopy( "#variables.projectBuildDir#/box.json", variables.exportsDir );

        print.line()
            .boldMagentaLine( "Build Process is done! Enjoy your build!" )
            .toConsole();
    }

    /**
     * DirectoryCopy is broken in lucee
     */
    private function copy( src, target, recurse=true ){
        // process paths with excludes
        directoryList( src, false, "path", function( path ){
            var isExcluded = false;
            variables.excludes.each( function( item ){
                if( path.replaceNoCase( variables.cwd, "", "all" ).findNoCase( item ) ){
                    isExcluded = true;
                }
            } );
            return !isExcluded;
        }).each( function( item ){
            // Copy to target
            if( fileExists( item ) ){
                print.blueLine( "Copying #item#" ).toConsole();
                fileCopy( item, target );
            } else {
                print.greenLine( "Copying directory #item#" ).toConsole();
                directoryCopy( item, target & "/" & item.replace( src, "" ), true );
            }
        } );
    }


    /**
	 * Gets the last Exit code to be used
	 **/
	function getExitCode() {
		return (createObject( 'java', 'java.lang.System' ).getProperty( 'cfml.cli.exitCode' ) ?: 0);
		
	}

}