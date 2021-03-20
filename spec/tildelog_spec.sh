# shellcheck shell=bash

Describe 'tildelog.sh'  
  It 'Call script without paramenters'
    When run script ./tildelog.sh
    The line 1 of output should eq "You're not in your blog directory. Moving you there now"
    The line 2 of output should eq "tildelog 0.0.1"
    The line 3 of output should eq "usage: ./tildelog.sh command [filename]"
  End
End