function New-BrownserveContentFromTemplate
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [string]
        $TemplateDirectory,

        [Parameter(Mandatory = $true)]
        [string]
        $TemplateName,

        [Parameter(Mandatory = $false)]
        [hashtable]
        $Substitutions = @{}
    )
    begin
    {
        try
        {
            $Template = Get-Content (Join-Path $TemplateDirectory $TemplateName) -Raw
        }
        catch
        {
            throw "Failed to import template '$TemplateName'.`n$($_.Exception.Message)"
        }
    }
    process
    {
        foreach ($Key in $Substitutions.Keys)
        {
            $Template = $Template -replace "###${Key}###", $Substitutions[$Key]
        }
        return $Template
    }
    end
    {
    }
}
