# shellcheck shell=bash

Describe 'do_main()'
    version=$(cat VERSION)
    Before "version=$version"
    Include ./functions/global_variables.sh
    Include ./functions/date_version_detect.sh
    Include ./libs/do_main.sh
    Include ./libs/usage.sh
    It 'Call function do_main without paramenters'
        When call do_main
        The line 1 of output should eq "You're not in your blog directory. Moving you there now"
        The line 2 of output should eq "tildelog $version"
        #The line 3 of output should eq "usage: ./tildelog.sh command [filename]"
    End
End
