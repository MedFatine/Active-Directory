-- Installed The Domain Controller

    1 -sconfig to :
        - Change the hostname
        - Change the IP address to static
        - Change the DNS server to our own IP address

    2 - Install the Active Directory Windows features

        using :
            "Install-WindowsFeature -name AD-Domaine-Services -IncludeManagementTools"

    3 - Added Workstation to the Domain

            "Add-Computer -Domainname FT.com -credential ft\administrator -force -restart"

    