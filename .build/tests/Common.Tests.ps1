#requires -Modules Pester
#.SYNOPSIS
#   Performs tests to make sure the PowerShell module works as intended
Describe 'Common cmdlets' {
    Context 'Merge-Hashtable' {
        It 'should merge simple hashes' {
            Merge-Hashtable -BaseObject @{key1 = 'val1' } -InputObject @{key1 = 'val2' } | Select-Object -ExpandProperty Values | Should -Be 'val2'
        }
        It 'should perform deep merges' {
            $ComplexHash = @{
                key1        = 'val1'
                key2        = 'val2'
                arr1        = @('a', 'b', 'c')
                nested_hash = @{
                    nested_hash_key1 = 'val3'
                    nested_hash_key2 = 'val4'
                    nested_hash_arr1 = @('a', 'b', 'c')
                }
            }
            $ComplexHash2 = @{
                key1        = 'val3'
                key2        = 'val4'
                arr1        = @('a', 'b', 'd')
                nested_hash = @{
                    nested_hash_key1 = 'val1'
                    nested_hash_key2 = 'val2'
                    nested_hash_arr1 = @('a', 'b', 'd')
                }
            }
            $MergedHashes = Merge-Hashtable -BaseObject $ComplexHash -InputObject $ComplexHash2 -Deep
            $MergedHashes.Key1 | Should -Be 'val3'
            $MergedHashes.Key2 | Should -Be 'val4'
            $MergedHashes.arr1 | Should -Be @('a','b','c','d')
            $MergedHashes.nested_hash.nested_hash_key1 | Should -Be 'val1'
            $MergedHashes.nested_hash.nested_hash_key2 | Should -Be 'val2'
            $MergedHashes.nested_hash.nested_hash_arr1 | Should -Be @('a','b','c','d')
        }
        It 'should fail to deep merge inconsistent keys' {
            {
                $Hash1 = @{
                    key1 = 'val1'
                    arr1 = @('a', 'b', 'c')
                }
                $Hash2 = @{
                    key1 = 'val1'
                    arr1 = @{'test' = $true }
                }
                Merge-Hashtable -BaseObject $Hash1 -InputObject $Hash2 -ErrorAction 'stop' -Deep
            } | Should -Throw
        }
    }

    Context 'Test-Numeric' {
        It 'should return true for an integer' {
            Test-Numeric -InputObject 42 | Should -BeTrue
        }
        It 'should return true for a decimal' {
            Test-Numeric -InputObject ([decimal]3.14) | Should -BeTrue
        }
        It 'should return true for a double' {
            Test-Numeric -InputObject ([double]1.5) | Should -BeTrue
        }
        It 'should return false for a string' {
            Test-Numeric -InputObject 'not a number' | Should -BeFalse
        }
        It 'should return false for a boolean' {
            Test-Numeric -InputObject $true | Should -BeFalse
        }
    }

    Context 'ConvertTo-SortedHashtable' {
        It 'should sort keys alphabetically' {
            $Sorted = ConvertTo-SortedHashtable -InputObject @{ z = 1; a = 2; m = 3 }
            @($Sorted.Keys)[0] | Should -Be 'a'
            @($Sorted.Keys)[-1] | Should -Be 'z'
        }
        It 'should preserve key values after sorting' {
            $Sorted = ConvertTo-SortedHashtable -InputObject @{ z = 'last'; a = 'first' }
            $Sorted['a'] | Should -Be 'first'
            $Sorted['z'] | Should -Be 'last'
        }
        It 'should return an ordered dictionary' {
            $Result = ConvertTo-SortedHashtable -InputObject @{ b = 1; a = 2 }
            $Result | Should -BeOfType [System.Collections.Specialized.OrderedDictionary]
        }
    }

    Context 'ConvertTo-BlockComment' {
        It 'should prefix lines with the hash character by default' {
            $Result = ConvertTo-BlockComment -InputObject 'hello world'
            $Result.TrimEnd() | Should -Be '# hello world'
        }
        It 'should not double-prefix already commented lines' {
            $Result = ConvertTo-BlockComment -InputObject '# already commented'
            $Result | Should -Match '^# already commented'
            $Result | Should -Not -Match '^## '
        }
        It 'should use a custom comment character' {
            $Result = ConvertTo-BlockComment -InputObject 'test line' -CommentCharacter '//'
            $Result | Should -Match '^// test line'
        }
        It 'should comment multiple lines' {
            $Result = ConvertTo-BlockComment -InputObject @('line one', 'line two')
            $Result | Should -Match '# line one'
            $Result | Should -Match '# line two'
        }
    }

    Context 'Format-BrownserveContent' {
        It 'should split content into an array of lines' {
            $Result = Format-BrownserveContent -Content "line1`nline2`nline3" -InsertFinalNewline $false
            $Result.Content[0] | Should -Be 'line1'
            $Result.Content[1] | Should -Be 'line2'
            $Result.Content[2] | Should -Be 'line3'
        }
        It 'should append an empty trailing element when InsertFinalNewline is true' {
            $Result = Format-BrownserveContent -Content "line1`nline2" -InsertFinalNewline $true
            $Result.Content[-1] | Should -Be ''
        }
        It 'should not append a trailing element when InsertFinalNewline is false' {
            $Result = Format-BrownserveContent -Content "line1`nline2" -InsertFinalNewline $false
            $Result.Content[-1] | Should -Be 'line2'
        }
        It 'should strip carriage returns from content' {
            $Result = Format-BrownserveContent -Content "line1`r`nline2" -InsertFinalNewline $false
            $Result.Content[0] | Should -Be 'line1'
            $Result.Content[0] | Should -Not -Match "`r"
        }
        It 'should store the requested line ending on the result object' {
            $Result = Format-BrownserveContent -Content 'hello' -LineEnding 'CRLF' -InsertFinalNewline $false
            "$($Result.LineEnding)" | Should -Be 'CRLF'
        }
    }

    Context 'Assert-Path' {
        It 'should not throw when the path exists' {
            { Assert-Path -Path $TestDrive } | Should -Not -Throw
        }
        It 'should throw when the path does not exist' {
            { Assert-Path -Path (Join-Path $TestDrive 'does-not-exist-xyzzy') } | Should -Throw
        }
        It 'should throw when using -Inverse and the path exists' {
            { Assert-Path -Path $TestDrive -Inverse } | Should -Throw
        }
        It 'should not throw when using -Inverse and the path does not exist' {
            { Assert-Path -Path (Join-Path $TestDrive 'absent-xyzzy') -Inverse } | Should -Not -Throw
        }
    }

    Context 'Assert-Directory' {
        BeforeAll {
            $script:TestFile = New-Item (Join-Path $TestDrive 'assert_dir_test.txt') -ItemType File -Force
        }
        It 'should not throw for a valid directory path' {
            { Assert-Directory -Path $TestDrive } | Should -Not -Throw
        }
        It 'should throw when the path does not exist' {
            { Assert-Directory -Path (Join-Path $TestDrive 'no-such-dir-xyzzy') } | Should -Throw
        }
        It 'should throw when the path points to a file' {
            { Assert-Directory -Path $script:TestFile.FullName } | Should -Throw
        }
    }

    Context 'Assert-Command' {
        It 'should not throw when the command exists' {
            { Assert-Command -Command 'pwsh' } | Should -Not -Throw
        }
        It 'should throw when the command does not exist' {
            { Assert-Command -Command 'this-command-definitely-does-not-exist-xyzzy' } | Should -Throw
        }
        It 'should list all missing commands in the thrown error' {
            { Assert-Command -Command @('missing-one-xyzzy', 'missing-two-xyzzy') } |
                Should -Throw -ExpectedMessage '*missing-one-xyzzy*'
        }
    }
}
