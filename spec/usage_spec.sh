# shellcheck shell=bash
Describe 'usage()'
    Before "global_software_name='tildelog'"
    Before "global_software_version='0.0.1'"
    Include ./libs/usage.sh
    It 'Call function usage'
        When call usage
        The line 2 of output should include "usage:"
    End
End