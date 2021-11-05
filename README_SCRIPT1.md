# Script 1 - Création et configuration d'un nouvel utilisateur et d'un dossier partagé

Ce premier script permet de créer en quelques étapes un **nouvel utilisateur** Active Directory ainsi qu'un **dossier partagé** à son nom. Dans une volonté d'uniformisation, certaines informations sont automatiquement (pré)remplies (email, login...).

## Déroulement 
 1. [Le script exige d'insérer le prénom de l'utilisateur à créer](#Prénom)
 2. [Puis le nom de famille](#Nom)
 3. [Et enfin le numéro de téléphone](#Téléphone)
 4. [Une fenêtre s'ouvre et demande d'entrer les identifiants (un login généré a partir du nom est automatiquement suggéré)](#Identifiants)
 5. [Si le mot de passe est valide, le script demande une confirmation avant de continuer](#Confirmation)
 6. [Procède à la création de l'utilisateur, du dossier partagé et de sa configuration](#Résultat)

## Finalité
- Un nouvel utilisateur AD est créé avec les informations suivantes :
	-	Le nom complet
	-	L'adresse e-mail
	-	Le numéro de téléphone
	-	Un identifiant et un mot de passe

- Un dossier partagé (portant le nom de l'utilisateur) est créé dans le dossier "C:\Personnel" sur le serveur.
	- L'utilisateur possède les droits complets sur ce dernier.

## Utilisation
Un processus de saisie des informations débutera à l’exécution du script.
#### Prénom
![](https://imgur.com/i7RCFdF.png)
Le script vous demandera en premier lieu d'entrer le **prénom de l'utilisateur** à créer dans la fenêtre PowerShell, en confirmant à l'aide de la touche entrée.

#### Nom
![](https://imgur.com/4QfwIo9.png)
Ensuite il vous demandera d'entrer son **nom de famille**.

#### Téléphone
![](https://imgur.com/DChKEEI.png)
Puis le **numéro de téléphone**.

#### Identifiants
![](https://imgur.com/W4x9qf8.png)
Une fois le numéro saisi, une fenêtre s'ouvrira et vous demandera de **saisir les identifiants** désirés (un nom d'utilisateur est automatiquement suggéré par le script).
**Rappel** : Le mot de passe **doit respecter** les exigences de sécurité (minimum une minuscule, une majuscule, un chiffre, un caractère spécial et doit comporter au moins 7 caractères au total).

#### Confirmation
![](https://imgur.com/0s3Hf07.png)
Le script vous demandera enfin de confirmer ces informations en saisissant la lettre "**O**".
Si vous répondez par "**N**" vous recommencerez le processus de saisie des informations depuis le début.

#### Résultat

![](https://imgur.com/MkHGxBu.png)
L’utilisateur AD créé avec les informations saisies.

![](https://imgur.com/j9i0TOF.png)
![](https://imgur.com/Rfw4vfa.png)
Le dossier partagé créé à son nom (avec octroiement des droits d'accès complets).

## Explication technique

### Fonctions 
#### IsCredentialValid($password)
Cette fonction permet vérifier si le mot de passe répond aux exigences de complexité. 
Elle vérifie si le mot de passe entré dans la fonction répond à chaque exigence de complexité.

    $PassedEntries =
    @(
        $Password -cmatch "[a-z]"
        $Password -cmatch "[A-Z]"
        $Password -cmatch "[0-9]"
        $Password -cmatch "[^a-zA-Z0-9]"
    ).Where{$_}.Count
*Le mot de passe est comparé à chaque exigence de sécurité et la variable $PassedEntries est incrémentée si la vérification est passée.*

Si le mot de passe est valide (s'il passe les 4 vérifications) elle retourne un booléen $true. Sinon elle retourne $false.



