# On récuppère la liste des groupes dans l'AD
$glist = Get-ADGroup -Filter *

foreach($g in $glist)
{
    # Permet de récuppérer uniquement les groupes pertinents
    if($g.GroupScope -eq "Global")
    {
        echo $g.name
    }
}

# Input pour le nom du groupe
$ginput = Read-Host "Veuillez entrer le nom du groupe afin d'obtenir la liste des utilisateurs"

# On récuppère la liste de utilisateurs
$mlist = Get-ADGroupMember -Identity $ginput

# On affiche la liste des utilisateurs puis on l'enregistre dans un fichier texte
foreach($m in $mlist)
{
    echo "`n__Nom__"$m.name"Distinguished Name : $m"
    Add-Content -Path "Projet07_kaawach_AD02.txt" -Value $m.name
    Add-Content -Path "Projet07_kaawach_AD02.txt" -Value "$m`n"
}

Start-Sleep -s 30
