<#
.DESCRIPTION
    Private classes for Brownserve.PSCommon.
    It's important that classes remain in one file as when they are in individual files they can be loaded in the wrong
    order which can cause 'type not found' errors.
#>

## Common classes

<#
.SYNOPSIS
    This enum performs some simple validation for line endings.
#>
enum BrownserveLineEnding
{
    LF
    CRLF
    CR
}

<#
.SYNOPSIS
    The BrownserveContent class is used to aid in formatting file content in a consistent manner.
    It is used with the *-BrownserveContent cmdlets.
#>
class BrownserveContent
{
    [string[]]$Content
    hidden [string]$Path
    hidden [BrownserveLineEnding]$LineEnding

    BrownserveContent([string[]]$Content, [string]$Path, [string]$LineEnding)
    {
        $this.Content = $Content
        $this.Path = $Path
        $this.LineEnding = $LineEnding
    }

    BrownserveContent([pscustomobject]$Content)
    {
        # Compare against $null, content may end up as an empty string in certain cases which is expected
        if ($null -eq $Content.Content)
        {
            throw 'Cannot create BrownserveContent object without Content'
        }
        if (!$Content.Path)
        {
            throw 'Cannot create BrownserveContent object without Path'
        }
        if ($null -eq $Content.LineEnding)
        {
            throw 'Cannot create BrownserveContent object without LineEnding'
        }
        $this.Content = $Content.Content
        $this.Path = $Content.Path
        $this.LineEnding = $Content.LineEnding
    }

    BrownserveContent([hashtable]$Content)
    {
        # Compare against $null, content may end up as an empty string in certain cases which is expected
        if ($null -eq $Content.Content)
        {
            throw 'Cannot create BrownserveContent object without Content'
        }
        if (!$Content.Path)
        {
            throw 'Cannot create BrownserveContent object without Path'
        }
        if ($null -eq $Content.LineEnding)
        {
            throw 'Cannot create BrownserveContent object without LineEnding'
        }
        $this.Content = $Content.Content
        $this.Path = $Content.Path
        $this.LineEnding = $Content.LineEnding
    }

    [string] ToString()
    {
        return $this.Content -join $this.NewLine()
    }

    # We can call this method to easily get the line ending for the file
    [string] NewLine()
    {
        switch ($this.LineEnding)
        {
            'LF'
            {
                return "`n"
            }
            'CRLF'
            {
                return "`r`n"
            }
            'CR'
            {
                return "`r"
            }
            default
            {
                throw "Unsupported line ending '$($this.LineEnding)'"
            }
        }
        throw "Unsupported line ending '$($this.LineEnding)'"
    }
}

## Markdown related classes

enum MarkdownEmphasisAsHeaderConversion
{
    List
    Header
}
