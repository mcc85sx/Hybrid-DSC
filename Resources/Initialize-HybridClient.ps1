#\\- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -//#
#// /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ \\#
#\\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ //#
#// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \\#
#\\                                                                                                 //#
#// <@[ Script-Initialization ]@>      "Script Magistration by Michael C. 'Boss Mode' Cook Sr."     \\#
#\\                                                                                                 //#
#//                 [ Secure Digits Plus LLC | Hybrid ] [ Desired State Controller ]                \\#
#\\                                                                                                 //#
#//        [ https://www.securedigitsplus.com | Server/Client | Seedling/Spawning Script ]          \\#
#\\                                                                                                 //#
#//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\\#
#\\ - - [ Initialize-Hybrid ] - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
    
    Function Initialize-Hybrid {

    $fs           = " // "
    $bs           = " \\ "

    $RootVar_ini  = "$home\Desktop\RootVar.ini"
                
    If ( ( Test-Path $RootVar_ini ) -eq $True ) 
    { 
        $r = @( Get-Content $RootVar_ini -EA 0 )
        
        If ( $? -eq $True )
        {
            echo "[+] Variables Loaded"

            Remove-Item $RootVar_ini

            Start-Sleep `
                -Seconds 3

            Remove-Item "$home\Desktop\Initialize-Hybrid.ps1" -EA 0 -Force
            Remove-Item "$home\Desktop\Initialize-HybridClient.ps1" -EA 0 -Force
        }

        Else
        {
            echo "[!] Variables Not Loaded, Exiting"
            
            Start-Sleep `
                -Seconds 3
            
            Exit
        }
    }

    # - - [ Load Wrapper Modules ]- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
    
    Function Wrap-Top { Echo @( " " * 108 ; $fs + "_-" * 52 + $bs ; $bs + " -" * 52 + $fs ) }
    
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
    
    Function Wrap-Bot { Echo @( $bs + " -" * 52 + $fs ; $fs + "_-" * 52 + $bs ; " " * 108 ) }
    
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
    
    Function Wrap-Out { Echo ( $fs + "  " * 52 + $bs ) }
    
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
    
    Function Wrap-In  { Echo ( $bs + "  " * 52 + $fs ) }
    
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
    
    Function Wrap-Title
    { 
        [ CmdLetBinding () ] Param ( 

            [ Parameter ( Position = 0 , Mandatory , ValueFromPipeline = $True ) ]

                [ String ] $Title )

        $th = "[ $Title ]"
        $y  = $th.length
        $x  = 104 - $y

        if ( $x % 4 -ge 2 ) 
        {
            $x  = $x - 2
            $y  = $th.replace("["," [ ")
            $th = $y
        }

        if ( $x % 2 -ge 1 ) 
        {
            $x  = $x - 1
            $y  = $th.replace("]"," ]")
            $th = $y
            $z  = 0 
        }

        if ( $z = 1 ) 
        { 
            $z = " -" 
        }

        else
        {
            $z = "- "
        }

        $y = $z * ( $x / 4 )
        $x = "- " * ( $x / 4 )
        
        Wrap-Top
        echo ( $fs + $x + $th + $y + $bs )
    }

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
    
    Function Wrap-Function 
    {
        [ CmdLetBinding () ] Param ( 

            [ Parameter ( Position = 0 , Mandatory , ValueFromPipeline = $True ) ]

                [ String ] $ID )

        $th = "[ $ID ]"
        $y = $th.length
        $x = 104 - $y

        if ( $x % 4 -ge 2 ) 
        {
            $x = $x - 2
            $y = $th.replace("["," [ ")
            $th = $y
        }

        if ( $x % 2 -ge 1 ) 
        {
            $x = $x - 1
            $y = $th.replace("]"," ]")
            $th = $y
            $z = 0 
        }

        if ( $z = 1 ) 
        { 
            $z = " -" 
        }

        else
        {
            $z = "- "
        }

        $y = $z * ( $x / 4 )
        $x = "- " * ( $x / 4 )
        
        Wrap-Top
        echo ( $fs + $x + $th + $y + $bs )
        Wrap-Bot
    }

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

    Function Wrap-Section
    {
        [ CmdLetBinding () ] Param(

            [Parameter ( Position = 0 , Mandatory , ValueFromPipeline = $True ) ]

                [ String ] $Section )
    
        $z = $Section
        $x = " " * 10
        $y = " " * ( 94 - $z.Length )

        Wrap-In
        echo ( $fs + $x + $z + $y + $bs )
        Wrap-In
    }

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

    Function Wrap-ItemIn
    {
        [ CmdLetBinding () ] Param ( 

            [ Parameter ( Position = 0 , Mandatory , ValueFromPipeline = $True ) ]

                [ String ] $Type,

            [ Parameter ( Position = 1 , Mandatory , ValueFromPipeline = $True ) ]

                [ String ] $Info )
        
        $x = " " * ( 23 - $Type.Length ) 
        $y = " " * ( 78 - $Info.Length )

        echo ( $bs + $x + $Type + " : " + $Info + $y + $fs )
    }

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

    Function Wrap-ItemOut
    {
        [ CmdLetBinding () ] Param (

            [ Parameter ( Position = 0 , Mandatory , ValueFromPipeline = $True ) ]

                [ String ] $Type,

            [ Parameter ( Position = 1 , Mandatory , ValueFromPipeline = $True ) ]

                [ String ] $Info )
        
        $x = " " * ( 23 - $Type.Length ) 
        $y = " " * ( 78 - $Info.Length )

        echo ( $fs + $x + $Type + " : " + $Info + $y + $bs )
    }

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

    Function Wrap-Array
    {
        [ CmdletBinding () ] Param (

            [ Parameter ( Position = 0 , Mandatory , ValueFromPipeline = $True ) ]

                [ Array ] $Block )
        
        Wrap-Top
        echo $Block
        Wrap-Bot
    }

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

    Function Wrap-Action 
    {
        [ CmdletBinding () ] Param (

            [ Parameter ( Position = 0 , Mandatory , ValueFromPipeline = $True ) ]

                [ String ] $Type,
    
            [ Parameter ( Position = 1 , Mandatory , ValueFromPipeline = $True ) ]

                [ String ] $Info )

        $x = " " * ( 23 - $Type.Length )
        $y = " " * ( 78 - $Info.Length )
        
        Wrap-Top
        echo ( $fs + $x + $Type +" : " + $Info + $y + $bs )
        Wrap-Bot
        
    }

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

    Wrap-Function -ID "Initialize-Hybrid"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
     
    # Module that exports hashtables with keys into INI file (Modified a little, from TechNet)
    Function Export-Ini {
    [CmdletBinding()]
        Param([Switch]$Append,
        
        [ValidateSet("Unicode","UTF7","UTF8","UTF32","ASCII","BigEndianUnicode","Default","OEM")]
        [Parameter()][String]$Encoding,
        
        [ValidateNotNullOrEmpty()][ValidatePattern('^([a-zA-Z]\:)?.+\.ini$')]
        [Parameter(Mandatory=$True)][String]$FilePath,
        
        [Switch]$Force,
        
        [ValidateNotNullOrEmpty()]
        [Parameter(ValueFromPipeline=$True,Mandatory=$True)][Hashtable]$InputObject,
        
        [Switch]$Passthru)

        Begin 
        { Wrap-Action -Type "Processing" -Info "$($MyInvocation.MyCommand.Name)" }
        
        Process 
        { 
            Wrap-Action -Type "Writing" -Info "$($FilePath)"
            If ($Append) { $Outfile = Get-Item $FilePath }  
            Else { $OutFile = New-Item -ItemType File -Path $FilePath -Force:$Force }
            If (!($OutFile)) { Wrap-Action -Type "Exception" -Info "Unable to access file" }
            ForEach ($q in $InputObject.Keys)
            { 
                If (!($($InputObject[$q].GetType().Name) -eq "Hashtable")) 
                { 
                    Wrap-Action -Type "Key" -Info "[+] $q"
                    Add-Content -Path $OutFile -Value "$q=$($InputObject[$q])" -Encoding $Encoding }
                Else 
                {
                    Wrap-Action -Type "Section" -Info "[+] $q"
                    Add-Content -Path $OutFile -Value "[$q]" -Encoding $Encoding }

                ForEach ($z in $($InputObject[$q].Keys | Sort-Object))
                { 
                    If ($z -Match "^Comment[\d]+") 
                    {  
                        Wrap-Action -Type "Property" -Info "[+] $z"
                        Add-Content -Path $OutFile -Value "$($InputObject[$q][$j])" -Encoding $Encoding }
                    
                    Else
                    {  
                        Wrap-Action -Type "Key" -Info "[+] $z"
                        Add-Content -Path $OutFile -Value "$z=$($InputObject[$q][$z])" -Encoding $Encoding }
                }
            
            Add-Content -Path $OutFile -Value "" -Encoding $Encoding }

            Wrap-Action -Type "Completed" -Info "$($MyInvocation.MyCommand.Name): $Path"
            If ($PassThru) { Return $OutFile }
        }
         
        End { Wrap-Action -Type "Exiting" -Info "$($MyInvocation.MyCommand.Name)" } 
    }

    Function Display-TrueColors { $flag = @(
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
    "$fs                                                                                                        $bs";
    "$bs       ________________________________________________________________________________________         $fs";
    "$fs      //                                     |                                                \\        $bs";
    "$bs      \\   *     *     *     *     *     *   - - - - - - - - - - - - - - - - - - - - - - - - -//        $fs";
    "$fs      //      *     *     *     *     *      |   [   S E C U R E  D I G I T S  P L U S    ]   \\        $bs";
    "$bs      \\   *     *     *     *     *     *    - - - - - - - - - - - - - - - - - - - - - - - - //        $fs";
    "$fs      //      *     *     *     *     *      |   [   https://www.securedigitsplus.com     ]   \\        $bs";
    "$bs      \\   *     *     *     *     *     *   - - - - - - - - - - - - - - - - - - - - - - - - -//        $fs";
    "$fs      //      *     *     *     *     *      |                                                \\        $bs";
    "$bs      \\   *     *     *     *     *     *    - - - - - - - - - - - - - - - - - - - - - - - - //        $fs";
    "$fs      //      *     *     *     *     *      |          You are choosing to restore,          \\        $bs";
    "$bs      \\   *     *     *     *     *     *   - - - - - - - - - - - - - - - - - - - - - - - - -//        $fs";
    "$fs      //      *     *     *     *     *      |       'A Heightened Sense of Security'         \\        $bs";
    "$bs      \\   *     *     *     *     *     *    - - - - - - - - - - - - - - - - - - - - - - - - //        $fs";
    "$fs      //                                     |                                                \\        $bs";
    "$bs      \\ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -//        $fs";
    "$fs      //     [ The Constitution of the United States of America | Pledge of Alligience ]      \\        $bs";
    "$bs      \\- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //        $fs";
    "$fs      //                                                                                      \\        $bs";
    "$bs      \\ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -//        $fs";
    "$fs      //          I pledge allegiance to the flag of the United States of America.            \\        $bs";
    "$bs      \\- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //        $fs";
    "$fs      //     And to the Republic, for which it stands. One Nation, Under God, Indivisible     \\        $bs";
    "$bs      \\ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -//        $fs";
    "$fs      //                      With Liberty . . . and Justice for [ ALL ].                     \\        $bs";
    "$bs      \\- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //        $fs";
    "$fs      //                                                                                      \\        $bs";
    "$bs      \\ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -//        $fs";
    "$fs      //   What you are seeing is the beginning, of 'no stone unturned' security provisions.  \\        $bs";
    "$bs      \\______________________________________________________________________________________//        $fs";
    "$fs                                                                                                        $bs";
    "$bs      Special Thanks to Michael Niehaus, Damien Van Robaeys, and Shane Young for the inspiration        $fs";
    "$fs      and the education to design this software solution. At this time, this product is far from        $bs";
    "$bs      complete. However.. what it achieves is a 100% purity of your operating system deployment.        $fs";
    "$fs                                                                                                        $bs";)
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
    Wrap-Array -Block $flag ; Read-Host "Press Enter to Continue" }

    Function Display-Logo { $logo = @(
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
    " //- - - - - - - - - - - - -                                                     - - - - - - - - - - - - - - \\ ";
    " \\ - - - - - - - - - - - -                   {_______________}                   - - - - - - - - - - - - - -// ";
    " //- - - - - - - - - - - -     {__________{ _ _]             [_ _ }__________}     - - - - - - - - - - - - - \\ ";
    " \\ - - - - - - - - - - -   {_ _ _ _ _{_______]  H Y B R I D  [______}_ _ _ _ _}    - - - - - - - - - - - - -// ";
    " //- - - - - - - - - - -  { _ _ _ _ { _ _ _ _ _]             [_ _ _ _ _ } _ _ _ _ }  - - - - - - - - - - - - \\ ";
    " \\ - - - - - - - - - -          { _ _ _ _ _ _]      B Y      [_ _ _ _ _ _ }          - - - - - - - - - - - -// ";
    " //- - - - - - - - - - -                                                             - - - - - - - - - - - - \\ ";
    " \\ - - - - - - - - - - -     [  S E C U R E   D I G I T S   P L U S   L L C  ]     - - - - - - - - - - - - -// ";
    " //- - - - - - - - - - - -                                                           - - - - - - - - - - - - \\ ";
    " \\ - - - - - - - - - - -      \_______________________________________________/      - - - - - - - - - - - -// ";
    " //- - - - - - - - - - -                                                               - - - - - - - - - - - \\ ";
    " \\ - - - - - - - - - -  [  0 6 / 1 3 / 2 0 1 9  |  M I C H A E L  C  C O O K  S R . ]  - - - - - - - - - - -// ";
    " //- - - - - - - - - -                                                                    - - - - - - - - - -\\ ";
    " \\ - - - - - - - - -   \_____________________________________________________________/    - - - - - - - - - // ";
    " //                                                                                                          \\ ";
    " \\               Our primary preference and purpose is to present to all people this promise:               // ";
    " //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \\ ";
    " \\                   'We proclaim to process the plan, for platinum protections and policies,               // ";
    " // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\\ ";
    " \\             whether premises, product, or patents, via persistently programmed protocology.              // ";
    " //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \\ ";
    " \\                 In pursuit of the proper provisions, to prevent any party or personnel,                  // ";
    " // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\\ ";
    " \\              from public or private access... using parameters, permissions, and passwords.              // ";
    " // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\\ ";)
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
    Wrap-Array -Block $logo ; Read-Host "Press Enter to Continue" }


    Function Display-Foot { 
    
    $foot= @(

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
    " //                                                                                                          \\ ";
    " \\  <@[ Script-Complete ]@>                                                                                 // ";
    " //                                                                                                          \\ ";
    " \\                          You've just deployed 'A heightened sense of security.'                          // ";
    " //                                                                                                          \\ ";
    " \\                      [ Secure Digits Plus LLC | Hybrid ] [ Desired State Controller ]                    // ";
    " //                                                                                                          \\ ";
    " \\                                   [ https://www.securedigitsplus.com ]                                   // ";
    " //                                                                                                          \\ ";)
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

    Wrap-Array `
        -Block $foot 
        
    Read-Host "Press Enter to exit" 
    
    }

    Wrap-Action -Type "Initialized" -Info "Hybrid"; Display-TrueColors; Display-Logo; 

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Provisional Root ]- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function -ID "Provisional-Root"

        $Bridge = 
            '(0)Resources' ,
            '(1)Tools' , 
            '(2)Images' , 
            '(3)Profiles' , 
            '(4)Certificates' , 
            '(5)Applications'

        $lm = 
            $env:ComputerName , 
            $env:Processor_Architecture , 
            "$env:SystemDrive\" , 
            $env:SystemRoot , 
            "$env:SystemRoot\System32" , 
            $env:programdata , 
            $env:ProgramFiles

        if ( $lm[0] -eq $r[2] ) 
        { 
            $dr = $r[16] 
        } 
        else 
        { 
            $dr = $r[1] 
        } 
        
        $ds = "$dr\$($r[0])"

        $Root = @{

            0 = $Bridge | % { "$ds\$_" }
            1 = $Bridge | % { $lm[2] + $r[0] + '\' + $_ }
            2 = "( Domain State Controller @ Source )" , 
                "( Current Machine @ Variables )" , 
                "( Provision Index @ Bridge Control )"
            3 = "Provisionary" , 
                "(DSC) Share" , 
                "(DSC) Controller" , 
                "Resources" , 
                "Tools / Drivers" , 
                "Images" , 
                "Profiles" , 
                "Certs" , 
                "Apps"
            4 = "(DSC) Host" , 
                "Current Hostname" , 
                "CPU Architecture" , 
                "System Drive" , 
                "Windows Root" , 
                "System32" , 
                "Program Data"

            5 = "(DSC) Target" , 
                "Resources" , 
                "Tools / Drivers" , 
                "Images" , 
                "Profiles" , 
                "Certificates" , 
                "Applications" , 
                "Background" , 
                "Logo"
                
                }

        if ( $lm[0] -eq $r[2] ) { $srv = "Yes" }

        else                    { $srv = "No"  }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Hybrid Control Panel ]- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

        Wrap-Title -Title "Provisional-Root" 

        Wrap-Section -Section $Root[2][0]

        Wrap-ItemOut -Type $Root[3][0] -Info $r[0]
        Wrap-ItemIn  -Type $Root[3][1] -Info $r[1]
        Wrap-ItemOut -Type $Root[3][2] -Info $r[2]
        Wrap-ItemIn  -Type $Root[3][3] -Info $Root[0][0]
        Wrap-ItemOut -Type $Root[3][4] -Info $Root[0][1]
        Wrap-ItemIn  -Type $Root[3][5] -Info $Root[0][2]
        Wrap-ItemOut -Type $Root[3][6] -Info $Root[0][3]
        Wrap-ItemIn  -Type $Root[3][7] -Info $Root[0][4]
        Wrap-ItemOut -Type $Root[3][8] -Info $Root[0][5]

        Wrap-Section -Section $Root[2][1]

        Wrap-ItemOut -Type $Root[4][0] -Info $srv
        Wrap-ItemIn  -Type $Root[4][1] -Info $lm[0]
        Wrap-ItemOut -Type $Root[4][2] -Info $lm[1]
        Wrap-ItemIn  -Type $Root[4][3] -Info $lm[2]
        Wrap-ItemOut -Type $Root[4][4] -Info $lm[3]
        Wrap-ItemIn  -Type $Root[4][5] -Info $lm[4]
        Wrap-ItemOut -Type $Root[4][6] -Info $lm[5]

        Wrap-Section -Section $Root[2][2]

        Wrap-ItemOut -Type $Root[5][0] -Info $lm[0]
        Wrap-ItemIn  -Type $Root[5][1] -Info $Root[1][0]
        Wrap-ItemOut -Type $Root[5][2] -Info $Root[1][1]
        Wrap-ItemIn  -Type $Root[5][3] -Info $Root[1][2]
        Wrap-ItemOut -Type $Root[5][4] -Info $Root[1][3]
        Wrap-ItemIn  -Type $Root[5][5] -Info $Root[1][4]
        Wrap-ItemOut -Type $Root[5][6] -Info $Root[1][5]

        Wrap-In
        Wrap-Out
        Wrap-Bot
        
    Read-Host "Press (Enter) to continue"

    $d = $Root[0] ; $l = $Root[1] ;  $b = $Bridge ; $Root = "" ; $Bridge = "" ;

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Provision-Client ]- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function -ID "Provision-Client"

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Provision-Certificates ]- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    switch( $host.UI.PromptForChoice( 'Provision-Certificates' , 'Install Certificate Chain ?' , 
    [System.Management.Automation.Host.ChoiceDescription[]]@( '&Yes' , '&No' ) , [int] 1 )  )
    { 
        0
        {  
            $cx = gci $d[4] -EA 0  | % { $d[4] + '\' + $_ }

            if ( ( $cx -ne $null ) -and ( gci $cx -EA 0 ) -ne $null )
            { 
                ( gci $cx -Filter "*.crt" -EA 0 ) | % { 
                    
                    Import-Certificate `
                        -FilePath $_.FullName `
                        -CertStoreLocation "Cert:\LocalMachine\$( $_.Directory.name.Split('()')[2] )"

                    if ($? -eq $True) 
                    {
                        Wrap-Action `
                            -Type "Installed" `
                            -Info "[+] $($_.basename)"
                    }

                    else
                    {
                        Wrap-Action `
                            -Type "Exception" `
                            -Info "[!] $($_.basename)"  
                    }
                }
            }

            else 
            {
                Wrap-Action `
                    -Type "Exception" `
                    -Info "Certificates Not Found"
                break 
            }
        }

        1
        {
            Wrap-Action `
                -Type "Bypass" `
                -Info "Certificate Chainloading" }

    }
    $cx = "" ;


#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Provision-Virtualization ]- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function -ID "Provision-Virtualization"

    switch ( $host.UI.PromptForChoice( 
    'Provision-Virtualization' , 
    'Install VM Template ?' , 
    [System.Management.Automation.Host.ChoiceDescription[]]@( 
        '&Yes' , 
        '&No' ) , 
    [int] 1 ) 
    )
    {
        0
        {   
            Switch ( $host.UI.PromptForChoice( 
            'Select-Virtualization' , 
            'Choose Template' ,  
            [System.Management.Automation.Host.ChoiceDescription[]]@( 
                '&VMWare' , 
                '&Oracle' , `
                '&Cancel' ), 
            [int] 2 )
            )
            {
                0
                {   
                    $vm =
                    @( $d[1] , $l[1] | % { "$_\VM\VMWare" } ) + 
                    '\setup.exe' , 
                    '\setup64.exe' , 
                    '/s /v "/qn reboot=r"'

                    if ( ( Test-Path $vm[1] ) -eq $false ) 
                    { 
                        
                        Robocopy $vm[0] $vm[1] /mir
                        Wrap-Action `
                            -Type "Copied" `
                            -Info "[+] VMWare Tools for execution"     
                    }

                    else
                    {
                        Wrap-Action `
                            -Type "Exception" `
                            -Info "Folder Currently Exists"
                    }

                    if ( $lm[1] -eq 'x86' )
                    {
                        $vmx = $vm[1] + $vm[2] 
                    }
                    
                    else
                    {
                        $vmx = $vm[1] + $vm[3]
                    } 
                    
                    $vmt = "VMWare Tools ( $( $lm[1] ) )"           
                }

                # Prime Oracle VirtualBox VBGA
                1
                {
                    $vm =
                    @( $d[1] , $l[1]  | % { "$_\VM\Oracle" } ) + 
                    @( '-x86.exe' , '-AMD64.exe'  | % { "\VBoxWindowsAdditions$_" }) + 
                    '/s "/qn reboot=r"'

                    if ( ( Test-Path $vm[1] ) -eq $false ) 
                    { 
                        Robocopy $vm[0] $vm[1] /mir

                        Wrap-Action `
                            -Type "Copied" `
                            -Info "[+] VMWare Tools for execution"
                    }

                    else 
                    {
                        Wrap-Action `
                            -Type "Exception" `
                            -Info "Folder Currently Exists"
                    }

                    1 , 256 | % { 
                        
                        Import-Certificate `
                            -FilePath "$( $vm[1] )\cert\vbox-sha$_.cer" `
                            -CertStoreLocation "Cert:\LocalMachine\TrustedPublisher"
                    }

                    if ( $lm[2] -eq 'x86' )
                    {
                        $vmx = ( $vm[1] + $vm[2] )
                    }

                    else
                    {
                        $vmx = ( $vm[1] + $vm[3] )
                    }
                    
                    $vmt = "VirtualBox Guest Additions $( $lm[1] )"
                }

                2 
                { 
                    Wrap-Action `
                        -Type "Bypass" `
                        -Info "Virtualization" 
                }
            
            }

            Function Install-VirtualMachine { 
            $VirtualMachine = Start-Process `
                -FilePath $vmx `
                -ArgumentList $vm[4] `
                -PassThru

                for ( $j = 0 ; $j -le 100 ; $j = ( $j + 1 ) % 100 )
                {
                    Write-Progress `
                        -Activity ( '[ Installing ] ' + $vmt ) `
                        -PercentComplete $j `
                        -Status "$( $j )% Complete"
                    
                    Start-Sleep -Milliseconds 650

                    if ( $VirtualMachine.HasExited )
                    {
                        Write-Progress `
                            -Activity ( '[ Installed ] ' + $vmt ) `
                            -Completed

                        Return
                    }
                }
            }

            Install-VirtualMachine

            Remove-Item "$( $l[1] )\VM" `
                -Recurse
            
            $vm  = "" ; $vmx = "" ; $vmt = ""
        }
    
        1
        {
            Wrap-Action `
                -Type "Bypass" `
                -Info "Virtualization"
        }
    }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Provision-Branding ]- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function -ID "Provision-Branding"

        switch ( $host.UI.PromptForChoice( 
        'Provision-Branding' , 
        'Initialize OEM-Branding ?' , 
        [System.Management.Automation.Host.ChoiceDescription[]]@( 
            '&Yes' , 
            '&No' ) , 
        [int] 1 ) 
        )
        {
            0
            {
                Wrap-Action `
                    -Type "Provisioning" `
                    -Info "[+] OEM Branding"
        
                $res = ( $r[8] , $r[9] ) | % { gci $d[0] -filter $_ -EA 0 }

                $res | % { Robocopy $_.DirectoryName $l[0] $_.Name }

                if ( $? -eq $True )
                {
                    Wrap-Action -Type "Copied" -Info "$( $l[0] + '\' + $_.Name )"
                }

                else
                {
                    Wrap-Action -Type "Exception" -Info "[!] $($_.Name) not copied"
                }

                $lg = ( gci $l[0] -Filter "$($r[8])" -EA 0 )

                $bg = ( gci $l[0] -Filter "$($r[9])" -EA 0 )

                $or = # Registry Declarations

                    'HKLM:' , 
                    'HKCU:' , 
                    '\Software\Policies\Microsoft\Windows' , 
                    '\Software\Microsoft\Windows\CurrentVersion' , 
                    '\Policies' , 
                    '\OEMInformation' , 
                    '\Authentication\LogonUI\Background' , 
                    '\Control Panel\Desktop'


                $oc = # Registry Concat

                    @( $or[0] + $or[2] ; @( $or[0] , $or[1] | % { $_ + $or[3] } ) )


                $tp = # Types

                    'Directory' , 
                    'Personalization' , 
                    'System' , 
                    'Manufacturer' , 
                    'SupportURL' , 
                    'SupportPhone' , 
                    'SupportHours' , 
                    'Logo' , 
                    'OEMBackground' , 
                    'LockScreenImage' , 
                    'Wallpaper' , 
                    'WallPaperStyle'

                $of = # File Declarations

                    '\OOBE\Info' , 
                    '\Backgrounds' , 
                    '\Microsoft\User Account Pictures' ,
                    '\Web\Screen' , 
                    '\Web\Wallpaper\Windows'
                
                
                $fc = # File Concat

                    ( $lm[4] + $of[0] )

                    
                    $f = # C:\WINDOWS\System32\OOBE\Info [+] Backgrounds

                    ( $fc + $of[1] )

                    if ( ( Test-Path $f ) -ne $True ) 
                    { 
                        New-Item `
                            -Path $fc `
                            -Name $of[1] `
                            -Type $tp[0]
                             
                        Wrap-Action `
                            -Type "Directory [+]" `
                            -Info $f
                    }


                    # Copy the $r[8] "System Logo" to System Folders 

                   ( $lm[4] ) , ( $lm[4] + $of[0] ) , ( $lm[5] + $of[2] ) | % { 

                        if ( Test-Path $_ ) 
                        { 
                            Robocopy $lg.DirectoryName $_ $lg.Name

                            if ( $? -eq $True )
                            {
                                Wrap-Action `
                                    -Type "Logo" `
                                    -Info "[+] Copied $_"
                            }
                        }
                    }
        
                    # Copy Background to System Folders 
                    ( $fc + $of[1] ) , ( $lm[3] + $of[3] ) , ( $lm[3] + $of[4] ) | % { 
                        
                        if ( Test-Path $_ )
                        {
                            Robocopy $bg.DirectoryName $_ $bg.Name
                            Wrap-Action `
                                -Type "Background" `
                                -Info "[+] copied $_"
                        }

                    }

                    # HKLM:\Software\Policies\Microsoft\Windows [+] Personalization 

                    $h = $oc[0]
                    $g = ( $h + '\'+ $tp[1] )

                    if ( ! ( Test-Path $g ) )
                    {
                        New-Item `
                            -Path $h `
                            -Name $tp[1] `
                            -Force

                        Wrap-Action `
                            -Type "Created" `
                            -Info $g
                    }

                    # Lock Screen

                    $h = $g
                    $v = ( $lm[3] + $of[3] + '\' + $r[9] ) 

                    sp $h `
                        -Name $tp[9] `
                        -Value $v   
                     
                    if ( $? -eq $True )
                    {
                        Wrap-Action `
                            -Type $tp[9] `
                            -Info "[+] $v"
                    }

                    else 
                    {
                        Wrap-Action `
                            -Type "Exception" `
                            -Info "[!] $v not set"
                    }

                    # HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies [+] System

                    $h = ( $oc[2] + $or[4] )
                    $g = ( $h + '\' + $tp[2] )

                    if ( ! ( Test-Path $g ) ) 
                    {
                        New-Item `
                            -Path $h `
                            -Name $tp[2] `
                            -Force

                        Wrap-Action `
                            -Type "Created" `
                            -Info $g
                    }

                    # Set Wallpaper / Style

                    $h = $g
                    $v = ( $lm[3] + $of[4] + '\' + $r[9] ) , 2
                    $t = $tp[10..11]
                    $j = 0 
                        
                    do
                    {
                        sp $h `
                            -Name $t[$j] `
                            -Value $v[$j]
                        
                        if ( $v[$j] -eq 2 )
                        {
                            $v[$j] = "Set to Fit Screen"
                        }

                        if ( $? -eq $true )
                        {
                            Wrap-Action `
                                -Type "$( $t[$j] )" `
                                -Info "[+] $( $v[$j] )"
                        }
                        
                        else
                        {
                            Wrap-Action `
                                -Type "Exception" `
                                -Info "[!] $( $v[$j] )"
                        }
                        $j = ( $j + 1 ) 
                    }
                    until ( $j -ge $v.count )

                    # HKLM:\Software\Microsoft\Windows\CurrentVersion\OEMInformation
                    # Provisionary Name / Provisionary Website / Support Phone Number / Support Hours / Logo

                    $h = $oc[1] + $or[5]
                    $v = $r[0] , $r[5] , $r[6] , $r[7] , ( $lm[4] + '\' + $r[8] )
                    $t = $tp[3..7]
                    $j = 0
                    
                    do 
                    { 
                        sp $h `
                            -Name $t[$j] `
                            -Value $v[$j] ;
                        
                        if ( $v -eq $v[4])
                        {
                            $v[4] = $lg.Name
                        }
                        
                        if ( $? -eq $True)
                        {
                            Wrap-Action `
                                -Type "$( $t[$j] )" `
                                -Info "[+] $( $v[$j] )"
                        } 
                        
                        else
                        {
                            Wrap-Action `
                                -Type "Exception" `
                                -Info "[!] $( $v[$j] )"
                        }
                        $j = ( $j + 1 )
                    }
                    until ( $j -ge $v.count )

                    # HKLM:\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\Background
                    # Logon Background
                    $h = ( $oc[1] + $or[6] )
                    $v = 1 
                    
                        sp $h `
                            -Name $tp[8] `
                            -Value $v

                        if ( $? -eq $True )
                        { 
                            Wrap-Action `
                                -Type "$( $tp[8] )" `
                                -Info "[+] Background"
                        }

                        else 
                        {
                            Wrap-Action `
                                -Type "Exception" `
                                -Info "[!] Background"
                        }

                    # HKCU:\Control Panel\Desktop'
                    $h = ( $or[1] + $or[7] + '\' ) ; $t = $tp[10] ; $v = ( $lm[3] + $of[4] + '\' + $r[9] ) ;
                    
                        sp $h `
                            -Name $t `
                            -Value $v

                        rundll32.exe user32.dll, UpdatePerUserSystemParameters 1, True
                        if ( $? -eq $True )
                        {
                            Wrap-Action `
                                -Type $t `
                                -Info "[+] Wallpaper Set"
                        }

                        else 
                        { 
                            Wrap-Action `
                                -Type "Exception" `
                                -Info "[!] Wallpaper not set"
                        }

                    # Launch the System Panel for review
                    control /name microsoft.system

                    Wrap-Action `
                        -Type "Complete" `
                        -Info "[+] OEM Branding Applied"

            }

            1 
            { 
                Wrap-Action `
                    -Type "Bypass" `
                    -Info "OEM Branding"
            }
        }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Provision-Drivers ] - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function -ID "Provision-Drivers"

        switch ( $host.UI.PromptForChoice( 
        'Provision-Drivers' , 
        'Install the drivers for this machine?' , 
        [System.Management.Automation.Host.ChoiceDescription[]]@( 
            '&Yes' , 
            '&No' ) , 
        [int] 1 ) )
        {
            0
            {
                Wrap-Action `
                    -Type "Provisioning" `
                    -Info "[+] Dynamic Driver Template for $($lm[0])"

                # Target the Snappy Driver Installer Library from DSC
                $Drivers = "$( $r[1] + '\' + $r[0] )\(1)Tools\Drivers\SDI"
                $sd  = @( 
                ( 
                    ( gci $Drivers -filter "*.exe" -EA 0 ).Name | % { "$Drivers\$_" } ) ; 
                    "-drp_dir:drivers" , 
                    "-index_dir:indexes\SDI" , 
                    "-output_dir:indexes\SDI\txt" ,
                    "-data_dir:tools\SDI" , 
                    "-log_dir:logs" , 
                    "-finish_cmd:-autoclose" , 
                    "-finishrb_cmd:" , 
                    "-finish_upd_cmd:" , 
                    "-lang:English" , 
                    "-theme:Lite" , 
                    "-hintdelay:500" , 
                    "-license:1" , 
                    "-wndwx:1024" , 
                    "-wndwy:607" , 
                    "-wndsc:1" , 
                    "-scale:250" , 
                    "-filters:166" , 
                    "-port:50171" , 
                    "-downlimit:0" , 
                    "-uplimit:0" , 
                    "-connections:0" , 
                    "-expertmode -norestorepnt -showdrpnames2 -checkupdates" 
                    "-extractdir:`"$( $l[0] )\Drivers`""
                )

                Set-Content `
                    -Path "$Drivers\SDI.cfg" `
                    -Value $sd[2..24] `
                    -Force

                if ( $lm[1] -eq "x86" ) 
                {
                    $sdx = $sd[0] 
                } 
                
                else
                {
                    $sdx = $sd[1]
                }

                Wrap-Action `
                    -Type "Creating" `
                    -Info "Firewall Entries for $( $sdx.Split('\')[8] )"

                # Set Firewall Rules to allow Snappy to install over the network
                
                New-NetFirewallRule `
                    -DisplayName ( $sdx.Split('\')[8] ) `
                    -Direction Inbound  `
                    -Program $sdx `
                    -RemoteAddress LocalSubnet `
                    -Action Allow
                
                New-NetFirewallRule `
                    -DisplayName ( $sdx.Split('\')[8] ) `
                    -Direction OutBound `
                    -Program $sdx `
                    -RemoteAddress LocalSubnet `
                    -Action Allow

                Wrap-Action `
                    -Type "Launching" `
                    -Info "Snappy Driver Installer"
                
                Start-Process "$Drivers\SDI.bat"

                $sd = "" ; $sdx = "" ; $Drivers = "" ;
            }

            1
            {
                Wrap-Action `
                    -Type "Bypass" `
                    -Info "[-] Dynamic Driver Template"
            }

        }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Provision-Applications ]- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function `
        -ID "Provision-Applications"

    switch ( 
    $host.UI.PromptForChoice( 
    'Provision-Applications' , 
    'Install standard applications via Local Proxy or Chocolatey ?' , 
    [System.Management.Automation.Host.ChoiceDescription[]]@( 
        '&Local' , 
        '&Chocolatey' , 
        '&Skip' ) , 
    [int] 0 ) 
    )
    {
            # Pull applications from proxy/DC
            0
            {
                Wrap-Action `
                    -Type "Selected" `
                    -Info "Local Proxy"
                    
                    $package = [Ordered] @{
                       0  = @{      # Google Chrome

                            index   = "\(1)chrome"
                            tag     = "Google Chrome"
                            ver     = "74.0.3729.169"
                            uid     = "chrome"
                            exe     = ".msi"
                            x22     = 0
                            x86     = 1
                            x64     = 1
                            arg     = "/quiet /norestart"
                            url     = "https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise.msi"
                            u64     = "https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi"
                            }

                       1  = @{      # Malwarebytes Anti-Malware
                            
                            index   = "\(2)mwb"
                            tag     = "Malwarebytes Anti-Malware"
                            ver     = "3.7.1.283910998"
                            uid     = 'mwb'
                            exe     = ".exe"
                            x22     = 1
                            x86     = 0
                            x64     = 0
                            arg     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART"
                            url     = "https://downloads.malwarebytes.com/file/mb3/mb3-setup-consumer-3.7.1.2839-1.0.563-1.0.10290.exe"
                            u64     = ""
                            }

                       2  = @{ # Adobe Flash

                            index   = "\(3)flash"
                            tag     = "Adobe Flash Player"
                            ver     = "32.0.0.192"
                            uid     = "flash"
                            exe     = ".msi"
                            x22     = 1
                            x86     = 0
                            x64     = 0
                            arg     = "/quiet /norestart REMOVE_PREVIOUS=YES"
                            url     = "https://download.macromedia.com/get/flashplayer/pdc/32.0.0.171/install_flash_player_32_plugin.msi"
                            u64     = ""
                            }

                       3  = @{ # Adobe Air

                            index   = "\(4)air"
                            tag     = "Adobe Air Runtime"
                            ver     = "32.0.0.89"
                            uid     = "air"
                            exe     = ".exe"
                            x22     = 1
                            x86     = 0
                            x64     = 0
                            arg     = "-silent -eulaAccepted"
                            url     = "http://airdownload.adobe.com/air/win/download/32/AdobeAirInstaller.exe"
                            u64     = ""
                            }
                       
                       4  = @{ # Adobe Reader

                            index   = "\(5)reader"
                            tag     = "Adobe Acrobat Reader DC"
                            ver     = "2019.010.20099"
                            uid     = "reader"
                            exe     = ".exe"
                            x22     = 1
                            x86     = 0
                            x64     = 0
                            arg     = "/sAll /msi /norestart /quiet ALLUSERS=1 EULA_ACCEPT=YES UPDATE_MODE=3 /L*v ($env:temp)"
                            url     = "http://ardownload.adobe.com/pub/adobe/reader/win/AcrobatDC/1901020064/AcroRdrDC1901020064_MUI.exe"
                            u64     = ""
                            } 
                                                     
                       5  = @{ # Microsoft Silverlight
                            
                            index   = "\(6)silverlight"
                            tag     = "Microsoft Silverlight"
                            ver     = "v5.1.50907.0"
                            uid     = "silverlight"
                            exe     = ".exe"
                            x22     = 0
                            x86     = 1
                            x64     = 1
                            arg     = "/q"
                            url     = "https://download.microsoft.com/download/F/D/0/FD0B0093-DE8A-4C4E-BDC4-F0C56D72018C/50907.00/Silverlight.exe"
                            u64     = "https://download.microsoft.com/download/F/D/0/FD0B0093-DE8A-4C4E-BDC4-F0C56D72018C/50907.00/Silverlight_x64.exe"
                            }

                       6  = @{ # 7-Zip

                            index   = "\(7)zip"
                            tag     = "7-Zip"
                            ver     = "19.00"
                            uid     = "7zip"
                            exe     = ".exe"
                            x22     = 0
                            x86     = 1
                            x64     = 1
                            arg     = '/S /D="C:\Program Files\7-Zip"'
                            url     = "https://www.7-zip.org/a/7z1900.exe"
                            u64     = "https://www.7-zip.org/a/7z1900-x64.exe"
                            }

                       7  = @{ # Java Runtime Environment 8
                            
                            index   = "\(8)jre"
                            tag     = "Java Runtime Environment"
                            ver     = "8.0.2010.9"
                            uid     = "jre8"
                            exe     = ".exe"
                            x22     = 0
                            x86     = 1
                            x64     = 1
                            arg     = "/s REBOOT=0 SPONSORS=0 AUTO_UPDATE=0"
                            url     = "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=236886_42970487e3af4f5aa5bca3f542482c60"
                            u64     = ""
                            }

                       8  = @{ # Piriform CCleaner
                            
                            index   = "\(9)ccleaner"
                            tag     = "Piriform Ltd"
                            ver     = "5.57.7182"
                            uid     = "CCleaner"
                            exe     = ".exe"
                            x22     = 1
                            x86     = 0
                            x64     = 0
                            arg     = "/S /L="+(((Get-Culture).LCID))
                            url     = "https://download.ccleaner.com/ccsetup556.exe"
                            u64     = ""
                            }

                       9  = @{ # K-Lite Codec Pack
                            
                            index   = "\(10)klite"
                            tag     = "K-Lite Codec Pack Full"
                            ver     = "14.9.4"
                            uid     = "klite"
                            exe     = ".exe"
                            x22     = 1
                            x86     = 0
                            x64     = 0
                            arg     = "/VERYSILENT /NORESTART"
                            url     = "http://files2.codecguide.com/K-Lite_Codec_Pack_1490_Full.exe"
                            u64     = ""
                            }

                       10 = @{ # TeamViewer

                            index   = "\(11)tv"
                            tag     = "TeamViewer"
                            ver     = "14.2.8352"
                            uid     = "tv"
                            exe     = ".exe"
                            x22     = 1
                            x86     = 0
                            x64     = 0
                            arg     = "/S"
                            url     = "https://download.teamviewer.com/download/version_14x/TeamViewer_Setup.exe"
                            u64     = ""
                        }
                    }
                    # CPU Architecture Type

                    $CPU = $lm[1] ;

                    $Package[0..10] | % {

                    # Select the proper package type and keep/change download URL

                    if (   $_.x22 -eq 1 )      { $_.Type = '(x22)' }
                    if ( ( $_.x86 -eq 1 ) -and ( $CPU -eq "x86"   ) ) { $_.Type = '(x86)' }
                    if ( ( $_.x64 -eq 1 ) -and ( $CPU -eq "AMD64" ) ) { $_.Type = '(x64)' ; $_.URL = $_.u64 }

                    $Control=@{

                        Source = @{

                            Path     = ( $d[5] + $_.Index )
                            File     = ( $_.UID + $_.Type + $_.EXE )
                            FullName = ( $d[5] + $_.Index + '\' + $_.UID + $_.Type + $_.EXE ) }

                        Target = @{
                            
                            Path     = ( $l[5] + $_.Index )
                            File     = ( $_.UID + $_.Type + $_.EXE )
                            FullName = ( $l[5] + $_.Index + '\' + $_.UID + $_.Type + $_.EXE ) } 

                        }

                    if ( ! ( Test-Path ( $Control.Target.Path ) ) )
                    {
                        New-Item `
                            -Path        ( $Control.Target.Path ) `
                            -ItemType    Directory `
                            -Value       ( $Control.Target.Path )
                    }

                    if ( ! ( Test-Path ( $Control.Source.Path ) ) )
                    {
                        Invoke-WebRequest `
                            -Uri ( $_.URL ) `
                            -OutFile  ( $Control.Target.Fullname ) }

                    # Pull from the local cache/proxy

                    else
                    {
                        Robocopy ( $Control.Source.Path ) ( $Control.Target.Path ) ( $Control.Target.File ) 
                    }

                    # Create a Canon Filename

                    if ( ( $_.x86 -eq 1 ) -and ( $_.x64 -eq 1 ) ) 
                    { 
                        $Type = "(x86/x64)" 
                    }
                    
                    $FullName = ( $_.Tag + ' ' + $_.Ver + ' ' + $Type )

                    # Previous installation control

                    $Check = @( gp "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" ).DisplayName
                    if ( ! ( ( $Check ) -Contains ( $_.Tag ) ) )
                    {
                        Function Preload-CCleaner {

                            $cc = "HKLM:\Software\Google\No " , "HKLM:\Software\WOW6432Node\Google\No " , 
                            "Chrome" , "Toolbar" , " Offer Until"

                            $_cc = ( $cc[2] + $cc[4] ) , ( $cc[3] + $cc[4] )
                            
                            if ( $CPU -eq "x86" )
                            {
                                $cc_ = ( $cc[0] + $_cc[0] ) , ( $cc[0] + $_cc[1] )
                            }

                            if ( $CPU -eq "AMD64" )
                            {
                                $cc_ = ( $cc[1] + $_cc[0] ) , ( $cc[1] + $_cc[1] )
                            }

                            New-Item $cc_[0] `
                                -ItemType Directory `
                                -Force

                            New-ItemProperty `
                                -Name ( $_.Tag ) `
                                -Path ( $cc_[0] ) `
                                -PropertyType ( "DWORD" ) `
                                -Value ( "20991231" ) `
                                -Force

                            New-Item $cc_[1] `
                                -ItemType Directory `
                                -Force
                                
                            New-ItemProperty `
                                -Name ( $_.Tag ) `
                                -Path ( $cc_[1] ) `
                                -PropertyType ( "DWORD" ) `
                                -Value ( "20991231" ) `
                                -Force 
                            
                            $cc = ""; $_cc = ""; $cc_ = ""
                        }

                        if ( $_.UID -eq "CCleaner" ) { Preload-CCleaner }

                        Function Install-Application {
                            $Application = Start-Process `
                                -FilePath ( $Control.Target.FullName ) `
                                -Argumentlist ( $_.Arg ) `
                                -PassThru

                            for ( $j = 0 ; $j -le 100 ; $j = ( $j + 1 ) % 100 )
                            {
                                Write-Progress `
                                    -Activity ( " [ Installing ] " + $FullName ) `
                                    -PercentComplete $j `
                                    -Status "$( $j )% Complete"
                                
                                Start-Sleep -Milliseconds 500
                                
                                if ( $Application.HasExited ) 
                                {
                                    Write-Progress `
                                    -Activity "[ Installed ]" `
                                    -Completed
                                    
                                    Return
                                }
                            }
                        }

                        Install-Application
                    }

                    else { Wrap-Action -Type "Exception" -Info "$( $Application ) Already installed" }
                }
                Remove-Item $l[5] -Recurse -Force
            }

            #Chocolatey
            1
            { 
                Wrap-Action -Type "Selected" -Info "Chocolatey Package Manager"
                iex (
                (New-Object System.Net.Webclient).DownloadString(
                'https://chocolatey.org/install.ps1')
                )

                $package = 

                    "googlechrome" , 
                    "malwarebytes" , 
                    "flashplayerplugin" , 
                    "adobeair" , 
                    "adobereader" , 
                    "silverlight" , 
                    "7zip.install" , 
                    "jre8" , 
                    "ccleaner" , 
                    "k-litecodecpackfull" , 
                    "teamviewer"

                $package | % { 
                
                    Wrap-Action `
                        -Type "Installing" `
                        -Info $_

                    choco install $_ -y
                    
                    if ( $? -eq $True ) 
                    {
                        Wrap-Action `
                            -Type "Installed" `
                            -Info "[+] Chocolatey @ $_"
                    }

                    else 
                    {
                        Wrap-Action `
                            -Type "Exception" `
                            -Info "[!] $_ was not installed"
                    }

                Wrap-Action `
                    -Type "Complete" `
                    -Info "Chocolatey - Default Applications Installed"
                }

            }

            #Skip
            2
            { 
                Wrap-Action `
                    -Type "Bypass" `
                    -Info "Default Applications Skipped"
            }
        }
        $package     = "" ; $Application = "" ;

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Provision-Updates ] - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function `
        -ID "Provision-Updates"

    Function Install-Update {
    $Update = Start-Process `
        -FilePath ( $_.FullName ) `
        -PassThru

    for ( $j = 0 ; $j -le 100 ; $j = ( $j + 1 ) % 100 )
        {
            Write-Progress `
                -Activity ( " [ Installing ] " + $_.Name ) `
                -PercentComplete $j `
                -Status "$( $j )% Complete"
                                
                Start-Sleep -Milliseconds 500
                                
            if ( $Update.HasExited ) 
            {
                Write-Progress `
                    -Activity "[ Installed ]" `
                    -Completed
                                    
                Return
            }
        }
    }

        if ( $lm[1] -eq "x86" )
        {
            $Updates_ = "$( $d[2] )\Updates\x86"
            if ( ( Test-Path $Updates_ ) -eq $True )
            {
                $x86 = @( gci $Updates_ -EA 0 )
                $x86 | % { Install-Update }
            }
        }

        if ( $lm[1] -eq "AMD64" )
        {
            $Updates_ = "$( $d[2] )\Updates\x64"
            if ( ( Test-Path $Updates_ ) -eq $True )
            {
                $x64 = @( gci $Updates_ -EA 0 )
                $x64 | % { Install-Update }
            }
        }

        
    Start-Process ms-settings:windowsupdate-action

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Designate-Account ] - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function `
        -ID "Designate-Account"

    switch ( $host.UI.PromptForChoice( 
    'Designate-Account' , 
    'Migrate/Create User Account, or skip ?' , 
    [ System.Management.Automation.Host.ChoiceDescription [] ]@( 
        '&Create' , 
        '&Skip' ) , 
    [int] 1 ) )
    {
        # User Account Designation GUI
        0
        {
            Wrap-Action `
                -Type "Select" `
                -Info "User Account"

            $xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
    Title="Secure Digits Plus LLC | Hybrid @ Account Designation" Width="480" Height="300" 
    HorizontalAlignment="Center" ResizeMode="NoResize" WindowStartupLocation="CenterScreen" 
    Topmost="True">
    <GroupBox Header="Enter Username and Password" HorizontalAlignment="Center" VerticalAlignment="Center" Height="250" Margin="10,10,10,10" Width="460">
        <Grid Height="200">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="25*"/>
                <ColumnDefinition Width="75*"/>
                <ColumnDefinition Width="34*"/>
                <ColumnDefinition Width="75*"/>
                <ColumnDefinition Width="25*"/>
            </Grid.ColumnDefinitions>
            <Grid.RowDefinitions>
                <RowDefinition Height = "*" />
                <RowDefinition Height = "*" />
                <RowDefinition Height = "1.5*" />
                <RowDefinition Height = "1.5*" />
                <RowDefinition Height = "1.5*" />
                <RowDefinition Height = "1.5*" />
            </Grid.RowDefinitions>
            <TextBlock Grid.ColumnSpan="3" Grid.Row="0" FontSize="12" HorizontalAlignment="Center" Width="353" Grid.Column="1" TextAlignment="Center" Text="Enter the credentials you would like to designate to your user."/>
            <TextBlock Grid.ColumnSpan="3" Grid.Row="1" FontSize="12" HorizontalAlignment="Center" Width="353" Grid.Column="1">A password is required, but may be changed after logging in.</TextBlock>
            <TextBlock Grid.Row="2" FontSize="12" HorizontalAlignment="Center" VerticalAlignment="Center" Margin="0,0,25,0" Height="20" Width="120" TextAlignment="Right" Grid.Column="1">Username:</TextBlock>
            <TextBlock Grid.Row="3" FontSize="12" HorizontalAlignment="Center" VerticalAlignment="Center" Margin="0,0,25,0" Height="20" Width="120" TextAlignment="Right" Text="Password:" Grid.Column="1"/>
            <TextBlock Grid.Row="4" FontSize="12" HorizontalAlignment="Right" VerticalAlignment="Center" Height="20" Width="120" Text="Confirm:" Margin="0,0,25,0" Grid.Column="1" TextAlignment="Right"/>
            <TextBox Name="Username" Grid.Row="2" Grid.Column="2" Height="24" Width="180" VerticalAlignment="Center" HorizontalAlignment="Left" Margin="40,0,0,0" Grid.ColumnSpan="3"></TextBox>
            <PasswordBox Name="Password" PasswordChar="*" Grid.Row="3" Grid.Column="2" Height="24" Width="180" VerticalAlignment="Center" HorizontalAlignment="Left" Margin="40,0,0,0" Grid.ColumnSpan="3"></PasswordBox>
            <PasswordBox Name="Confirm" PasswordChar="*" Grid.Row="4" Grid.Column="2" Height="24" Width="180" VerticalAlignment="Center" HorizontalAlignment="Left" Margin="40,0,0,0" Grid.ColumnSpan="3"></PasswordBox>
            <Button Grid.Row="5" Grid.Column="1" Name="Ok" Content="OK" Width="140" HorizontalAlignment="Right" Margin="0,15,0,0"/>
            <Button Grid.Row="5" Grid.Column="3" Name="Cancel" Content="Cancel" Width="140" HorizontalAlignment="Center" Margin="0,15,0,0"/>
        </Grid>
    </GroupBox>
</Window>
"@
            Function Convert-XAMLToWindow 
            { 
                Param (
                    [ Parameter ( Mandatory ) ]

                        [ string ]   $XAML , 
                    
                        [ string[] ] $NamedElement = $null ,
                
                        [ switch ]   $PassThru )
        
                    Add-Type `
                        -AssemblyName PresentationFramework
                
                    Add-Type `
                        –AssemblyName PresentationCore
                
                    Add-Type `
                        –AssemblyName WindowsBase
        
                    $reader = [ XML.XMLReader ]::Create( 
                        [ IO.StringReader ] $XAML )

                    $Output = [ Windows.Markup.XAMLReader ]::Load( 
                    $reader )

                foreach ( $Name in $NamedElement ) 
                { 
                    $Output | Add-Member `
                        -MemberType NoteProperty `
                        -Name $Name `
                        -Value $Output.FindName( $Name ) `
                        -Force 
                }

                if ( $PassThru ) 
                { 
                    $Output
                } 
                
                else           
                { 
                    $null = $GUI.Dispatcher.InvokeAsync{ 
                        
                        $Output = $GUI.ShowDialog()
                        
                        Set-Variable `
                            -Name Output `
                            -Value $Output `
                            -Scope 1 

                        }.Wait()
                    
                    $Output
                }
            }

            Function Show-WPFWindow
            {
                Param(

                    [ Parameter ( Mandatory ) ][ Windows.Window ] $GUI )

                    $Output = $null
                
                    $null = $GUI.Dispatcher.InvokeAsync{
                        
                        $Output = $GUI.ShowDialog()
                    
                        Set-Variable `
                            -Name Output `
                            -Value $Output `
                            -Scope 1

                        }.Wait()
                
                    $Output
            }

            $GUI = Convert-XAMLtoWindow `
                -Xaml $xaml `
                -NamedElement 'Username', 'Password', 'Confirm', 'Ok', 'Cancel' `
                -PassThru

            $GUI.Cancel.add_Click( { $GUI.DialogResult = $false } )

            $GUI.Ok.add_Click(
            { 
                if ( $GUI.Username.Text -eq "" )
                { 
                    [ System.Windows.MessageBox ]::Show( 
                    'You must enter a username' , 
                    'Username Error' 
                    )
                }

                elseif ( $GUI.Password.Password -eq "" )
                {
                    [ System.Windows.MessageBox ]::Show( 
                    'You must enter a password' , 
                    'Password Error' 
                    )
                }
                        
                elseif ( $GUI.Password.Password -ne $GUI.Confirm.Password )
                {
                    [ System.Windows.MessageBox ]::Show( 
                    'Password must match the confirmation' , 
                    'Confirmation Error' 
                    )
                }

                else { $GUI.DialogResult = $true }
            })

            $GUI.Username.Text     = ''
            $GUI.Password.Password = ''
            $GUI.Confirm.Password  = ''

            $null = $GUI.Username.Focus()

            $Output = 
                Show-WPFWindow `
                    -GUI $GUI

            if ( $Output -eq $True )
            { 

                Wrap-Action `
                    -Type "Generating" `
                    -Info "User Account"
                
                $Username = $GUI.Username.Text
                $Password = $GUI.Password.Password
                $SP = ConvertTo-SecureString $Password -AsPlainText -Force

                New-LocalUser $Username `
                    -Password $SP `
                    -Description "Target User account"

                Add-LocalGroupMember `
                    -Group "Administrators" `
                    -Member $Username

                $Account = New-Object `
                    -TypeName System.Management.Automation.PSCredential `
                    -Args $Username , $SP

                Start-Process -FilePath 'explorer.exe' -Credential $Account -ArgumentList "/separate" -WorkingDirectory "C:\Windows"

                if ( $? -eq $True ) 
                { 
                    Wrap-Action `
                        -Type "Profile" `
                        -Info "[+] Successfully created"

                    if ( ( Test-Path "$( $d[0] )\StartLayout.xml" ) -eq $True )
                    {

                        Robocopy $d[0] $l[0] "StartLayout.xml"

                        Import-StartLayout `
                            -LayoutPath "$( $l[0] )\StartLayout.xml" `
                            -MountPath "$( $lm[2] )"

                        if ( $? -eq $True )
                        {
                            Wrap-Action `
                                -Type "Layout" `
                                -Info "[+] Import Successful"
                        }

                        else 
                        {
                            Wrap-Action `
                                -Type "Exception" `
                                -Info "[!] Layout was not imported successfully"
                        }
                    }

                    switch ( $host.UI.PromptForChoice( 
                    'Migrate-Account' , 
                    'Migrate an existing account, or skip ?' , 
                    [ System.Management.Automation.Host.ChoiceDescription [] ]@( 
                        '&Migrate' , 
                        '&Skip' ) , 
                    [int] 1 ) )
                    {
                        0
                        {
                            Wrap-Action -Type "Selected" -Info "Account Migration"

                            Robocopy $d[0] "$( $lm[2] )Users\$( $Username )\Desktop" "UEV-Profile.ps1"

                            if ( $? -eq $True )
                            {
                                Wrap-Action `
                                    -Type "Profile" `
                                    -Info "[+] Import Script copied Successful"
                            }

                            else
                            {
                                Wrap-Action `
                                    -Type "Exception" `
                                    -Info "[!] Import script failed to be copied"
                            }
                        }

                        1
                        {
                            Wrap-Action -Type "Selected" -Info "Bypass"
                        }
                    }

                    if ( $lm[0] -ne $r[2] ) 
                    {
                        Wrap-Action -Type "Relinquish" -Info "Deployment Credentials"
                        Disable-LocalUser -Name "$( $r[12] )" -Confirm
                    }
                }

            }
            else 
            { 
                    Wrap-Action `
                        -Type "Cancelled" `
                        -Info "The user either cancelled the dialog or it failed"
            }

            1
            { 
                Wrap-Action `
                    -Type "Skipping" `
                    -Info "User Account Generation"
            }
        }
    }
    $xaml = "" ; $NamedElement = "" ; $Profile = "" ; $Account = "" ; $UserAccount = "" ;

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Check-Activation ]- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function `
        -ID "Activate-Windows"
    
    Start-Process ms-settings:activation

    msinfo32

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Close-Script ]- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function `
        -ID "Close-Script"

        switch ( $host.UI.PromptForChoice( 
        'Close-Script' , 
        'You did stuff and things happened. [W]ait for some reason, or keep it real AF / [R]eboot ?' , 
        [System.Management.Automation.Host.ChoiceDescription[]]@( 
            '&Wait' , 
            '&Reboot' ) , 
        [int] 1 ) )
        {
            0
            {
                Wrap-Action `
                    -Type "Waiting" `
                    -Info "For things to like, do stuff. That's OK in my book."
                
                Start-Sleep `
                    -Seconds 3
                
                Display-Foot
                
                Start-Sleep `
                    -Seconds 3
                
                $r  = ""
                $b  = ""
                $lm = ""
                $l  = ""
                $d  = ""
                $ls = ""
                
                Exit 

            }
            
            1
            { 
                Wrap-Action `
                    -Type "Real AF" `
                    -Info "is how you chose to keep it. Honestly? That's cool AF."

                Start-Sleep `
                    -Seconds 3

                Display-Foot

                Start-Sleep `
                    -Seconds 3

                $r  = ""
                $b  = ""
                $lm = ""
                $l  = ""
                $d  = ""
                $ls = ""
                
                Restart-Computer 

            }
        }
    }

    Initialize-Hybrid