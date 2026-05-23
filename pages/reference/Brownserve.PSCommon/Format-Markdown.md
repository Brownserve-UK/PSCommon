---
external help file: Brownserve.PSCommon-help.xml
Module Name: Brownserve.PSCommon
online version:
schema: 2.0.0
---

# Format-Markdown

## SYNOPSIS

Formats a markdown file to ensure it follows the markdownlint rules.

## SYNTAX

### Path (Default)

```text
Format-Markdown [-Path] <String> [-CodeBlockLanguage <String>]
 [-EmphasisAsHeaderConversion <MarkdownEmphasisAsHeaderConversion>]
 [<CommonParameters>]
```

### Pipeline

```text
Format-Markdown [-CodeBlockLanguage <String>]
 [-EmphasisAsHeaderConversion <MarkdownEmphasisAsHeaderConversion>]
 [<CommonParameters>]
```

## DESCRIPTION

Formats a markdown file to ensure it follows the markdownlint rules.

## EXAMPLES

### Example 1

```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -CodeBlockLanguage

The language to use for code blocks.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Text
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EmphasisAsHeaderConversion

The conversion to use for emphasis-as-headers.

```yaml
Type: MarkdownEmphasisAsHeaderConversion
Parameter Sets: (All)
Aliases:
Accepted values: List, Header

Required: False
Position: Named
Default value: Header
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

The path to the markdown file to format.

```yaml
Type: String
Parameter Sets: Path
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable, -ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
