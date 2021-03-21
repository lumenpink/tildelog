# shellcheck shell=sh

Describe 'date_version_detect'
    Include ./functions/date_version_detect.sh
    Describe 'gdate'
        command(){
            return 1
        }
        gdate(){
            printf "gdate-mocked"
        }
        It 'Call function date_version_detect on bash'
            When call date_version_detect
            The result of function gdate should equal "gdate-mocked"
        End
    End
    Describe 'arg = -r'
        command(){
            return 0
        }
        Parameters
            '-r' '01-01-1980' '+%Y%M%d'
            '-j' '--date 01-01-1980' '+%Y%M%d'
            '01-01-1980' '+%Y%M%d' '1'
        End
        Example 'Call function date_version_detect on bash'
             When call date_version_detect "$1" "$2" "$3"
             The result of function command should be successful
             #The result of function date should equal "19800101"
             #The variable format should equal "%Y%M%d"
        End
    End
End
