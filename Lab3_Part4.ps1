<#

Purpose:    3rd Powershell lab. Practice:
            Here-Strings
            Piping commands
            writing and reading files
            conditional logic

Author:     Tyler Zahuranec
File:       Lab3
Date:       Feb 20, 2020


#>

cls
Set-Location -Path $env:USERPROFILE
Get-ChildItem -path .\* -Include *.txt | Format-Table -Property Name, Length 

$userOption = @" 
What do you want to do?
    1. Write a contact entry to a file
    2. Display all files last written to after a given date
    3. Read a specified text file
    4. Cancel

"@
$userOption

$userChoice = Read-Host "Please enter your choice: "

if ($userChoice -eq 1) {
    $contact = Read-Host "What is the contact's name? "
    $contactNum = Read-Host "What is the contact's number? "
    $contactEmail = Read-Host "What is the contact's email? "
    $userFileChoice = Read-Host "What is the file that you want to save this to? "
    Add-Content $userFileChoice -Value "$contact `n$contactNum `n$contactEmail `n"
}
elseif ($userChoice -eq 2) {
    $userDate = Read-Host "What is the earliest date of files to display? "
    Get-ChildItem -Recurse | Where-Object {$_.LastWriteTime -ge $userDate} | Sort-Object LastWriteTime | Format-Table -Property Name, LastWriteTime 
}
elseif ($userChoice -eq 3) {
    $userFileRead = Read-Host "What is the name of the file you want to read? "
        if(Test-Path $userFileRead) {
            Get-Content $userFileRead
        }
        else {
            Write-Output "That file does not exist!"
        }
}
elseif ($userChoice -eq 4) {
    $exitScript = Read-Host "Are you sure you want to exit?"
        if ($exitScript -eq "yes"){
            Pause
            Exit
        }
        else{
            Exit
        }
}
else {
    Write-Output @"
    You didn't input a valid option!

    Computer Name: $env:computername
    Username:      $env:username
"@
}