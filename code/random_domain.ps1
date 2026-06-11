param([Parameter(Mandatory=$true)] $OUTputJSONFile,
[int] $UserCount,
[int]$GroupCount,
[int]$LocalAdminCount)


$group_names = [System.Collections.ArrayList](Get-Content "data/group_names.txt")
$first_names = [System.Collections.ArrayList](Get-Content "data/first_names.txt")
$last_names = [System.Collections.ArrayList](Get-Content "data/last_names.txt")
$passwords = [System.Collections.ArrayList](Get-Content "data/passwords.txt")

$groups = @()
$users = @()

#Default Count if not set

if ($UserCount -eq 0){
    $UserCount = 5
}

if ($GroupCount -eq 0){
    $GroupCount = 1
}

if ($LocalAdminCount -ne 0){
    $local_admin_indexes =@()
    while (( $local_admin_indexes | Measure-Object).Count -lt $LocalAdminCount){
        $random_index = (Get-Random -InputObject (1..($UserCount)) | Where-Object { $local_admin_indexes -notcontains $_})
        $local_admin_indexes += @($random_index)
    }
} 


for ( $i = 1; $i -le $GroupCount; $i++){
    $new_group = (Get-Random -InputObject $group_names)
    $group = @{"name" = "$new_group"}
    $groups += $group 
    $group_names.Remove($new_group)
}

for ( $i = 1; $i -le $UserCount; $i++){
    $first_name = (Get-Random -InputObject $first_names)
    $last_name = (Get-Random -InputObject $last_names)
    $password = (Get-Random -InputObject $passwords)
    
    $new_user = @{
        "name" = "$first_name $last_name"
        "password"="$password"
        "groups" = @((Get-Random -InputObject $groups).name)
    }
    
    if ($local_admin_indexes | Where { $_ -eq $i }){
        echo "user $i is local admin"
        $new_user["local_admin"] = $true
    }

    $users += $new_user
    $first_names.Remove($first_name)
    $last_names.Remove($last_name)
    $passwords.Remove($password)
}

echo @{
    "domain" = "FT.com"
    "groups" = $groups
    "users" = $users
} | ConvertTo-Json | Out-File $OUTputJSONFile

# echo $groups
