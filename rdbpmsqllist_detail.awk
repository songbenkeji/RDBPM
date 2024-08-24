#######################################################################
#
#######################################################################
BEGIN {

    # Set Output File Name 
    Output_Path     = "" ;      # output Path Name
    Output_Script   = "" ;      # Output Script File Name

    # Header Flag for Script
    Header_Script   = "OFF" ;   # Script Header

    # Control Flag for Script
    Script_Flag     = 0.0 ;     # Script Control Flag
    
}

#######################################################################
#
#######################################################################
END {

    printf( "\rInput-File Read Record : " NR ) ;
    printf "" ;

}

#######################################################################
#
#######################################################################
{

    # Check Line : 1
    if( FNR == 1 ) {
        Output_Path = "" ;
        iPosition = 0 ;

        # Get Path Name
        for( count = length( FILENAME ) ; count > 1 ; --count ) {
            if( substr( FILENAME, count, 1 ) == "/" ) {
                iPosition = count ;
                break ;
            }
        }

        # Set Output Path
        if( iPosition != 0 ) {
            Output_Path = substr( FILENAME, 1, iPosition ) ;
        }

        # Set Output File Name
        Output_Script = Output_Path "rdbpmsqllist_detail.awk" ;

    }

}

#######################################################################
#   
#######################################################################
/^$/ {

    # Reset Value
    time        = "" ;
    Script_Flag = 0.0 ;

    # Next Line
    next ;

}

#######################################################################
#   
#######################################################################