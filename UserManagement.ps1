# Import Active Directory Module
Import-Module ActiveDirectory

# Define input CSV file
$csvFile = "C:\Scripts\users.csv"

# Define a log file for auditing
$logFile = "C:\Scripts\UserManagement.log"

# Function to log actions
Function Write-Log {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $message" | Out-File -Append -FilePath $logFile
}

# Import CSV and process each user
$users = Import-Csv -Path $csvFile

foreach ($user in $users) {
    $fullName = "$($user.FirstName) $($user.LastName)"
    $username = $user.Username
    $ou = $user.OU
    $group = $user.Group
    $enabled = [System.Convert]::ToBoolean($user.Enabled)

    # Check if the user already exists
    if (Get-ADUser -Filter {SamAccountName -eq $username}) {
        Write-Log "User $username already exists. Skipping..."
        Continue
    }

    # Create new AD user
    try {
        New-ADUser -SamAccountName $username `
                   -UserPrincipalName "$username@example.com" `
                   -Name $fullName `
                   -GivenName $user.FirstName `
                   -Surname $user.LastName `
                   -Path $ou `
                   -AccountPassword (ConvertTo-SecureString "TempPass123!" -AsPlainText -Force) `
                   -Enabled $enabled `
                   -PassThru | Set-ADUser -ChangePasswordAtLogon $true

        Write-Log "Created user $username in $ou."

        # Add user to specified group
        if ($group -ne "") {
            Add-ADGroupMember -Identity $group -Members $username
            Write-Log "Added user $username to group $group."
        }

    } catch {
        Write-Log "Error creating user $username: $_"
    }
}

Write-Log "User creation process completed."
