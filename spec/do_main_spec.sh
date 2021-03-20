# shellcheck shell=sh

Describe 'do_main()'
    version=$(cat VERSION)
    Before "version=$version"
    Include ./functions/global_variables.sh
    Include ./functions/date_version_detect.sh
    Include ./libs/usage.sh
    Include ./libs/do_main.sh
    It 'Call function do_main without paramenters'
        When call do_main
        The line 1 of output should eq "tildelog $version"
    End
End
