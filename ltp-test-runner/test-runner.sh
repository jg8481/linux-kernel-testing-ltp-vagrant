#!/bin/bash

clear
TIMESTAMP=$(date)

export LTP_SOURCE_DIRECTORY=/linux-kernel-testing-ltp-vagrant/ltp-test-runner
export LTP_TARGET_DIRECTORY=/linux-kernel-testing-ltp-vagrant/ltp-test-runner/ltp
export LTP_OPT_DIRECTORY=/opt/ltp

if [ "$1" == "Run-Makefile-And-Run-LTP-From-Inside-Vagrant-Box" ]; then
  echo
  echo "------------------------------------[[[[ Run-Makefile-And-Run-LTP-Inside-Vagrant-Box ]]]]------------------------------------"
  echo
  echo "This should be the first command you run after a 'vagrant ssh' from your terminal. This run started on $TIMESTAMP."
  echo
  mkdir "$LTP_TARGET_DIRECTORY"/testcases/misc/ltp-test-runner
  cp "$LTP_SOURCE_DIRECTORY"/Makefile.ltp-test-template "$LTP_TARGET_DIRECTORY"/testcases/misc/ltp-test-runner/Makefile
  cp "$LTP_SOURCE_DIRECTORY"/basictest.c "$LTP_TARGET_DIRECTORY"/testcases/misc/ltp-test-runner/basictest.c
  cd "$LTP_TARGET_DIRECTORY"/testcases/misc/ltp-test-runner
  make
  cp "$LTP_TARGET_DIRECTORY"/testcases/misc/ltp-test-runner/basictest "$LTP_OPT_DIRECTORY"/testcases/ltp-test-runner/basictest
  cd /opt/ltp
  ./runltp -f "$LTP_OPT_DIRECTORY"/testcases/ltp-test-runner/basictest -s basictest -d /opt
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Run-Insmod-And-Display-Kernel-Module-Messages-In-Dmesg" ]; then
  echo
  echo "------------------------------------[[[[ Run-Insmod-And-Display-Kernel-Module-Messages-In-Dmesg ]]]]------------------------------------"
  echo
  echo "This should be the second command you run after a 'vagrant ssh' from your terminal. This run started on $TIMESTAMP."
  echo
  cd /linux-kernel-testing-ltp-vagrant/ltp-test-runner
  insmod "$2"
  dmesg
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

usage_explanation() {
  echo
  echo
  echo "------------------------------------[[[[ Tool Runner Script ]]]]------------------------------------"
  echo
  echo
  echo "This tool runner script is meant to be used from inside a Vagrant VM after you run 'vagrant ssh' from your terminal."
  echo
  echo "You can view just this help menu again (without triggering any automation) by running 'bash ./test-runner.sh -h' or 'bash ./test-runner.sh --help'."
  echo
  echo
  echo "bash ./test-runner.sh Run-Makefile-And-Run-LTP-From-Inside-Vagrant-Box"
  echo "bash ./test-runner.sh Run-Insmod-And-Display-Kernel-Module-Messages-In-Dmesg basicmodule.ko"
  echo
  echo
}

error_handler() {
  local error_message="$@"
  echo "${error_message}" 1>&2;
}

argument="$1"
if [[ -z $argument ]] ; then
  usage_explanation
else
  case $argument in
    -h|--help)
      usage_explanation
      ;;
    *)
      usage_explanation
      ;;
  esac
fi