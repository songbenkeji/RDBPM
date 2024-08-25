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
        Output_Script = Output_Path "rdbpmsqllist_detail.sh" ;

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
### Check "connection-d"
$3 ~ /^connection-id/ {

    # 
    Script_Flag = 1.0 ;

    # Next Line
    next ;

}

### Set Value
Script_Flag == 1.0 {

    time            = $1 ;
    connection_id   = $2 ;

    Script_Flag = 2.0 ;

}

### Output Header
Script_Flag == 2.0 {

    if( Header_Script != "ON" ) {
        print "#/usr/bin/bash" > Output_Script ;
        Header_Script = "ON" ;
    }

    printf "rdbpmsqllist -t %s -c %s -w -d `pwd` >> rdbpmsqllist_detail.sql", time, connection_id >> Output_Script ;
    Script_Flag = 1.0 ;

    next ;

}