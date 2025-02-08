# Project 1: Automated User Account Management (PowerShell)  

## Overview  
This project automates user account management tasks within a Windows Active Directory (AD) environment using a PowerShell script. The script streamlines the process of creating, managing, and auditing user accounts efficiently.  

### Features:  
- Create new user accounts from a CSV file.  
- Assign users to specific security groups.  
- Enable or disable accounts as needed.  
- Log all actions for auditing and troubleshooting.  

## Prerequisites  

### 1. Active Directory Module for PowerShell  
- Ensure the "Active Directory" module is installed. If using a domain-joined machine, it should be available by default.  
- If not installed, install the Remote Server Administration Tools (RSAT).  

### 2. Administrative Privileges  
- The script must be executed by a domain admin or an account with the necessary permissions.  

### 3. CSV File (users.csv)  
Prepare a CSV file with user details in the following format:  

| FirstName | LastName | Username | OU | Group | Enabled |  
|-----------|---------|----------|----|-------|---------|  
| John | Doe | jdoe | OU=Employees,OU=Company,DC=example,DC=com | IT | True |  
| Jane | Smith | jsmith | OU=Employees,OU=Company,DC=example,DC=com | HR | False |  

## How the Script Works  

1. **Imports the Active Directory Module** – Ensures all necessary AD commands are available.  
2. **Reads Users from a CSV File** – Extracts user details from a structured CSV input.  
3. **Checks for Existing Users** – Prevents duplicate accounts from being created.  
4. **Creates New Users** – Assigns usernames, names, organizational units (OUs), and temporary passwords. Requires users to change their password on first login.  
5. **Assigns Users to Security Groups** – Adds users to the appropriate AD security groups if specified.  
6. **Logs All Actions** – Every action (success or failure) is recorded in a log file for auditing purposes.  

## How to Use the Script  

1. **Save the Script**  
   - Store the PowerShell script as `UserManagement.ps1`.  

2. **Prepare the CSV File**  
   - Save and modify the `users.csv` file with the required user details.  

3. **Run the Script as Administrator**  
   - Open PowerShell with administrative privileges and execute the script.  

4. **Verify Users in Active Directory**  
   - Check ADUC (Active Directory Users and Computers) to confirm account creation.  

5. **Review the Log File**  
   - Open `UserManagement.log` to inspect the script's actions and troubleshoot errors if necessary.  

## Next Steps & Improvements  

- **Parameterize Inputs** – Allow user input for file paths instead of hardcoding them.  
- **Enhance Error Handling** – Improve logging for better debugging.  
- **Expand Functionality** – Implement additional features such as user disabling and deletion based on CSV input.  
