param(
    [Parameter(Mandatory=$true)] $JSONFile,
    [switch]$undo
)

function CreateADGroup(){
    param([Parameter(Mandatory=$true)] $groupObject)

    $name = $groupObject.name
    New-ADGroup -name $name -GroupScope Global
}
function RemoveADGroup(){
    param([Parameter(Mandatory=$true)] $groupObject)

    $name = $groupObject.name
    Remove-AdGroup -Identity $name -confirm:$false 
}


function CreateADUser(){
    param([Parameter(Mandatory=$true)] $userObject)

    #Get name from JSON object
    $name = $userObject.name
    $password = $userObject.password
    
    #Structure for username (first name,last name)
    $firstname, $lastname = $name.Split(" ")
    $username = ($firstname[0] + $lastname).ToLower()
    $samAccountName = $username
    $principalname = $username

    #Create AD user object

    New-ADUser -Name "$name" -GivenName $firstname -Surname $lastname -SamAccountName $SamAccountName -UserPrincipalName "$principalname@$Global:Domain" -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount

    #Add user to Group
    foreach($group_name in $userObject.groups) {
        try {
            Get-ADGroup -Identity "$group_name"
            Add-ADGroupMember -Identity $group_name -Members $username
        }
        catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
            Write-Warning "User $name NOT added to group $group_name because it does not exist"
        }
    }

}
function RemoveADUser(){
    param([Parameter(Mandatory=$true)] $userObject)
    $name = $userObject.name
    $firstname, $lastname = $name.Split(" ")
    $username = ($firstname[0] + $lastname).ToLower()
    $samAccountName = $username

    Remove-ADUser -Identity $samAccountName -confirm:$false 
}
function WeakenPasswordPolicy(){
    secedit /export /cfg C:\Windows\Tasks\secpol.cfg
    (Get-Content C:\Windows\Tasks\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0").replace("MinimumPasswordLength = 7", "MinimumPasswordLength = 1") | Out-File C:\Windows\Tasks\secpol.cfg
    secedit /configure /db c:\windows\security\local.sdb /cfg C:\Windows\Tasks\secpol.cfg /areas SECURITYPOLICY
    rm -force C:\Windows\Tasks\secpol.cfg -confirm:$false
}

function StrenghtPasswordPolicy(){
    secedit /export /cfg C:\Windows\Tasks\secpol.cfg
    (Get-Content C:\Windows\Tasks\secpol.cfg).replace("PasswordComplexity = 0", "PasswordComplexity = 1").replace("MinimumPasswordLength = 1", "MinimumPasswordLength = 7") | Out-File C:\Windows\Tasks\secpol.cfg
    secedit /configure /db c:\windows\security\local.sdb /cfg C:\Windows\Tasks\secpol.cfg /areas SECURITYPOLICY
    rm -force C:\Windows\Tasks\secpol.cfg -confirm:$false
}
WeakenPasswordPolicy

$json = (Get-Content $JSONFile | ConvertFrom-Json)

# Write-Host "Domain = '$Global:Domain'"
# Write-Host "UPN = '$principalname@$($Global:Domain)"

if (-not $undo) {
    WeakenPasswordPolicy

    foreach ($group in $json.groups) {
    CreateADGroup $group
    }

    foreach ($user in $json.users){
    CreateADUser $user
    }
}else{
    StrenghtPasswordPolicy

    foreach ($user in $json.users){
    RemoveADUser $user
    }
    foreach ($group in $json.groups) {
    Remove-AdGroup $group
    }

}

$Global:Domain = $json.domain 


#echo $json.users