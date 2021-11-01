<#
.SYNOPSIS
Permet de lister les utilisateurs appartenant à un groupe et d'exporter cette liste dans un fichier .txt à la racine.
.DESCRIPTION
Documentation : https://github.com/Zanxd/Le-repositoire
Script créé le 10/10/2021 / Auteur : Majid KAAWACH / Version 1.1 (Groupe ACME)
#>


# On récuppère la liste des groupes dans l'AD
$glist = Get-ADGroup -Filter *

echo "__Liste des groupes__"

foreach($g in $glist)
{
    # Permet de récuppérer uniquement les groupes pertinents
    if($g.GroupScope -eq "Global")
    {
        echo $g.name
    }
}

# Input pour le nom du groupe
$ginput = Read-Host "`nVeuillez entrer le nom du groupe afin d'obtenir la liste des utilisateurs"

# On récuppère la liste de utilisateurs
$mlist = Get-ADGroupMember -Identity $ginput

# Chemin du fichier d'exportation
$outfile = ".\Projet07_kaawach_AD02.txt"

# Crée le fichier d'exportation s'il n'existe pas encore
if(!(Test-Path -path $outfile))
{
    New-Item $outfile
}

echo "`nListe utilisateurs appartenants au groupe '$ginput' :"
Add-Content -Path $outfile -Value "Utilisateurs dans $ginput :"

# On affiche la liste des utilisateurs puis on l'enregistre dans un fichier texte
foreach($m in $mlist)
{
    echo "`n__Nom__"$m.name"Distinguished Name : $m"
    Add-Content -Path $outfile -Value $m.name
    Add-Content -Path $outfile -Value "$m`n"
}

echo "`n -> Liste exportée dans : $outfile "
Start-Sleep -s 30
