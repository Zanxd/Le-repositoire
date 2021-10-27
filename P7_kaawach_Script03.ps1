# On récuppère le nom de l'utilisateur
$user = Read-Host "Veuillez entrer le nom de l'utilisateur afin d'obtenir la liste des groupes"

# On récuppère la liste des groupes dont il fait partie
$glist = Get-ADPrincipalGroupMembership $user

# On affiche le début de la liste (mise en forme)
echo "`nListe des groupes de $user :`n---"
Add-Content -Path "Projet07_kaawach_AD03.txt" -Value "`n[$user]:`n---"

# On affiche les groupes dont l'utilisateur fait partie
foreach($g in $glist)
{
    if($g.GroupScope -eq "Global")
    {
        echo $g.Name
        Add-Content -Path "Projet07_kaawach_AD03.txt" -Value $g.Name
    }
}

Start-Sleep -s 5