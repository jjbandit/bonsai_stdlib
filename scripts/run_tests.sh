#! /bin/bash

# . ${basename BASH_SOURCE}/preamble.sh
# echo "$(dirname ${BASH_SOURCE[0]})/preamble.sh"
source "$(dirname ${BASH_SOURCE[0]})/preamble.sh"

EXIT_CODE=0

# echo "${BASH_SOURCE[0]}"
# exit 0

if [ "$Platform" == "Linux" ] ; then
  exe_search_string='./bin/tests/*';
elif [[ "$Platform" == "Windows" ]] ; then
  # TODO(Jesse): Do we actually need this since switching off VS?  Does clang
  # output pdb files there or something?
  exe_search_string='./bin/tests/*.exe';
fi

echo $(pwd)
for test_executable in $(find $exe_search_string); do
  # echo "$test_executable"
  # echo "$COLORFLAG"
  if $test_executable $COLORFLAG --log-level LogLevel_Shush == 0; then
    echo -n ""
  else
    EXIT_CODE=$(($EXIT_CODE+1))
  fi
done

if [ "$EXIT_CODE" -eq 0 ]; then
  echo ""
  echo "All Tests Passed"
elif [ "$EXIT_CODE" -eq 1 ]; then
  echo ""
  echo "$EXIT_CODE Test suite failed. Inspect log for details."
else
  echo ""
  echo "$EXIT_CODE Test suites failed. Inspect log for details."
fi

exit $EXIT_CODE
