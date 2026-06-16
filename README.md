# Active Directory Home Lab

## Overview

This project demonstrates the deployment, administration, and security analysis of a Windows Active Directory environment in a virtualized lab. The lab was built using VMware Workstation Pro and consists of a Windows Server 2022 Domain Controller, multiple Windows client systems, and a Kali Linux attacker workstation.

The environment was populated using PowerShell automation and JSON-based configuration files to create users, groups, and administrative accounts. After deployment, Active Directory enumeration and analysis were performed using SharpHound, BloodHound, and CrackMapExec to better understand domain relationships and attack paths.

---

## Objectives

* Deploy a functional Active Directory Domain Services (AD DS) environment.
* Configure DNS services for domain authentication and name resolution.
* Join Windows workstations to the domain.
* Automate user and group provisioning with PowerShell.
* Generate a realistic Active Directory environment containing multiple users and groups.
* Explore Active Directory enumeration techniques using BloodHound and SharpHound.
* Validate authentication and domain access using CrackMapExec.

---

## Lab Architecture

```text
                         VMware Workstation Pro
┌────────────────────────────────────────────────────────────┐
│                                                            │
│  Windows Server 2022                                      │
│  ├─ Active Directory Domain Services                      │
│  ├─ DNS                                                    │
│  └─ Domain Controller (FT.com)                            │
│                                                            │
│  Windows 11 Management Workstation                        │
│                                                            │
│  Windows Workstation #1                                   │
│  └─ Domain Joined                                          │
│                                                            │
│  Windows Workstation #2                                   │
│  └─ Domain Joined                                          │
│                                                            │
│  Kali Linux                                                │
│  ├─ BloodHound                                             │
│  ├─ SharpHound                                             │
│  └─ CrackMapExec                                           │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

---

## Technologies Used

### Infrastructure

* VMware Workstation Pro
* Windows Server 2022
* Windows 11
* Kali Linux

### Windows Services

* Active Directory Domain Services (AD DS)
* DNS

### Automation

* PowerShell
* JSON

### Security Tools

* BloodHound
* SharpHound
* CrackMapExec

---

## Project Setup

### Virtual Machines

| System                 | Purpose                        |
| ---------------------- | ------------------------------ |
| Windows Server 2022    | Domain Controller              |
| Windows 11             | Management Workstation         |
| Windows Workstation #1 | Domain User Testing            |
| Windows Workstation #2 | Domain User Testing            |
| Kali Linux             | Security Testing & Enumeration |

### Domain Configuration

Domain Name:

```text
FT.com
```

Domain Controller Configuration:

* Configured static IP addressing.
* Configured DNS services.
* Installed Active Directory Domain Services.
* Promoted the server to a Domain Controller.
* Joined Windows workstations to the domain.

---

## PowerShell Automation

The project includes PowerShell scripts that automate Active Directory population using a JSON-based schema.

### AD Schema

A JSON configuration file defines:

* Domain name
* Groups
* Users
* Passwords
* Group memberships

Example structure:

```json
{
  "domain": "FT.com",
  "groups": [],
  "users": []
}
```

### Automated Tasks

The PowerShell automation performs:

* Active Directory group creation.
* Active Directory user creation.
* Username generation from first and last names.
* Group membership assignment.
* Local administrator assignment.
* Account enablement.
* Environment cleanup and rollback.

### Random Domain Population

Additional automation generates:

* Random user accounts.
* Random security groups.
* Password assignments.
* Local administrator accounts.

The final environment contained approximately:

* 100 domain users
* 3 administrator accounts
* Multiple security groups

---

## Active Directory Configuration

### Group Management

PowerShell automation was used to:

* Create security groups.
* Add users to groups.
* Manage permissions through group membership.

### User Provisioning

Users were automatically generated and provisioned with:

* First and last names.
* Usernames.
* Passwords.
* Group memberships.
* Administrative privileges when specified.

### Password Policy Handling

For lab creation purposes, the scripts temporarily modified password policy requirements to allow automated account creation and then provided functionality to restore stronger settings.

---

## Security Analysis

### SharpHound

SharpHound was used to collect Active Directory information from the domain environment, including:

* Users
* Groups
* Computers
* Sessions
* Administrative relationships

### BloodHound

Collected data was imported into BloodHound to visualize:

* User-to-group relationships
* Administrative privileges
* Attack paths
* Privilege escalation opportunities

### CrackMapExec

CrackMapExec was used from the Kali Linux workstation to interact with and validate authentication against systems in the Active Directory environment.

---

## Key Tasks Completed

* Installed and configured Windows Server 2022.
* Installed Active Directory Domain Services.
* Configured DNS services.
* Promoted a Domain Controller.
* Joined Windows workstations to the domain.
* Implemented PowerShell-based Active Directory population.
* Created approximately 100 users and multiple groups.
* Assigned local administrator privileges to selected accounts.
* Collected Active Directory data using SharpHound.
* Analyzed domain relationships with BloodHound.
* Performed authentication testing using CrackMapExec.

---

## Skills Demonstrated

### System Administration

* Windows Server Administration
* Active Directory Administration
* DNS Configuration
* Domain Management
* User and Group Administration

### Scripting & Automation

* PowerShell
* JSON Configuration Management
* User Provisioning Automation

### Cybersecurity

* Active Directory Enumeration
* BloodHound Analysis
* Authentication Testing
* Identity and Access Management (IAM)
* Attack Path Analysis

### Infrastructure

* Virtualization
* Multi-VM Lab Deployment
* Windows Network Administration

---

## Challenges and Troubleshooting

During the project, troubleshooting was required to:

* Configure domain services correctly.
* Ensure DNS resolution functioned properly.
* Join workstations to the domain.
* Validate user provisioning automation.
* Verify group memberships and administrative privileges.
* Configure security tools to collect and analyze Active Directory data successfully.

---

## Lessons Learned

This project provided hands-on experience with enterprise identity infrastructure and Active Directory administration.

Key takeaways included:

* Understanding how Active Directory organizes users, groups, and permissions.
* Automating domain population using PowerShell and JSON.
* Managing authentication and administrative access.
* Using BloodHound and SharpHound to analyze Active Directory relationships.
* Understanding how attackers and defenders view Active Directory environments differently.

```
```
