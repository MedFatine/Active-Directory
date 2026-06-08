param([Parameter(Mandatory=$true)] $JSONFile)

function CreateADGroup(){
    param([Parameter(Mandatory=$true)] $groupObject)

    $name = $groupObject.name
    New-ADGroup -name $name -GroupScope Global
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

$json = (Get-Content $JSONFile | ConvertFrom-Json)

# Write-Host "Domain = '$Global:Domain'"
# Write-Host "UPN = '$principalname@$($Global:Domain)"

$Global:Domain = $json.domain 

foreach ($group in $json.groups) {
    CreateADGroup $group
}

foreach ($user in $json.users){
    CreateADUser $user
}

#echo $json.users