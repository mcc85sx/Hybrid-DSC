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

$0 = [ Security.Principal.WindowsPrincipal ][ Security.Principal.WindowsIdentity ]::GetCurrent() ,
     [ Security.Principal.WindowsBuiltInRole ]'Administrator' , 
     [ int ]( Get-CimInstance Win32_OperatingSystem ).BuildNumber
     
if ( $0[0].IsInRole($0[1]) ) 
{ 
    Set-ExecutionPolicy ByPass `
        -Scope Process `
        -Force
    
    echo "Granted" 
}
else
{ 
    if ( $0[2] -ge 6000) {
        Start-Process `
            -FilePath PowerShell.exe `
            -Verb Runas `
            -Args "-File `"" + $MyInvocation.MyCommand + "`" " + $MyInvocation.UnboundArguments

        if ( $? -eq $true ) 
        { 
            echo "Script was elevated to Administrator Access"
            Return
        }
        else
        {
            echo "Access Denied"
            Read-Host "Press Enter to exit"
            Exit
        }
    }
}

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Initialize-Hybrid ] - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
    
    Function Initialize-Hybrid 
    {
        [CmdLetBinding()]
            Param()

            $hybrid = "Initialize-Hybrid.ps1"
            $fs = " // "
            $bs = " \\ " 
            $RootVar_ini = "$home\Desktop\RootVar.ini"

    
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
     
    # Module that exports hashtables with keys into INI file ( Modified a little, from TechNet )

    Function Export-Ini 
    {
        [ CmdletBinding () ]
            
            Param(  

                [ Switch ] $Append,

            [ ValidateSet ( 
                "Unicode" , "UTF7" , "UTF8" , "UTF32" , "ASCII" , 
                "BigEndianUnicode" , "Default" , "OEM" ) ]

            [ Parameter () ]
                
                [ String ] $Encoding,
        
        [ ValidateNotNullOrEmpty () ]

        [ ValidatePattern ('^([a-zA-Z]\:)?.+\.ini$') ]

            [ Parameter ( Mandatory = $True ) ]

                [ String ] $FilePath ,
        
                [ Switch ] $Force,
        
        [ ValidateNotNullOrEmpty () ]

            [ Parameter ( ValueFromPipeline = $True , Mandatory = $True ) ]

                [ Hashtable ] $InputObject,
        
                [ Switch ] $Passthru )

        Begin 
        { 
            Wrap-Action `
                -Type "Processing" `
                -Info "$( $MyInvocation.MyCommand.Name )" 
        }
        
        Process 
        { 
            Wrap-Action `
                -Type "Writing" `
                -Info "$( $FilePath )"

            if ( $Append ) 
            { 
                $Outfile = Get-Item $FilePath 
            }  
            else 
            { 
                $OutFile = New-Item `
                    -ItemType File `
                    -Path $FilePath `
                    -Force:$Force
            }

            if ( ! ( $OutFile ) ) 
            {
                Wrap-Action `
                    -Type "Exception" `
                    -Info "Unable to access file" 
            }

            ForEach ( $q in $InputObject.Keys )
            { 
                if ( ! ( $( $InputObject[$q].GetType().Name ) -eq "Hashtable" ) ) 
                { 
                    Wrap-Action `
                        -Type "Key" `
                        -Info "[+] $q"

                    Add-Content `
                        -Path $OutFile `
                        -Value "$q=$( $InputObject[$q] )" `
                        -Encoding $Encoding 
                }
                else 
                {
                    Wrap-Action `
                        -Type "Section" `
                        -Info "[+] $q"

                    Add-Content `
                        -Path $OutFile `
                        -Value "[$q]" `
                        -Encoding $Encoding
                }

                foreach ( $z in $($InputObject[$q].Keys | Sort-Object ) )
                { 
                    if ( $z -Match "^Comment[\d]+" ) 
                    {  
                        Wrap-Action `
                            -Type "Property" `
                            -Info "[+] $z"

                        Add-Content `
                            -Path $OutFile `
                            -Value "$( $InputObject[$q][$j] )" `
                            -Encoding $Encoding 
                    }
                    else
                    {  
                        Wrap-Action `
                            -Type "Key" `
                            -Info "[+] $z"

                        Add-Content `
                            -Path $OutFile `
                            -Value "$z=$( $InputObject[$q][$z] )" `
                            -Encoding $Encoding
                    }
                }
            
            Add-Content `
                -Path $OutFile `
                -Value "" `
                -Encoding $Encoding
            }

            Wrap-Action `
                -Type "Completed" `
                -Info "$( $MyInvocation.MyCommand.Name ): $FilePath"

            If ( $PassThru ) 
            { 
                Return $OutFile 
            }
        }
         
        End 
        { 
            Wrap-Action `
                -Type "Exiting" `
                -Info "$( $MyInvocation.MyCommand.Name )" 
        } 
    }

    Function Display-TrueColors 
    { 
        $flag = @(
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
    "$fs                                                                                                        $bs";
    )

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

    Wrap-Array `
        -Block $flag
    
    Start-Sleep -Seconds 2
    
    }

    Function Display-Logo 
    { 
        $logo = @(
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
    " //- - - - - - - - - - - - -                                                     - - - - - - - - - - - - - - \\ ";
    " \\ - - - - - - - - - - - -                   {_______________}                   - - - - - - - - - - - - - -// ";
    " //- - - - - - - - - - - -     {__________{ _ _]             [_ _ }__________}     - - - - - - - - - - - - - \\ ";
    " \\ - - - - - - - - - - -   {_ _ _ _ _{_______]  H Y B R I D  [______}_ _ _ _ _}    - - - - - - - - - - - - -// ";
    " //- - - - - - - - - - -  { _ _ _ _ { _ _ _ _ _]             [_ _ _ _ _ } _ _ _ _ }  - - - - - - - - - - - - \\ ";
    " \\ - - - - - - - - - -          { _ _ _ _ _ _]      B Y      [_ _ _ _ _ _ }          - - - - - - - - - - - -// ";
    " //- - - - - - - - - - -                                                             - - - - - - - - - - - - \\ ";
    " \\ - - - - - - - - - - -      [  S E C U R E   D I G I T S   P L U S   L L C  ]    - - - - - - - - - - - - -// ";
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

    Wrap-Array `
        -Block $logo
        
    Start-Sleep -Seconds 2
    
    }


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

    Function Load-HybridGUI {

    
    $xaml = @"
    <Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="[ Secure Digits Plus LLC | Hybrid ] Desired State Controller" Width="480" Height="800" WindowStartupLocation="CenterScreen"
    Topmost="True" HorizontalAlignment="Center" ResizeMode="NoResize">
    <StackPanel>
        <StackPanel Margin="10,10,10,10" Width="450" Height="175">
        </StackPanel>
        <StackPanel Height="544">
            <TabControl Height="495" Margin="10,10,10,10" VerticalAlignment="Center">
                <TabItem Header="Root Variables" HorizontalAlignment="Center" Width="100">
                    <GroupBox Header="[ #Hybrid ] Provisional Preferences" HorizontalAlignment="Left" Height="450" Margin="5,5,5,5" VerticalAlignment="Top" Width="425">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="1*"/>
                                <ColumnDefinition Width="1.5*"/>
                            </Grid.ColumnDefinitions>
                            <Grid.RowDefinitions>
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                                <RowDefinition Height = "*" />
                            </Grid.RowDefinitions>
                            <TextBlock Grid.Column="0" Grid.Row="0" Margin="5" FontSize="10" HorizontalAlignment="Right">Organization (Provisionary):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="1" Margin="5" FontSize="10" HorizontalAlignment="Right">Network Path (Provisional Share):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="2" Margin="5" FontSize="10" HorizontalAlignment="Right">Hostname/IP (Provisional Server):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="3" Margin="5" FontSize="10" HorizontalAlignment="Right">Parent Admin (Provisional User):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="4" Margin="5" FontSize="10" HorizontalAlignment="Right">Parent P/W (Provisional Password):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="5" Margin="5" FontSize="10" HorizontalAlignment="Right">OEM WWW (Provisional Website):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="6" Margin="5" FontSize="10" HorizontalAlignment="Right">OEM Phone (Provisional Phone):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="7" Margin="5" FontSize="10" HorizontalAlignment="Right">OEM Hours (Provisional Share):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="8" Margin="5" FontSize="10" HorizontalAlignment="Right">OEM Logo (120x120.bmp):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="9" Margin="5" FontSize="10" HorizontalAlignment="Right">OEM Background (Any Format):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="10" Margin="5" FontSize="10" HorizontalAlignment="Right">OEM Branch (Current Location):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="11" Margin="5" FontSize="10" HorizontalAlignment="Right">Network ID (Domain/Workgroup):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="12" Margin="5" FontSize="10" HorizontalAlignment="Right">Child Admin (Provisioning Admin):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="13" Margin="5" FontSize="10" HorizontalAlignment="Right">Child P/W (Provisioning Password):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="14" Margin="5" FontSize="10" HorizontalAlignment="Right">Proxy Host (Provisional Proxy):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="15" Margin="5" FontSize="10" HorizontalAlignment="Right">NetBIOS ID (Domain/Workgroup):</TextBlock>
                            <TextBlock Grid.Column="0" Grid.Row="16" Margin="5" FontSize="10" HorizontalAlignment="Right">Server Local Deployment URI:</TextBlock>
                            <TextBox Name="r0" Grid.Column="1" Grid.Row="0" Height="24" FontSize="10" Margin="5"></TextBox>
                            <TextBox Name="r1" Grid.Column="1" Grid.Row="1" Height="24" FontSize="10" Margin="5"></TextBox>
                            <TextBox Name="r2" Grid.Column="1" Grid.Row="2" Height="24" FontSize="10" Margin="5"></TextBox>
                            <TextBox Name="r3" Grid.Column="1" Grid.Row="3" Height="24" FontSize="10" Margin="5"></TextBox>
                            <PasswordBox Name="r4" PasswordChar="*" Grid.Column="1" Grid.Row="4" Height="24" FontSize="10" Margin="5"></PasswordBox>
                            <TextBox Name="r5" Grid.Column="1" Grid.Row="5" Height="24" FontSize="10" Margin="5"></TextBox>
                            <TextBox Name="r6" Grid.Column="1" Grid.Row="6" Height="24" FontSize="10" Margin="5"></TextBox>
                            <TextBox Name="r7" Grid.Column="1" Grid.Row="7" Height="24" FontSize="10" Margin="5"></TextBox>
                            <TextBox Name="r8" Grid.Column="1" Grid.Row="8" Height="24" FontSize="10" Margin="5"></TextBox> 
                            <TextBox Name="r9" Grid.Column="1" Grid.Row="9" Height="24" FontSize="10" Margin="5"></TextBox>
                            <TextBox Name="r10" Grid.Column="1" Grid.Row="10" Height="24" FontSize="10" Margin="5"></TextBox>
                            <TextBox Name="r11" Grid.Column="1" Grid.Row="11" Height="24" FontSize="10" Margin="5"></TextBox>
                            <TextBox Name="r12" Grid.Column="1" Grid.Row="12" Height="24" FontSize="10" Margin="5"></TextBox>
                            <PasswordBox Name="r13" PasswordChar="*" Grid.Column="1" Grid.Row="13" Height="24" FontSize="10" Margin="5"></PasswordBox>
                            <TextBox Name="r14" Grid.Column="1" Grid.Row="14" Height="24" FontSize="10" Margin="5"></TextBox>
                            <TextBox Name="r15" Grid.Column="1" Grid.Row="15" Height="24" FontSize="10" Margin="5"></TextBox>
                            <TextBox Name="r16" Grid.Column="1" Grid.Row="16" Height="24" FontSize="10" Margin="5"></TextBox>
                        </Grid>
                    </GroupBox>
                </TabItem>
            </TabControl>
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Center">
                <Button Name="Start" Margin="0,0,15,0" Height="20" Content="Start" Width="120"/>
                <Button Name="Close" Margin="15,0,0,0" Height="20" Content="Close" Width="120"/>
            </StackPanel>
        </StackPanel>
    </StackPanel>
</Window>
"@

    Function Convert-XAMLToWindow 
    { 
        Param(
            [ Parameter ( Mandatory ) ]
                [ string ] $XAML,
                [ string [] ] $NamedElement = $null,
                [ switch ] $PassThru )

        Add-Type `
            -AssemblyName PresentationFramework
        Add-Type `
            –AssemblyName PresentationCore
        Add-Type `
            –AssemblyName WindowsBase

        $reader = [ XML.XMLReader ]::Create([ IO.StringReader ] $XAML )
        $Output = [ Windows.Markup.XAMLReader ]::Load( $reader )
    
        foreach( $Name in $NamedElement )
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
        Param (
            [ Parameter ( Mandatory ) ][ Windows.Window ] $GUI )

        $Output = $null

        $null   = $GUI.Dispatcher.InvokeAsync{ 
   
            $Output = $GUI.ShowDialog()
        
            Set-Variable `
                -Name Output `
                -Value $Output `
                -Scope 1 

        }.Wait()

        $Output

    }
    
    $GUI = Convert-XAMLToWindow `
        -XAML $xaml `
        -NamedElement 'r0','r1','r2','r3','r4','r5','r6','r7','r8','r9','r10','r11','r12','r13','r14','r15','r16','Start','Close' `
        -PassThru

    $GUI.Close.add_Click({ $GUI.DialogResult = $false })
    
    $GUI.Start.add_Click( 
    {   
        if     (  $GUI.r0.Text -eq "" ) 
        { 
            [ System.Windows.MessageBox ]::Show( 
                'Example : "Secure Digits Plus LLC"' , 
                'Provisionary Missing' ) 
        }
        elseif (  $GUI.r1.Text -eq "" ) 
        { 
            [ System.Windows.MessageBox ]::Show( 
                'Example : "\\DSC2\Secured$"' , 
                'Deployment Share Missing' ) 
        }
        elseif (  $GUI.r2.Text -eq "" )
        {
            [ System.Windows.MessageBox ]::Show( 
                'Example : "DSC2"' , 
                'Deployment Server Missing' ) 
        }
        elseif (  $GUI.r3.Text -eq "" )
        {
            [ System.Windows.MessageBox ]::Show( 
                'Example : "Hybrid"' , 
                'Source Admin Username Missing' ) 
        }
        elseif (  $GUI.r4.Password -eq "" )
        {
            [ System.Windows.MessageBox ]::Show( 
                'Example : "Power$hell!"' , 
                'Source Admin Password Missing' ) 
        }
        elseif (  $GUI.r5.Text -eq "" )
        {
            [ System.Windows.MessageBox ]::Show( 
                'Example : "https://www.securedigitsplus.com" ) ' , 
                'Support Website Missing' ) 
        }
        elseif (  $GUI.r6.Text -eq "" )
        {
            [ System.Windows.MessageBox ]::Show( 
                'Example : "(802) 447-8528" ' , 
                'Support Phone Number Missing' ) 
        }
        elseif (  $GUI.r7.Text -eq "" )
        {
            [ System.Windows.MessageBox ]::Show( 
                'Example : "24h/d, 7d/w, 365.25d/y"' , 
                'Provisional Support Hours Missing' ) 
        }
        elseif (  $GUI.r8.Text -eq "" )
        {
            [ System.Windows.MessageBox ]::Show( 
                'Example : "OEMlogo.bmp"' , 
                'Provisional Logo Missing' ) 
        }
        elseif (  $GUI.r9.Text -eq "" )
        {
            [ System.Windows.MessageBox ]::Show( 
                'Example : "OEMbg.jpg"' , 
                'Provisional Background Missing' )
        }
        elseif ( $GUI.r11.Text -eq "" )
        { 
            [ System.Windows.MessageBox ]::Show( 
                'Example : "vermont.securedigitsplus.com"' , 
                'Deployment Admin Username Missing' )
        }
        elseif ( $GUI.r12.Text -eq "" )
        {
            [ System.Windows.MessageBox ]::Show( 
                'Example : "Administrator"' , 
                'Target Username Missing' ) 
        }
        elseif ( $GUI.r13.Password -eq "" )
        {
            [ System.Windows.MessageBox ]::Show( 
                'Example : "Power$hell!"' , 
                'Target Password Missing' ) 
        }
        elseif ( $GUI.r15.Text -eq "" )
        { 
            [ System.Windows.MessageBox ]::Show( 
                'Example : "SECURED" or "DSC2\Hybrid" )' , 
                'Provisional Support Hours Missing' ) 
        }
        elseif ( $GUI.r16.Text -eq "" )
        {
            [ System.Windows.MessageBox ]::Show( 
                'Example : "C:\Secured"' , 
                'Provisional Logo Missing' ) 
        }
        else 
        { 
            $GUI.DialogResult = $true 
        } 
    })

        # Defaults for Hybrid-DSC ( If RootVar.ini is not detected )

        $GUI.r0.Text       = "Secure Digits Plus LLC"
        $GUI.r1.Text       = "\\DSC2\Secured$"
        $GUI.r2.Text       = "DSC2"
        $GUI.r3.Text       = "Hybrid"
        $GUI.r4.Password   = ""
        $GUI.r5.Text       = "https://www.securedigitsplus.com"
        $GUI.r6.Text       = "(802) 447-8528 / (518) 406-8569"
        $GUI.r7.Text       = "24h/d; 7d/w; 365.25d/y"
        $GUI.r8.Text       = "OEMlogo.bmp"
        $GUI.r9.Text       = "OEMbg.jpg"
        $GUI.r10.Text      = "Vermont"
        $GUI.r11.Text      = "vermont.securedigitsplus.com"
        $GUI.r12.Text      = "Administrator"
        $GUI.r13.Password  = ""
        $GUI.r14.Text      = "DSC2"
        $GUI.r15.Text      = "SECURED"
        $GUI.r16.Text      = "C:\Secured"

    $null = $GUI.r4.Focus()
    
    $output = Show-WPFWindow `
        -GUI $GUI
        
        if ( $output -eq $true )
        {   
            $rv = @{
             0  = $GUI.r0.Text  ; 
             1  = $GUI.r1.Text  ; 
             2  = $GUI.r2.Text  ;
             3  = $GUI.r3.Text  ; 
             4  = $GUI.r4.Password  ;
             5  = $GUI.r5.Text  ; 
             6  = $GUI.r6.Text  ; 
             7  = $GUI.r7.Text  ;
             8  = $GUI.r8.Text  ;
             9  = $GUI.r9.Text  ;
            10  = $GUI.r10.Text ;
            11  = $GUI.r11.Text ;
            12  = $GUI.r12.Text ; 
            13  = $GUI.r13.Password ;
            14  = $GUI.r14.Text ;
            15  = $GUI.r15.Text ;
            16  = $GUI.r16.Text 
            }

            New-Object -TypeName Hashtable $rv
            
            Set-Content `
                -Path $Rootvar_INI `
                -Value $rv[0..16] `
                -Force
        } 

        else 
        { 
            Wrap-Action `
                -Type "Exception" `
                -Info "User canceled out of the Root-Variable Dialog"
            
            Start-Sleep `
                -Seconds 3
            
            Exit 

        }
        
    }

    Wrap-Action `
        -Type "Initialized" `
        -Info "[ Secure Digits Plus LLC | Hybrid ] Desired State Controller"

    Start-Sleep `
        -Seconds 1
    
    Display-TrueColors
    
    Display-Logo 

if ( ( Test-Path $RootVar_ini ) -eq $true )
    {
        switch( $host.UI.PromptForChoice( 'Update-Root' , 'Root Variables found. Would you like to continue, update, or delete/change its location ?' , 
        [System.Management.Automation.Host.ChoiceDescription[]]@( '&Continue' , '&Update' , '&Change' ) , 
        [int] 0 )  )
        {
            0
            {
                echo "Will continue with current settings and default path"
            }

            1
            {
                Load-HybridGUI
            }

            2
            {
                Echo "Type file location for your variables/credentials"
                [string]$altvar_ini = Read-Host "Location"

                if ( ( Test-Path $altvar_INI ) -ne $True )
                { 
                    Wrap-Action `
                        -Type "Exception" `
                        -Info "[!] Listen path not found, launching GUI"

                    Load-HybridGUI
                }
                else
                {
                    Wrap-Action `
                        -Type "Detected" `
                        -Info "[+] Alternate Root Variables Loaded"

                    $Rootvar_ini = $Altvar_ini
                }
            }
        }
    }
   
    if ( ( Test-Path $Rootvar_ini ) -eq  $false ) 
    {
        Load-HybridGUI
    }   
        $rv = @( Get-Content $Rootvar_ini )

        $r = @( 0..16 | % { $rv[$_] })

        $r[4] = ConvertTo-SecureString $r[4] `
            -AsPlainText `
            -Force
        
        Wrap-Action `
            -Type "Secured" `
            -Info "[+] Deployment Administrator Account Password"

        $r[13] = ConvertTo-SecureString $r[13] `
            -AsPlainText `
            -Force
        
        Wrap-Action `
            -Type "Secured" `
            -Info "[+] Child Administrator Account Password" 

        $dccred = New-Object `
            -TypeName System.Management.Automation.PSCredential `
            -Args $r[3], $r[4]

        Wrap-Action `
            -Type "Established" `
            -Info "[+] Deployment Magistration Key"

        $lmcred = New-Object `
            -TypeName System.Management.Automation.PSCredential `
            -Args $r[12], $r[13]

        Wrap-Action `
            -Type "Established" `
            -Info "[+] Child Administration Key"

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Provisional Root ]- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function `
        -ID "Provisional-Root"

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
        
        $ds = "$dr\$( $r[0] )"

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

        if ( $lm[0] -eq $r[2] ) 
        { 
            $srv = "Yes" 
        }
        else
        {
            $srv = "No"
        }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -# # #
