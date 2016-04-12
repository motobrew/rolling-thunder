#!/bin/sh

WORKDIR=`dirname $0`
. $WORKDIR/env.txt
. $WORKDIR/func.sh

Main()
{
	Get "/feed?limit=50" 200
	cat $RESPONSE_BODY | jq .
}

Main
