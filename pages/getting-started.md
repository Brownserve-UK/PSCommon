# Getting Started

!!! note
    These tools have been designed for use within Brownserve projects and will likely have limited use outside of that.

## Prerequisites

This module requires **PowerShell 6.0 or later**. You can download it from the [official PowerShell repository](https://github.com/PowerShell/PowerShell/releases).

## Installing the module

To make the module available in your PowerShell session, install it from the PSGallery:

```powershell
Install-Module -Repository PSGallery -Name 'Brownserve.PSCommon'
Import-Module 'Brownserve.PSCommon'
```

If you plan to use the module regularly, add the import step to your [PowerShell Profile](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles).

## Using the module

Once imported, all cmdlets are available directly in your session. You can list them with:

```powershell
Get-Command -Module 'Brownserve.PSCommon'
```

For help on any individual cmdlet, use `Get-Help`:

```powershell
Get-Help Merge-Hashtable -Full
```

See the [module reference](reference/Brownserve.PSCommon/) for the full list of available cmdlets and their documentation.
