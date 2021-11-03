<#
.SYNOPSIS
Permet de lister les groupes auxquels un utilisateur fait partie et d'exporter cette liste dans un fichier .txt à la racine.
.DESCRIPTION
Documentation : https://github.com/Zanxd/Le-repositoire
Script créé le 10/10/2021 / Auteur : Majid KAAWACH / Version 1.1 (Groupe ACME)
#>

# On récuppère le nom de l'utilisateur
$user = Read-Host "Veuillez entrer le nom de l'utilisateur afin d'obtenir la liste des groupes"

# On récuppère la liste des groupes dont il fait partie
$glist = Get-ADPrincipalGroupMembership $user

# On affiche le début de la liste (mise en forme)
echo "`nListe des groupes de $user :`n---"

# Chemin du fichier d'exportation
$outfile = ".\Projet07_kaawach_AD03.txt"
Add-Content -Path $outfile -Value "`n[$user]:`n---"

# Crée le fichier d'exportation s'il n'existe pas encore
if(!(Test-Path -path $outfile))
{
    New-Item $outfile
}

# On affiche les groupes dont l'utilisateur fait partie
foreach($g in $glist)
{
    if($g.GroupScope -eq "Global")
    {
        echo $g.Name
        Add-Content -Path $outfile -Value $g.Name
    }
}

# On informe que la liste a été exportée tout en affichant son emplacement
echo "`n -> Liste exportée dans : $outfile "
Read-Host -Prompt "Appuyez sur la touche ENTREE pour quitter." 