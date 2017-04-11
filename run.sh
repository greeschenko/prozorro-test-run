#!/usr/bin/env bash

declare -a alist
declare -a slist
declare -a rlist

BROKER=polonex
SORS=robot_tests
n=0

alist[0]=robot_tests_arguments/dgf_financial_active_disqualification.txt
alist[1]=robot_tests_arguments/dgf_financial_payment_cancellation.txt
alist[2]=robot_tests_arguments/dgf_financial_verification_cancellation.txt
alist[3]=robot_tests_arguments/dgf_financial_verification_cancellation.txt
alist[4]=robot_tests_arguments/dgf_financial_verification_disqualification.txt

slist[0]=openProcedure
slist[1]=auction
slist[2]=awarding
slist[3]=contract_signing

rlist[0]=tender_owner
rlist[1]=provider1
rlist[2]=viewer

rm -drf ${SORS}_*

for a in ${alist[@]}; do
    res=''
    cp -r ${SORS} ${SORS}_${n}
    for r in ${rlist[@]} ; do
        for s in ${slist[@]}; do
            res1="bin/op_tests -s ${s} -A ${a}
            -v BROKER:${BROKER} -v ROLE:${r};
            chromium test_output/log.html;"
            res=$res$res1
        done
    done
    #echo $res
    xterm -e "cd ${SORS}_${n} && ${res}" &
    (( n++ ))
done


