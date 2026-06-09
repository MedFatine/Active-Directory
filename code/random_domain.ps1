param([Parameter(Mandatory=$true)] $OUTputJSONFile)


$group_names = [System.Collections.ArrayList](Get-Content "data/group_names.txt")
$first_names = [System.Collections.ArrayList](Get-Content "data/first_names.txt")
$last_names = [System.Collections.ArrayList](Get-Content "data/last_names.txt")
$passwords = [System.Collections.ArrayList](Get-Content "data/passwords.txt")

$groups = @()
$users = @()

$num_groups = 10 
for ( $i = 0; $i -lt $num_groups; $i++){
    $new_group = (Get-Random -InputObject $group_names)
    $group = @{"name" = "$new_group"}
    $groups += $group 
    $group_names.Remove($new_group)
}
$num_users = 100 
for ( $i = 0; $i -lt $num_users; $i++){
    $first_name = (Get-Random -InputObject $first_names)
    $last_name = (Get-Random -InputObject $last_names)
    $password = (Get-Random -InputObject $passwords)
    
    $new_user = @{
        "name" = "$first_name $last_name"
        "password"="$password"
        "groups" = @((Get-Random -InputObject $groups).name)
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
