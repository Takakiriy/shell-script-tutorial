#!/bin/bash
function  Error() {
    echo  "$1"  >&2
    exit 2
}

./1-if-block.sh  2>&1  |  tee ./_output.log
diff  <( cat ./_output.log )  <( cat ./1-if-block.sh.log )  ||  Error

./2-if-string.sh  2>&1  |  tee ./_output.log
diff  <( cat ./_output.log )  <( cat ./2-if-string.sh.log )  ||  Error

./3-if-number.sh  2>&1  |  tee ./_output.log
diff  <( cat ./_output.log )  <( cat ./3-if-number.sh.log )  ||  Error

./4-if-number-zsh.sh  2>&1  |  tee ./_output.log
diff  <( cat ./_output.log )  <( cat ./4-if-number-zsh.sh.log )  ||  Error

./5-if-stdout.sh  2>&1  |  tee ./_output.log
diff  <( cat ./_output.log )  <( cat ./5-if-stdout.sh.log )  ||  Error

./5-if-stdout.sh  2>&1  |  tee ./_output.log
diff  <( cat ./_output.log )  <( cat ./5-if-stdout.sh.log )  ||  Error

./6-if-exit-code.sh  2>&1  |  tee ./_output.log
diff  <( cat ./_output.log )  <( cat ./6-if-exit-code.sh.log )  ||  Error

./7-if-and-or.sh  2>&1  |  tee ./_output.log
diff  <( cat ./_output.log )  <( cat ./7-if-and-or.sh.log )  ||  Error

Case=11  ./8-if-undefined.sh  2>&1  |  tee ./_output.log
Case=12  ./8-if-undefined.sh  2>&1  |  tee -a ./_output.log
Case=16  ./8-if-undefined.sh  2>&1  |  tee -a ./_output.log
Case=21  ./8-if-undefined.sh  2>&1  |  tee -a ./_output.log
Case=22  ./8-if-undefined.sh  2>&1  |  tee -a ./_output.log
Case=31  ./8-if-undefined.sh  2>&1  |  tee -a ./_output.log
Case=32  ./8-if-undefined.sh  2>&1  |  tee -a ./_output.log
diff  <( cat ./_output.log )  <( cat ./8-if-undefined.sh.log )  ||  Error

echo  "Pass."
rm  ./_output.log
