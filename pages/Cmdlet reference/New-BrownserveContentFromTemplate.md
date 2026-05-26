---
external help file: Brownserve.PSCommon-help.xml
Module Name: Brownserve.PSCommon
online version:
schema: 2.0.0
---

# New-BrownserveContentFromTemplate

## SYNOPSIS

Generates content from a template file, optionally substituting placeholder values.

## SYNTAX

```text
New-BrownserveContentFromTemplate [-TemplateDirectory] <String> [-TemplateName] <String>
 [[-Substitutions] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION

Reads a template file from the given directory and returns its content as a string.
Placeholders in the template take the form `###KEY###` and are replaced with the
corresponding values supplied via the `Substitutions` parameter.

## EXAMPLES

### Example 1

```powershell
New-BrownserveContentFromTemplate `
    -TemplateDirectory (Join-Path $PSScriptRoot 'templates') `
    -TemplateName 'MyProject_readme.md.template'
```

Reads `MyProject_readme.md.template` from the `templates` subdirectory and returns
its content unchanged.

### Example 2

```powershell
$Substitutions = @{
    REPO_NAME   = 'MyRepo'
    MODULE_NAME = 'MyModule'
}

New-BrownserveContentFromTemplate `
    -TemplateDirectory (Join-Path $PSScriptRoot 'templates') `
    -TemplateName 'MyProject_github_pull_request_template.md.template' `
    -Substitutions $Substitutions
```

Reads the template and replaces all occurrences of `###REPO_NAME###` and
`###MODULE_NAME###` with the supplied values before returning the content.

## PARAMETERS

### -Substitutions

A hashtable of placeholder keys and their replacement values. Each key must match a
`###KEY###` placeholder in the template. Keys not present in the template are silently
ignored.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateDirectory

The path to the directory containing the template file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TemplateName

The filename of the template to load, including any extension (e.g. `MyProject_readme.md.template`).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable, -ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