# - - - [ Hybrid Control Panel ]- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
# # #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

        Wrap-Title `
            -Title "Provisional-Root" 

        Wrap-Section `
            -Section $Root[2][0]

        Wrap-ItemOut `
            -Type $Root[3][0] `
            -Info $r[0]

        Wrap-ItemIn  `
            -Type $Root[3][1] `
            -Info $r[1]

        Wrap-ItemOut `
            -Type $Root[3][2] `
            -Info $r[2]

        Wrap-ItemIn  `
            -Type $Root[3][3] `
            -Info $Root[0][0]

        Wrap-ItemOut `
            -Type $Root[3][4] `
            -Info $Root[0][1]

        Wrap-ItemIn  `
            -Type $Root[3][5] `
            -Info $Root[0][2]

        Wrap-ItemOut `
            -Type $Root[3][6] `
            -Info $Root[0][3]

        Wrap-ItemIn  `
            -Type $Root[3][7] `
            -Info $Root[0][4]

        Wrap-ItemOut `
            -Type $Root[3][8] `
            -Info $Root[0][5]

        Wrap-Section `
            -Section $Root[2][1]

        Wrap-ItemOut `
            -Type $Root[4][0] `
            -Info $srv

        Wrap-ItemIn  `
            -Type $Root[4][1] `
            -Info $lm[0]

        Wrap-ItemOut `
            -Type $Root[4][2] `
            -Info $lm[1]

        Wrap-ItemIn  `
            -Type $Root[4][3] `
            -Info $lm[2]

        Wrap-ItemOut `
            -Type $Root[4][4] `
            -Info $lm[3]

        Wrap-ItemIn  `
            -Type $Root[4][5] `
            -Info $lm[4]

        Wrap-ItemOut `
            -Type $Root[4][6] `
            -Info $lm[5]

        Wrap-Section `
            -Section $Root[2][2]

        Wrap-ItemOut `
            -Type $Root[5][0] `
            -Info $lm[0]

        Wrap-ItemIn  `
            -Type $Root[5][1] `
            -Info $Root[1][0]

        Wrap-ItemOut `
            -Type $Root[5][2] `
            -Info $Root[1][1]

        Wrap-ItemIn  `
            -Type $Root[5][3] `
            -Info $Root[1][2]

        Wrap-ItemOut `
            -Type $Root[5][4] `
            -Info $Root[1][3]

        Wrap-ItemIn  `
            -Type $Root[5][5] `
            -Info $Root[1][4]

        Wrap-ItemOut `
            -Type $Root[5][6] `
            -Info $Root[1][5]

        Wrap-In
        Wrap-Out
        Wrap-Bot
        
    Read-Host "Press (Enter) to continue"

    $d = $Root[0] ; $l = $Root[1] ;  $b = $Bridge ; $Root = "" ; $Bridge = "" ;

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#   [ Provision-Images ]   ############################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function `
        -ID "Provision-Images"

    $di     = $d[2]

    $dt     = "$dr\Operating Systems\Server" , 
              "$dr\Operating Systems\Client"

    $Date   = ( Get-Date -UFormat "%Y%m%d" ) , 
              ( "( " + ( Get-Date -UFormat "%m-%d-%Y" ) + " MC-SDP )")

    $N_A    = "Not Detected"

    $Tag    = "DC2016" , "10E64" , "10E86" , "10H64" , "10H86" , "10P64" , "10P86"
        
    $Wim    = @{

        Name   = @( ( "Windows Server 2016 Datacenter (x64)" ) ; 
                 @(   "Education" , "Home" , "Professional"  ) | % { 
                     "Windows 10 $_ (x64)" ; "Windows 10 $_ (x86)" } )

        Sign   = @( 0..6 | % { "$( $Date[1] ) [ $( $Tag[$_] ) ] " } )

        Build  = @( 0 | % { "10.0.14393.3025" } ; 1..6 | % { "10.0.18362.175" } )
        
        Major  = @( 0 | % { "2016" } ; 1..6 | % { "1903" } )
        
        Minor  = @( 0 | % { "(3025)" } ; 1..6 | % { "(175)" } ) 

        Author = @( 0..6 | % { ( $r[0] ) } ) }

    $Stamp = @( 0..6 | % { $wim.Build[$_] + ' [ ' + $wim.Major[$_] + ' ] '  } )


    $Dism=@( 0..6 ) 

    0..6 | % { $Dism[$_]=@( $Tag[$_] ; $Wim.Name[$_] ; $Wim.Sign[$_] ; $Stamp[$_] ; $Wim.Author[$_] ) }

    Function Get-WIMName {

        [ CmdLetBinding () ] Param(

            [ ValidateNotNullOrEmpty () ]

            [ Parameter ( Mandatory = $True , Position = 0 , ValueFromPipeline = $True ) ]

                [ String ] $IP ,

            [ ValidateNotNullOrEmpty () ]

            [ Parameter ( Position = 1 , ValueFromPipeline = $True ) ]

                [ String ] $ID )
        
        ( Get-WindowsImage -ImagePath $IP ).ImageName }


    Function Get-WIMBuild {

        [ CmdLetBinding () ] Param(

            [ ValidateNotNullOrEmpty () ]

            [ Parameter ( Mandatory = $True , Position = 0 , ValueFromPipeline = $True ) ]

                [ String ] $IP ,

            [ ValidateNotNullOrEmpty () ]

            [ Parameter ( Position = 1 , ValueFromPipeline = $True ) ]

                [ String ] $ID )

        ( Get-WindowsImage -ImagePath $IP -Index $ID ).Version }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Working WIM Files ]   ##########################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Action `
        -Type "Loading" `
        -Info "[+] DISM WIM Store"

    $wIndex  = ( GCI $di -EA 0 ).FullName[0..6]
    $wFiles  = ( GCI $wIndex -Filter "*.wim" -EA 0 )

    if ( ( Test-Path $wFiles.FullName[0..6] ) -ne $True ) { 
    
        $Store    = [Ordered] @{ 
            Name  = $N_A
            File  = $N_A 
            Tag   = $N_A 
            Path  = $N_A 
            Date  = $N_A 
            Full  = $N_A 
            Build = $N_A } } 

    else {  

    "When Detected"
        $Store    = [Ordered] @{ 
            Name  = ( 0..6 | % { ( Get-WIMName -IP $wFiles.FullName[$_] )        } )
            File  = ( 0..6 | % { $wfiles.Name[$_]                                } )
            Tag   = ( 0..6 | % { $wfiles.BaseName[$_]                            } )
            Path  = ( 0..6 | % { $wfiles.DirectoryName[$_]                       } )
            Date  = ( 0..6 | % { $wfiles.LastWriteTime[$_]                       } ) 
            Full  = ( 0..6 | % { $wfiles.Fullname[$_]                            } )
            Build = ( 0..6 | % { ( Get-WIMBuild -IP $wFiles.FullName[$_] -ID 1 ) } ) } }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Current Server WIM File ]   ####################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Action `
        -Type "Loading" `
        -Info "[+] MDT Server WIM Store"

    if ( ( GCI $dt[0] -EA 0 ) -ne $null )
    {
        $cIndexS  = ( GCI $dt[0] -EA 0 ).FullName
        $cFilesS  = ( GCI $cIndexS -Filter "*.wim" -EA 0 )

    if ( $cFilesS -eq $Null ) { 
    $CurrentS  = [Ordered] @{
        Name   = $N_A
        File   = $N_A 
        Tag    = $N_A 
        Path   = $N_A 
        Date   = $N_A 
        Full   = $N_A
        Build  = $N_A  } } 

    else 
    {
            if ( ( Test-Path ( $cIndexS + '\' + $cfilesS ) ) -eq $True )
            {
                $CurrentS  = [Ordered] @{ 
            Name   = "Windows Server 2016 Datacenter (x64)"
            File   = $cfilesS.Name
            Tag    = $cfilesS.BaseName
            Path   = $cfilesS.DirectoryName
            Date   = $cfilesS.LastWriteTime
            Full   = $cfilesS.Fullname
            Build  = ( Get-WIMBuild -IP $cFilesS.FullName -ID 1 )                                 } } } }

    else {
    $CurrentS  = [Ordered] @{
        Name   = $N_A
        File   = $N_A 
        Tag    = $N_A 
        Path   = $N_A 
        Date   = $N_A 
        Full   = $N_A
        Build  = $N_A  } }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Current Client WIM File ]   ####################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Action `
        -Type "Loading" `
        -Info "[+] MDT Client WIM Store"

    if ( ( GCI $dt[1] -EA 0 ) -ne $null )
    {
        $cIndexC  = ( GCI $dt[1] -EA 0 ).FullName
        $cFilesC  = ( GCI $cIndexC -Filter "*.wim" -EA 0 )

    if ( $cFilesC -eq $Null ) { 
    $CurrentC  = [Ordered] @{
        Name   = $N_A  
        File   = $N_A  
        Tag    = $N_A  
        Path   = $N_A 
        Date   = $N_A 
        Full   = $N_A 
        Build  = $N_A } }

    else
    {

        if ( ( Test-Path ( $cIndexC + '\' + $cfilesC ) ) -eq $True )
        {
            $CurrentC  = [Ordered] @{ 
                Name   = "Windows 10 Home/Education/Pro (x86/64)"
                File   = $cfilesC.Name
                Tag    = $cfilesC.BaseName
                Path   = $cfilesC.DirectoryName
                Date   = $cfilesC.LastWriteTime
                Full   = $cfilesC.Fullname
                Build  = ( Get-WIMBuild -IP $cFilesC.FullName -ID 1 ) } } } }

    else {
    $CurrentC  = [Ordered] @{
        Name   = $N_A
        File   = $N_A 
        Tag    = $N_A 
        Path   = $N_A 
        Date   = $N_A 
        Full   = $N_A
        Build  = $N_A  } }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Update WIM Files ]   ###########################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
        
    $Update   = [Ordered]  @{ 
        Name  = ( "Windows Server 2016 Datacenter (x64)" , "Windows 10 Home/Education/Pro (x86/64)" )
        File  = ( 0..1 | % { "$( $Date[0] )_$( $Wim.Major[$_] )_$( $Wim.Minor[$_] ).wim"          } )
        Tag   = ( 0..6 | % { $Tag[$_]                                                             } ) 
        Path  = $di
        Date  = $Date[0]
        Full  = ( 0..1 | % { ( "$di\$( $Date[0] )_$( $Wim.Major[$_] )_$( $Wim.Minor[$_] ).wim" )  } )
        Build = ( 0..1 | % { $Wim.build[$_]                                                    }  ) }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Stored WIM Info ]   ###########################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Title   `
        -Title   "Stored-WIM(S)"
    
    0..( $Store.File.Count - 1 ) | % {

        Wrap-Section `
            -Section $Store.Name[$_]

        Wrap-ItemOut `
            -Type    "[+] Path " `
            -Info $Store.Path[$_]

        Wrap-ItemIn  `
            -Type    "[+] File " `
            -Info $Store.File[$_]

        Wrap-ItemOut `
            -Type    "[+] Date " `
            -Info $Store.Date[$_]

        Wrap-ItemIn  `
            -Type    "[+] Build" `
            -Info $Store.Build[$_]

        Wrap-Out 
    }

    Wrap-Bot

    Read-Host "Verify list and press Enter to continue"

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Current WIM Info ]   ###########################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Title   `
        -Title   "Current-WIM(S)"
    $Current = @{ 0 = $CurrentS ; 1 = $CurrentC }

    0..1 | % {

        Wrap-Section `
            -Section $Current[$_].Name

        Wrap-ItemOut `
            -Type     "[+] Path " `
            -Info $Current[$_].Path

        Wrap-ItemIn  `
            -Type     "[+] File " `
            -Info $Current[$_].File

        Wrap-ItemOut `
            -Type     "[+] Date " `
            -Info $Current[$_].Date

        Wrap-ItemIn  `
            -Type     "[+] Build" `
            -Info $Current[$_].Build

        Wrap-Out
    
    }

    Wrap-Bot

    Read-Host "Press Enter to Continue"

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Update WIM Info ]   ############################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Title `
        -Title "Update-WIM(S)"

    0..( $Update.File.Count - 1 ) | % {
    
        Wrap-Section `
            -Section  $Update.Name[$_]

        Wrap-Itemout `
            -Type     "[+] Path " `
            -Info $Update.Path

        Wrap-ItemIn  `
            -Type     "[+] File " `
            -Info $Update.File[$_]

        Wrap-ItemOut `
            -Type     "[+] Date " `
            -Info $Update.Date

        Wrap-ItemIn  `
            -Type     "[+] Build" `
            -Info $Update.Build[$_]

        Wrap-Out 
    
    }

    Wrap-Bot

    Read-Host "Press Enter to Continue"

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ DISM-Server ]   ################################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Action `
        -Type "Processing" `
        -Info $Store.Name[0]

    echo $DISM

    if ( ( Test-Path  $Update.Full[0] ) -eq $True )
    {
        Remove-Item $Update.Full[0]
    }
    Robocopy $Store.Path[0] $di $Store.File[0]

    Rename-Item  ( "$di\$( $Store.File[0] )" ) `
        -NewName (        $Update.Full[0]    )

    if ( $? -eq $True ) 
    {
        Wrap-Action `
            -Type "Successful" `
            -Info "Server Image Updated" 
    }
    else
    {
        Wrap-Action `
            -Type "Failed" `
            -Info "Server Image not updated" 
    }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ DISM-Client ]   ################################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function -ID "Client-Image"

    if ( ( Test-Path $Update.Full[1] ) -eq $True ) 
    {
        Remove-Item $Update.Full[1]
    }

    1..6 | % {

        Wrap-Action `
            -Type "DISM" `
            -Info ( $Store.Name[$_] )

        echo "[ Current Image Info ]" ; "" ; $DISM[$_] ; ""

        Export-WindowsImage           `
            -SIP ( $Store.Full[$_]  ) `
            -SN  ( $Store.Name[$_]  ) `
            -DIP ( $Update.Full[1]  ) `
            -DN  ( $Store.Name[$_]  ) `
            -vb

        if ( $? -eq $True ) 
        {
            Wrap-Action `
                -Type "Update Successful" `
                -Info "[+] $( $Store.Name[$_] )"
        }
        else 
        { 
            Wrap-Action `
                -Type "Update Failure" `
                -Info "[!] $( $Store.Name[$_] )"
        }
    }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Recycle-MDT ]   ################################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function `
        -ID "Recycle-MDT" 
    
    # MDT Module/Drive Controls

    $MDTModule = "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
    $Drive     = "DS001"
    
    Import-Module $MDTModule

        $MDT = 
            "MDTProvider" , 
            $Drive , 
            "Administrators" , 
            ( $Drive + ":\Operating Systems\Server" ) , 
            ( $Drive + ":\Operating Systems\Client" ) ,
            ( $Drive + ":\Task Sequences\Server"    ) , 
            ( $Drive + ":\Task Sequences\Client"    ) , 
            $r[16] , 
            ( $r[16].Split('\')[1] + '$' ) ,
            $r[1] , 
            "$dr\Boot" , 
            "$dr\Operating Systems\Server" , 
            "$dr\Operating Systems\Client" , 
            "$dr\Scripts" , 
            "$dr\Control" , 
            ( $r[0] + ' [Production]' )
        
        $Drive = ( $Drive + ":" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ URI-Check ]   ##################################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

        if ( ( Test-Path ( $MDT[7] ) ) -ne $True )
        {
            New-Item `
                -Path     $MDT[7]   `
                -ItemType Directory `
                -Value    $MDT[7]

            if ( $? -eq $True ) 
            { 
                Wrap-Action `
                    -Type "Directory" `
                    -Info "[+] $( $MDT[7] ) created"
            }
            else
            { 
                Wrap-Action `
                    -Type "Exception" `
                    -Info "[!] $( $MDT[7] ) not created" 
            }
        }
        else
        {
            Wrap-Action `
                -Type "Folder Discovered" `
                -Info "[+] $( $MDT[7] )"
        }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ SMB-Check ]   ##################################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
        
        if ( ( Get-SMBShare -Name ( $MDT[8] ) -EA 0 ) -eq $Null )
        {
            Wrap-Action `
                -Type "SMB-Share" `
                -Info "Not Detected, creating"

            New-SMBShare `
                -Name        $MDT[8]  `
                -Path        $MDT[7]  `
                -ScopeName   $MDT[0]  `
                -Description $MDT[15] `
                -FullAccess  $MDT[2]

            if ( $? -eq $True ) 
            {
                Wrap-Action `
                    -Type "SMB-Share" `
                    -Info "[+] $( $MDT[15] )"      
            }
            else
            {
                Wrap-Action `
                    -Type "SMB-Share Exception" `
                    -Info "[!] $( $MDT[15] )"
            }
        }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ PersistentDrive-Check ]   ######################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

        $GetPSD = ( Get-MDTPersistentDrive -EA 0 )
        if ( ( ( Get-PSDrive -Name ( $GetPSD ).Name -EA 0 ) ) -eq $null )
        {
            Wrap-Action `
                -Type "Persistent Drive" `
                -Info "Not Detected, creating/opening"

            New-PSDrive `
                -Name                  ( $GetPSD ).Name  `
                -PSProvider              $MDT[0]         `
                -Root                    $MDT[7]         `
                -Description             $MDT[15]        `
                -NetworkPath             $MDT[9]         `
          | Add-MDTPersistentDrive       $MDT[1]

            if ( $? -eq $True )
            {
                Wrap-Action `
                    -Type "Persistent Drive" `
                    -Info "[+] $( $MDT[15] )"
            }
            else
            {
                Wrap-Action `
                    -Type "Persistent Drive" `
                    -Info "[!] $( $MDT[15] )"
            }
        }
        $GetPSD = "" ;

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ PSD-Check ]   ##################################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#    

        if ( ( Get-PSDrive -Name $MDT[1] ) -eq $null )
        {
            New-PSDrive `
                -Name            $MDT[1]  `
                -PSProvider      $MDT[0]  `
                -Root            $MDT[7]  `
                -Description     $MDT[15] `
                -NetworkPath     $MDT[9]
        }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ MDT-Children Check ]   #########################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

        $PSD   = @( $MDT[3..6] | % { $_ } ) + @( $MDT[11..12] | % { $_ } )

        $Path  = @( ( 0..1 | % { "$Drive\Operating Systems" } )
                    ( 2..3 | % { "$Drive\Task Sequences"    } )
                    ( 4..5 | % { "$dr\Operating Systems"    } ) )
                     
        $Name  = @( ( "Server" , "Client" | % { $_ } ) * 3 )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ MDT OS/TS Items Check ]   ######################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

        0..3 | % {

            if ( ( Test-Path $PSD[$_] ) -eq $true )
            { 
                Wrap-Action `
                    -Type "Path Found" `
                    -Info "[+] $( $PSD[$_] )"   
            }
        
            else    
            {
                New-Item `
                    -Path         $Path[$_]       `
                    -Enable       "True"          `
                    -Name         $Name[$_]        `
                    -Comments     "$( $Date[1] )" `
                    -ItemType     "Folder"        `
                    -vb

                if ( $? -eq $True )     
                { 
                    Wrap-Action `
                        -Type "Path Created" `
                        -Info "[+] $( $PSD[$_] )"
                }
                    
                else
                {
                    Wrap-Action `
                        -Type "Path Failure" `
                        -Info "[-] $( $PSD[$_] )" 
                }
            }
        }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ MDT-WIM Check ]   ##############################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

        4..5 | % {
            
            # If found, say so and skip

            if ( ( ( Test-Path $PSD[$_] ) -eq $True ) )
            { 
                Wrap-Action `
                    -Type "Path Found" `
                    -Info "[+] $( $PSD[$_] )"   
            }

            # If not, create and continue
            else           
            {       
                New-Item `
                    -Path         $PSD[$_] `
                    -ItemType     Directory `
                    -Value        $PSD[$_]
                        
                if ( $? -eq $True ) 
                { 
                    Wrap-Action `
                        -Type "Directory Created" `
                        -Info "[+] $( $PSD[$_] )" 
                }
                else 
                {
                    Wrap-Action `
                        -Type "Directory Failure" `
                        -Info "[!] $( $PSD[$_] )"
                }
            }
        }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Recycle-MDT ]   ################################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

        0..5 | % {

            $Name = @( gci ( $PSD[$_] ) -ea 0 )
            if ( $name.count -eq 1 )
            {
                if ( $Name -ne $null )
                {
                    Remove-Item ( $PSD[$_] + '\' + $Name.Name ) -recurse -vb -ea 0
                }
            }
            
            else
            {
                foreach ( $names in $name )
                {
                    if ( $Names -ne $null )
                    {
                        Remove-Item @( $PSD[$_] + '\' + $Names.Name ) -recurse -vb -ea 0
                    }
                }
            }
            
            if ( $? -eq $True )
            {
                Wrap-Action `
                    -Type "Removed" `
                    -Info "[+] $( $PSD[$_] ) Child Items"
            }
            
            else
            {
                Wrap-Action `
                    -Type "Exception" `
                    -Info "[-] $( $PSD[$_] ) Child Items"  
            }
        }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Import-NewOSImage ]   ##########################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Function Import-NewOSImage {

        [ CmdLetBinding () ] Param(

            [ ValidateNotNullOrEmpty () ]

            [ Parameter ( Mandatory = $True , Position = 0 , ValueFromPipeline = $True ) ]

            [ Alias ( "Path" ) ]

                [ String ] $IP ,

            [ ValidateNotNullOrEmpty () ]

            [ Parameter ( Mandatory = $True , Position = 1 , ValueFromPipeline = $True ) ]

            [ Alias ( "SourceFile" ) ]

                [ String ] $SF ,
                
            [ ValidateNotNullOrEmpty () ]

            [ Parameter ( Mandatory = $True , Position = 2 , ValueFromPipeline = $True ) ]
            
            [ Alias ( "DestinationFolder" ) ]

                [ String ] $DF )

                    Import-MDTOperatingSystem         `
                        -Path                 ( $IP ) `
                        -SourceFile           ( $SF ) `
                        -DestinationFolder    ( $DF ) `
                        -Move                         `
                        -Verbose
    }

    0..1 | % {

        if ( ( Test-Path $Update.Full[$_] ) -ne $True ) 
        {
            Wrap-Action `
                -Type "Image Missing" `
                -Info "[!] $( $Update.Full[$_] )" 
        }
        else                
        {
            Wrap-Action `
                -Type "Image Found" `
                -Info "[+] $( $Update.Full[$_] )"
        
        if ( $_ -eq 0 )
        {
            $Folder = "Server"
        }
        else
        {
            $Folder = "Client"
        }

            Import-NewOSImage `
                -IP   $PSD[$_] `
                -SF   $Update.Full[$_] `
                -DF   "$Folder\$( $Wim.Build[$_])"
            
            if ( $? -eq $True )
            {
                Wrap-Action `
                    -Type "Import Successful"         `
                    -Info "[+] $( $Update.Full[$_] )"
            }
            else
            {
                Wrap-Action `
                    -Type "Exception" `
                    -Info "[!] Import Failed"
            }
        }
    }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Import-NewTask ]   #############################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Function Import-NewTask {

        [ CmdLetBinding () ] Param(
            [ ValidateNotNullOrEmpty () ]
                [ Parameter ( Mandatory = $True , Position = 0 , ValueFromPipeline = $True ) ]
                    [ Alias ( "Path" ) ]
                    [ String ] $PSP ,

            [ ValidateNotNullOrEmpty () ]
                [ Parameter ( Mandatory = $True , Position = 1 , ValueFromPipeline = $True ) ]
                    [ Alias ( "Name" ) ]
                    [ String ] $Formal ,
       
            [ ValidateNotNullOrEmpty () ]
                [ Parameter ( Mandatory = $True , Position = 2 , ValueFromPipeline = $True ) ]
                    [ Alias ( "Template" ) ]
                    [ String ] $XML ,

            [ ValidateNotNullOrEmpty () ]
                [ Parameter ( Mandatory = $True , Position = 3 , ValueFromPipeline = $True ) ]
                    [ Alias ( "Comments" ) ]
                    [ String ] $Info ,

            [ ValidateNotNullOrEmpty () ]
                [ Parameter ( Mandatory = $True , Position = 4 , ValueFromPipeline = $True ) ]
                    [ String ] $ID ,

            [ ValidateNotNullOrEmpty () ]
                [ Parameter ( Mandatory = $True , Position = 5 , ValueFromPipeline = $True ) ]
                    [ Alias ( "Version" ) ]
                    [ String ] $Ver ,

            [ ValidateNotNullOrEmpty () ]
                [ Parameter ( Mandatory = $True , Position = 6 , ValueFromPipeline = $True ) ]
                    [ Alias ( "OperatingSystemPath" ) ]
                    [ String ] $SIP ,

            [ ValidateNotNullOrEmpty () ]
                [ Parameter ( Mandatory = $True , Position = 7 , ValueFromPipeline = $True ) ]
                    [ Alias ( "FullName" ) ]
                    [ String ] $TSName ,
                
            [ ValidateNotNullOrEmpty () ]
                [ Parameter ( Mandatory = $True , Position = 8 , ValueFromPipeline = $True ) ]
                    [ Alias ( "OrgName" ) ]
                    [ String ] $Org ,

            [ ValidateNotNullOrEmpty () ]
                [ Parameter ( Mandatory = $True , Position = 9 , ValueFromPipeline = $True ) ]
                    [ Alias ( "HomePage" ) ]
                    [ String ] $WWW ,

            [ ValidateNotNullOrEmpty () ]
                [ Parameter ( Mandatory = $True , Position = 10 , ValueFromPipeline = $True ) ]
                    [ Alias ( "AdminPassword" ) ]
                    [ String ] $LMCred )



        Import-MDTTaskSequence `
            -Path                $PSP    `
            -Name                $Formal `
            -Template            $XML    `
            -Comments            $Info   `
            -ID                  $ID     `
            -Version             $Ver    `
            -OperatingSystemPath $SIP    `
            -FullName            $TSName `
            -OrgName             $Org    `
            -HomePage            $WWW    `
            -AdminPassword       $lmcred `
            -Verbose
    }

    $Server = @{
        
        List     = @( GCI $PSD[0] -EA 0              )
        Template = @( "$di\Control\(0)Server\ts.xml" )

        }

    $Client = @{
            
        List     = @( GCI $PSD[1] -EA 0              )
        Template = @( "$di\Control\(1)Client\ts.xml" )
            
        }

    0..6 | % {

        if ( $_ -eq 0 )
        {
            $XML      = @( Get-Content $Server.Template )
            $x        = 341
            $PSP      = $MDT[5]
            $SIP      = "$( $MDT[3] )\$( $Server.List.Name )"
            $GUID     = $Server.List.GUID
        }

        else
        {
            $XML      = @( Get-Content $Client.Template )
            $x        = 394
            $PSP      = $MDT[6]
            $SIP      = "$( $MDT[4] )\$( $Client.List.Name[ ( $_ - 1 ) ] )"
            $GUID     = $Client.List.GUID[ ( $_ - 1 ) ]
        }

        foreach ( $i in 3, 10, $x )
        { 
            $XML[$i]  = $XML[$i].Split('{')[0] + $GUID + $XML[$i].Split('}')[1]
        }

        $XML_Path     = "$( $Store.Path[$_] )\$( $Tag[$_] ).xml"
        
        Set-Content `
            -Path     $XML_Path  `
            -Value    $XML       `
            -Force 
        
        $NT = @{
                        PSD_Path      = $PSP
                        Cool_ID       = $DISM[$_][1]
                        XML           = $XML_Path
                        Info          = $Date[1]
                        Tag_ID        = $DISM[$_][0]
                        Date          = $Date[0]
                        PS_SIP        = $SIP
                        Dumb_ID       = $DISM[$_][1]
                        Author        = $R[0]
                        Website       = $R[5]
                        ChildPW       = $lmcred.GetNetworkCredential().Password
                    }
        
        Wrap-Action `
            -Type "Import-NewTask" `
            -Info "[+] $( $DISM[$_][0] ) / $( $DISM[$_][1] )" 

        Import-NewTask `
                -PSP                $NT.PSD_Path  `
                -Formal             $NT.Cool_ID   `
                -XML                $NT.XML       `
                -Info               $NT.Info      `
                -ID                 $NT.Tag_ID    `
                -Ver                $NT.Date      `
                -SIP                $NT.PS_SIP    `
                -TSName             $NT.Dumb_ID   `
                -Org                $NT.Author    `
                -WWW                $NT.Website   `
                -LMCred             $NT.ChildPW   `

    }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Update-DSC ]   #################################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Action `
        -Type "[ MDT ]" `
        -Info "Updating PSDrive $( $MDT[1] ) Properties"
    
    $DSC =   ( $MDT[1] + ':' ) , 
            "Boot.x86" , 
            "Boot.x64" , 
            ".GenerateLiteTouchISO" , 
            ".LiteTouchWIMDescription" , 
            ".LiteTouchISOName" , 
            ".BackgroundFile"

    $n   =  "Comments" , 
            "MonitorHost" +  
            @( $DSC[3..6] | % { $DSC[1] + $_ } ) + 
            @( $DSC[3..6] | % { $DSC[2] + $_ } )

    $v   =  $Date[1] , 
            $r[2] , 
            "True" , 
            ( $r[0] + ' (x86)' ) , 
            ( $r[0] + ' (x86).iso' ) , 
            ( $d[0] + '\' + $r[9]  ) , 
            "True" , 
            ( $r[0] + ' (x64)' ) ,
            ( $r[0] + ' (x64).iso' ) , 
            ( $d[0] + '\' + $r[9] )

    $j = 0
    do
    {
        sp `
            -Path $DSC[0] `
            -Name $n[$j] `
            -Value $v[$j]
        
        Wrap-Action `
            -Type "Drive Property" `
            -Info "$($n[$j]) set to . . ."
        
        echo $v[$j]
        $j = $j + 1
    }
    until ( $j -ge $n.count )

    if ( $? -eq $True ) 
    { 
        Wrap-Action `
            -Type "[ MDT ]" `
            -Info "PSDrive $( $MDT[1]) Properties updated Successfully"
    }
    else
    { 
        Wrap-Action `
            -Type "[ MDT ]" `
            -Info "PSDrive $( $MDT[1]) Properties failed to update"
        
        break 
    }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Recycle-Bootstrap ]   ##########################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
    
    $Bootstrap_hash=@{
            
        Settings=@{
    
            Priority           = "Default"
    
            }

        Default=@{

            DeployRoot         = "$( '\\' + (Resolve-DNSName -name ($r[2])).IP4Address + '\' + $MDT[8] )"
            UserID             = "$( $r[3] )"
            UserPassword       = "$( $dccred.GetNetworkCredential().Password )"
            UserDomain         = "$( $r[15] )"
            SkipBDDWelcome     = "YES"

            }
        }
    
    $Bootstrap_ini = "$( $mdt[14] )\Bootstrap.ini"

    if ( ! ( Test-Path $Bootstrap_ini ) ) 
    { 
        Remove-Item $Bootstrap_ini -EA 0 -Force 
    }
    
    Export-Ini `
        -Filepath $Bootstrap_ini `
        -Encoding UTF8 `
        -Force `
        -InputObject $Bootstrap_hash `
        -Passthru

    [System.IO.File]::WriteAllLines( 
        ( $Bootstrap_ini ), 
        ( Get-Content $Bootstrap_ini ) , 
        ( New-Object System.Text.UTF8Encoding $False ) )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Recycle-CustomSettings ]   #####################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    $CustomSettings_hash=@{

        Settings=@{

            Priority           = "Default"
            Properties         = "MyCustomProperty"
        
            }
        
        Default=@{
        
            _SMSTSOrgName      = "$( $r[0] )"
            OSInstall          = "Y"
            SkipCapture        = "NO"
            SkipAdminPassword  = "YES"
            SkipProductKey     = "YES"
            SkipComputerBackup = "NO"
            SkipBitLocker      = "YES"
            KeyboardLocale     = "en-US"
            TimeZoneName       = "Eastern Standard Time"
            EventService       = "http://$( $r[2] ):9800"
        
            }
        }

    $CustomSettings_ini = "$( $MDT[14] )\CustomSettings.ini"
    
    if ( (Test-Path $CustomSettings_ini) -eq $True ) 
    {
        Remove-Item $CustomSettings_ini -EA 0 -Force
    }
    
    Export-Ini `
        -Filepath $CustomSettings_ini `
        -Encoding UTF8 `
        -Force `
        -InputObject $CustomSettings_hash `
        -Passthru

    [System.IO.File]::WriteAllLines( ( $CustomSettings_ini ) , 
        ( Get-Content $CustomSettings_ini ) , 
        ( New-Object System.Text.UTF8Encoding $False ) )


