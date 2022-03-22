<#
Author: Jorge Chanco
Date Created: 22/03/2022
Description: Solution for IOOF code test requirement -ROBOT EXTENSION requirement
Input is from a folder the tester can access. This require an update
to point to tester's test folder.
Resulting output is displayed on the powershell prompt.
#>


# declare global variables and intial values
$global:x=0;
$global:y=0;
$global:f;

$global:FileData= Get-Content F:\RobotExt.txt;              #Input path will require udate.
$global:CharArray;
$global:CharSubArray;
$global:Robot=-1;

clear;         
            
#Check if field is numeric
function CheckInt ($tmp) {
    if (($tmp -match "^\d+$") -and
        ($tmp -le 5) -and
        ($tmp -ge 0))   
    {1}
    else {0}
}

#Check if field have valid position
function CheckPos ($tmp) {
    if (($tmp -ne "NORTH") -and 
        ($tmp -ne "SOUTH") -and 
        ($tmp -ne "EAST")  -and 
        ($tmp -ne "WEST"))
    {0}
    else {1}
}

#set starting position
function Place ($tmp) {
    $tmp
}

#advance one unit to the left of the x-axis. 
#max value is 0, otherwise robot will fall off the table.
#end result is ignored action
function MoveWest($x) {
    $x = ($x -as [int]) - 1; 
    if($x -le 0) {$x=0}
    $x
}

#advance one unit to the right of the x-axis.
#max value is 5, otherwise robot will fall off the table.
#end result is ignored action
function MoveEast($x) {
    $x = ($x -as [int]) + 1; 
    if($x -ge 5) {$x=5}
    $x
}

#advance one unit up of the y-axis.
#max value is 5, otherwise robot will fall off the table.
#end result is ignored action
function MoveNorth($y) {
    $y = ($y -as [int]) + 1
    if($y -ge 5) {$y=5}
    $y
}

#advance one unit down of the y-axis.
#max value is 0, otherwise robot will fall off the table.
#end result is ignored action
function MoveSouth($y) {
    $y = ($y -as [int]) - 1
    if($y -le 0) {$y=0}
    $y
}

#switch to the left side of current position
function FaceLeft($f) {
    switch($f) {
        'WEST' {$f = 'SOUTH'; break}
        'EAST' {$f = 'NORTH'; break}
        'NORTH'{$f = 'WEST' ; break} 
        'SOUTH'{$f = 'EAST' ; break}
    }   
    $f
}

#switch to the right side of current position
function FaceRight($f) {
    switch($f) {
        'WEST' {$f = 'NORTH'; break}
        'EAST' {$f = 'SOUTH'; break}
        'NORTH'{$f = 'EAST' ; break} 
        'SOUTH'{$f = 'WEST' ; break}
    }   
    $f
}

<#Main processing starts here.
  Read input file from F:\test.txt then process each record accordingly.
  If action is not valid, it will simply ignore that action and proceed to next record.
#>
$global:f = place($null);

$global:RobotArray = @();

ForEach ($gFile in $FileData ) {

	$global:CharArray=$gFile.Split();                                      #parse the PLACE record using SPACE as delimiter
	switch ($global:CharArray[0].ToUpper()) {
		'PLACE'	{$global:CharSubArray = $global:CharArray[1].Split(",");   #parse the rest of PLACE record using COMMA as delimiter
        
                 #validate the PLACE parameters are correct, otherwise ignore this action
                 if ((CheckInt($global:CharSubArray[0]) -eq 1) `
                 -and(CheckInt($global:CharSubArray[1]) -eq 1) `
                 -and(CheckPos($global:CharSubArray[2].ToUpper()) -eq 1 ) )
                    {$global:x = Place($global:CharSubArray[0]); 
                     $global:y = Place($global:CharSubArray[1]); 
                     $global:f = Place($global:CharSubArray[2].ToUpper());

                     $global:RobotArray +=  @($global:x+','+$global:y+','+$global:f);
                     #by default, 1st robot placed is ACTIVE robot. To change ACTIVE, the ROBOT action must be called.
                     if ($global:Robot -eq -1) {
                        $global:Robot++; }
                  }
                 break;
                 }
		'MOVE' { if ($global:f -ne $null) {
                 switch ($global:f) {
                    'West'  {$global:x = MoveWest($global:x); break}
                    'East'  {$global:x = MoveEast($global:x); break}
                    'North' {$global:y = MoveNorth($global:y);break}
                    'South' {$global:y = MoveSouth($global:y);break}
                    };
                 $global:RobotArray[$global:Robot] = ($global:x -as [string])+','+($global:y -as [string])+','+($global:f -as [string]);
                 };
                 break;
                }

		'LEFT' { if ($global:f -ne $null) {
                    $global:f =  FaceLeft($global:f);
                    $global:RobotArray[$global:Robot] = ($global:x -as [string])+','+($global:y -as [string])+','+($global:f -as [string]);
                    }; 
               break
               }

		'RIGHT' { if ($global:f -ne $null) {
                    $global:f =  FaceRight($global:f); 
                    $global:RobotArray[$global:Robot] = ($global:x -as [string])+','+($global:y -as [string])+','+($global:f -as [string]);
                    }; 
               break
               }

		'REPORT' { if ($global:f -ne $null) {
		            write-host -NoNewLine 'Ouput: '$global:x','$global:y','$global:f','($global:Robot + 1)','$global:RobotArray.Count
                    write-host; write-host};
               break
               }
		'ROBOT' { if ($global:f -ne $null) {
                    $global:Robot = ($global:CharArray[1] - 1);
                    $global:CharSubArray = $global:RobotArray[$global:Robot].Split(",")
                    $global:x = Place($global:CharSubArray[0]); 
                    $global:y = Place($global:CharSubArray[1]); 
                    $global:f = Place($global:CharSubArray[2].ToUpper())};
               break
               } 

	}	
}

