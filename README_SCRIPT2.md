# Script 2 - Liste des utilisateurs dans un groupe

Ce second script permet **lister les utilisateurs** appartenant à un groupe.
Une fois la liste affichée, le script l'exporte automatiquement dans un fichier .txt nommé "**Projet07_kaawach_AD02**" à la racine du disque C sur le serveur.

## Déroulement 
 1. Le script affiche la liste des groupes pertinents présents dans le domaine
 2. [Il demande ensuite de saisir le nom du groupe](#Groupe)
 3. [Il affiche la liste des utilisateurs](#Liste)
 4. [Puis il exporte automatiquement cette dernière dans un fichier .txt](#Exportation)

## Finalité
- Une **liste des utilisateurs** appartenant au groupe précédemment saisi est affichée dans le terminal PowerShell
- Cette liste est **exportée** dans un fichier .txt

## Utilisation

#### Groupe
![](https://imgur.com/N1AOSY2.png)Le script vous affichera la liste des groupes du domaine et vous demandera de saisir le nom de celui dont vous souhaitez obtenir la liste des utilisateurs y appartenant.

#### Liste
![](https://imgur.com/NAqsm7h.png)Le script créera le fichier "Projet07_kaawach_ADO2.txt" à la racine si le fichier n'est pas présent.
Ensuite il affichera la liste des utilisateurs dans le terminal et l'exportera dans le fichier texte précédemment cité.

#### Exportation

![](https://imgur.com/4Jl5oVJ.png)Le fichier .txt créé par le script lors de l'exportation.