#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ MDT-PXE/Stuff  ]  ##############################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    $Icon = "$di\Control\computer.png"
    if ( ( test-path $icon ) -eq $True )
    {
        Copy-Item $Icon "$( $MDT[13] )\computer.png"
    }

    $head = "$di\Control\header-image.png"
    if ( ( test-path $head ) -eq $True )
    {
        Copy-Item $Head "$( $MDT[13] )\header-image.png"
    }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Hybrid-Launcher ]   ############################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    $Script = @(
@"
     `$0 = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent(),
     [Security.Principal.WindowsBuiltInRole]'Administrator', [int](Get-CimInstance Win32_OperatingSystem).BuildNumber ,
     "-File `"" + `$MyInvocation.MyCommand + "`" " + `$MyInvocation.UnboundArguments
     
    if ( `$0[0].IsInRole(`$0[1]) ) { Set-ExecutionPolicy ByPass -Scope Process -Force ; echo "Granted" }
    else
    { 
        if ( `$0[2] -ge 6000) {
            Start-Process -FilePath PowerShell.exe -Verb Runas -Args `$0[3] 
            if ( `$? -eq `$true ) { echo "Script was elevated to Administrator Access"            }
            else                { echo "Access Denied" ; Read-Host "Press Enter to exit" ; Exit }
        }
    }
    cmdkey /add:'$( $r[2] )' /user:'$( $r[3] )' /pass:'$( $dccred.GetNetworkCredential().Password )'
    Echo "Domain Credential Added"
    Copy-Item -Path "$( $r[1] + '\' + $r[0] )\(0)Resources\Initialize-HybridClient.ps1" -Destination "`$home\Desktop" -Force
    Set-Content -Path "`$home\Desktop\RootVar.ini" -Value (
    '$( $r[0] )'  , '$(  $r[1] )' , '$( $r[2] )' , '$( $r[3] )' , '$( $dccred.GetNetworkCredential().Password )' ,
    '$( $r[5] )'  , '$(  $r[6] )' , '$( $r[7] )' , '$( $r[8] )' , '$( $r[9] )' , '$( $r[10] )' ,
    '$( $r[11] )' , '$( $r[12] )' , '$( $lmcred.GetNetworkCredential().Password )' , '$( $r[14] )' ,
    '$( $r[15] )' , '$( $r[16] )'
    )
    `$hybrid = "`$home\Desktop\Initialize-Hybrid.ps1" ; if ( `$hybrid ) { Remove-Item ( `$hybrid ) }
    Start-Sleep -Seconds 2
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
    Powershell.exe "`$Home\Desktop\Initialize-HybridClient.ps1"
"@
)
    Set-Content -Path "$( $MDT[13] )\Initialize-Hybrid.ps1" -Value $Script -Force
    
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Update-BootImage ]   ###########################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    $Drive = ( $MDT[1] + ':' )
    switch( $host.UI.PromptForChoice( 'Recycle-MDT' , 'Select MDT Update Method' , 
    [System.Management.Automation.Host.ChoiceDescription[]]@( '&Full' , '&Fast' , '&Compress' ) , 
    [int] 0 )  )
    {
        0 { 
            Update-MDTDeploymentShare `
                -Path $Drive `
                -Force `
                -Verbose
          }
           
        1 { 
            Update-MDTDeploymentShare `
                -Path $Drive `
                -Verbose
          }

        2 { 
            Update-MDTDeploymentShare `
                -Path $Drive `
                -Compress `
                -Verbose 
          }
    } 

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ WDS-Controls ]   ###############################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    $Boot  = $MDT[10]
    $Lti   = "LiteTouchPE"
    $Pro   = $r[0].Replace(' ','_')
    $x86   = " (x86)"
    $x64   = " (x64)"
    $_86   = "_x86"
    $_64   = "_x64"

    $WDS=@( "$Boot\$Pro$_86.wim" ,
            "$Boot\$Pro$_64.wim" ,
            "$Boot\$Pro$_86.xml" ,
            "$Boot\$Pro$_64.xml"  )

    $LTW=@( "$Boot\$Lti$_86.wim" ,
            "$Boot\$Lti$_64.wim" ,
            "$Boot\$Lti$_86.xml" ,
            "$Boot\$Lti$_64.xml" )

    $PXE=@( $r[0]+$x86 ;
            $r[0]+$x64 )

    $IMG=@( Get-WDSBootImage -Architecture X86 -EA 0 -ImageName $PXE[0] ;
            Get-WDSBootImage -Architecture X64 -EA 0 -ImageName $PXE[1] )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Provisional-Boot.x86 ]   #######################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    0..3 | % {
        if ( ( Test-Path $WDS[$_] ) -eq $True )
        {
            Remove-Item $WDS[$_] -Force
            Rename-Item $LTW[$_] $WDS[$_]
        }
        else
        {
            Rename-Item $LTW[$_] $WDS[$_]
        }
    }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Cycle-BootImages ]   ###########################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    0..1 | % {

        if ( $_ -eq 0 ) 
        {
            $arch = "x86"
        }
        if ( $_ -eq 1 )
        {
            $arch = "x64"
        }

        if ( $IMG[$_].Description -eq $PXE[$_] )
        { 
            Remove-WdsBootImage         `
                -Architecture $arch     `
                -ImageName ( $PXE[$_] ) `
                -vb 
        }

        Wrap-Action `
            -Type "Recycling" `
            -Info "[+] WDS Boot Image  / $( $PXE[$_] )"

        Import-WDSBootImage `
            -Path           $WDS[$_] `
            -NewDescription $PXE[$_] `
            -SkipVerify -vb

        if ( $? -eq $True ) 
        { 
            Wrap-Action `
                -Type "Recycled" `
                -Info $WDS[$_] 
        }
    }

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#    [ Restart-WDS ]   ################################################################################
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

    Wrap-Function `
        -ID "Restart-WDS"

    Restart-Service `
        -Name WDSServer
    
    if ( $? -eq $true ) 
    { 
        Wrap-Action `
            -Type "WDS Image" `
            -Info "[+] Successfully updated!"
        
        Display-Foot

        Exit 
    }
    
    else
    {
        Wrap-Action `
            -Type "WDS Image" `
            -Info "[-] Update failed"

        Display-Foot

        Exit 
    }

}

Initialize-Hybrid