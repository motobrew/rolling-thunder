#!/bin/sh

WORKDIR=`dirname $0`
. $WORKDIR/env.txt
. $WORKDIR/func.sh

Main()
{

	SetToken universe idfv $IDFV1

}

Main
