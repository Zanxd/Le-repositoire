<#
.SYNOPSIS
Sauvegarde les données contenues dans "C:\Users" sur le serveur dans "C:\SAV$".
.DESCRIPTION
Documentation : https://github.com/Zanxd/Le-repositoire
Script créé le 10/10/2021 / Auteur : Majid KAAWACH / Version 1.1 (Groupe ACME)
#>

# Masque certaines erreurs durant la copie (accès refusés)
$ErrorActionPreference = 'SilentlyContinue'

# On récuppère la date et l'heure
$d = Get-Date -Format "[dd.MM.yyyy-HHmmss]"

# On crée une string avec la date, le nom de la machine et le nom de l'utilisateur connecté
$u = "$d$($env:COMPUTERNAME)_$($env:USERNAME)"

# Chemin des logs
$logpath = "\\SRVACMEPAR01\SAV$\Logs$\"

# On lance un transcript qui fera un rapport dans le dossier des logs, on crée le dossier de destination, puis on démarre la copie
Start-Transcript -OutputDirectory $logpath
New-Item -Path \\SRVACMEPAR01\SAV$\$u -ItemType Directory
Copy-Item -Path C:\Users\$env:USERNAME\ -Destination \\SRVACMEPAR01\SAV$\$u -Recurse -verbose
Stop-Transcript # Fin du rapport

# On récuppère le dernier fichier créé dans le dossier logs
$logfile = Get-ChildItem -Attributes !Directory -Path $logpath | Sort-Object -Descending -Property LastWriteTime | select -First 1

# Si l'opération est réussie, on rajoute ce message à la fin du log précédèment créé
if($?)
{
    Add-Content -Path $logfile.PSPath -Value "[V] Les fichiers ont été copiés avec succès."
}

# Sinon on renvoie un message d'erreur
else
{
    Add-Content -Path $logpath.PSPath -Value "[!] Une erreur s'est produite."
}