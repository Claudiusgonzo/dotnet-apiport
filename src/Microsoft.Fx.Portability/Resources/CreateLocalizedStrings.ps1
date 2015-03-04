$inputFile = "$PSScriptRoot\LocalizedStrings.resx"
$outputFile = "$PSScriptRoot\LocalizedStrings.cs"

[xml]$resources = gc $inputFile

$strings = $resources.root.data | % { "public static string " + $_.name + " { get { return @`"" + $_.value + "`"; } }" }

$autogenerated = "// This is auto-generated with CreateLocalizedStrings.ps1`r`n"
$header = "namespace Microsoft.Fx.Portability.Resources { `r`npublic static class LocalizedStrings {`r`n"
$methods = [System.String]::Join("`r`n", $strings)
$footer = "`r`n}}"

$autogenerated + $header + $methods + $footer | Out-File -Encoding UTF8 $outputFile

Write-Host "Generated LocalizedStrings.cs"