Import-Module ActiveDirectory

# Fonction qui vérifie si le mot de passe répond aux exigences de complexité (retourne un booléen $true ou $false)
function IsCredentialValid($Password)
{
    $PWPolicy = Get-ADDefaultDomainPasswordPolicy
    
    $PassedEntries =
    @(
        $Password -cmatch "[a-z]"
        $Password -cmatch "[A-Z]"
        $Password -cmatch "[0-9]"
        $Password -cmatch "[^a-zA-Z0-9]"
    ).Where{$_}.Count

    if($Password.Length -lt $PWPolicy.MinPasswordLength -or $PassedEntries -lt 4)
    {
        return $false
    }

    $true
}


# Boucle qui demande d'entrer les informations (réitérée si la confirmation est négative à la fin de l'instruction)
while($ans -notmatch "[oO]" -or $cvalid -ne $true)
{
    # On réinitialise la variable en cas de réitération
    if($c -ne $null)
    {
        $c = ""
    }

    # Initialisation de l'array
    $name = New-Object string[] 2


    # Réitère l'input si la string est vide ou contient autre chose que des lettres
    while($name[0] -notmatch "\S" -or $name[0] -notmatch "[a-z]")
    {
        # Input pour le prénom
        $name[0] = Read-Host "Veuillez entrer le prénom de l'utilisateur"
    }

    while($name[1] -notmatch "\S" -or $name[1] -notmatch "[a-z]")
    {
        # Input pour le nom
        $name[1] = Read-Host "Veuillez entrer le nom de l'utilisateur"
    }

    # Réitère l'input si la string est vide, si elle ne contient pas de chiffres ou qu'elle ne contient pas 10 caractères
    while($phone -notmatch "\S" -or $phone -notmatch "[0-9]" -or $phone.Length -lt 10)
    {
        # Input pour le numéro de téléphone
        $phone = Read-Host "Veuillez entrer le numéro de téléphone de l'utilisateur (uniquement les chiffres)"
    }

    # Suggestion de nom de login, qui sera automatiquement saisie lors du Get-Credential
    $LoginExemple = $name.Split(" ")
    $LoginExemple = $LoginExemple[0].SubString(0,1) + $LoginExemple[1]

    # On récupére dans une variable les identifiants du compte à créer
    $c = Get-Credential $LoginExemple -Message "Veuillez entrer les identifiants pour l'utilisateur à créer"

    # On utilise la fonction précédement créée pour vérifier le mot de passe
    try
    {
        $cvalid = IsCredentialValid -Password $c.GetNetworkCredential().Password
    }

    # Termine le script en cas d'abandon
    catch
    {
        echo "Erreur : Vous n'avez pas saisi d'identifiants."
        Start-Sleep -s 5
        Exit
    }

    if($cvalid)
    {
        # On affiche ces 2 variables
        echo "Nom : $name"
        echo "Login : $LoginExemple"

        # On demande une confirmation 
        $ans = Read-Host "Etes-vous sur de vouloir créer un nouvel utilisateur avec ces informations ? [o/n]"
    }
}

try
{
    # On récuppère le nom du login
    $clogin = $c.UserName

    # L'email est créée automatiquement en utilisant la suggestion de login
    $email = $LoginExemple.ToLower() + "@acme.fr"

    # Mise en forme du nom complet
    $name = $name[1].ToUpper() + " " + $name[0].SubString(0,1).ToUpper() + $name[0].SubString(1).ToLower()

    # On crée l'utilisateur ainsi qu'un dossier partagé à son nom
    New-ADUser -Name $name -SamAccountName $clogin -UserPrincipalName $clogin@acme.fr -EmailAddress $email -OfficePhone $phone -AccountPassword $c.Password -PasswordNeverExpires $true -Enabled $true
    New-Item -Path "c:\Personnel\" -Name $name -ItemType "directory"
    New-SmbShare -Name $name -Path "c:\Personnel\$name" -FullAccess "ACME\$clogin"

    echo "L'utilisateur a bien été créé !"
    Start-Sleep -s 5
}

# En cas d'erreur on affiche un message
catch
{
    "Une erreur s'est produite."
    echo $Error[0]
    Start-Sleep -s 5
}
