#!/bin/sh

WORKDIR=`dirname $0`
. $WORKDIR/env.txt
. $WORKDIR/func.sh

Main()
{
	Log 'INFO: ここにテスト概要を記述'
	
	# ここに処理を記述
	Sample
}

Sample()
{
	:
}

Main
