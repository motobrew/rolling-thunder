#!/bin/sh

WORKDIR=`dirname $0`
. $WORKDIR/env.txt
. $WORKDIR/func.sh

Main()
{
	Log 'INFO: 売り場の訪問'
	
	Get /booths/$BOOTH_ID
	CompareResponseJson "更新前のvisits" 0 '.[].visits'

	VisitBooth

	Get /booths/$BOOTH_ID
	CompareResponseJson "更新前のvisits" 1 '.[].visits'

	VisitBooth

	Get /booths/$BOOTH_ID
	CompareResponseJson "更新前のvisits" 1 '.[].visits'
}

VisitBooth()
{
	JSON='{
		"booth_id": "$BOOTH_ID",
		"user_id": "$USER_ID2"
	}'

	Post /visits "$JSON" 200
}

Main
