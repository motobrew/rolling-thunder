#!/bin/sh

WORKDIR=`dirname $0`
. $WORKDIR/env.txt
. $WORKDIR/func.sh

Main()
{
	Log 'INFO: 売り場のいいね'
	
	Get /booths/$BOOTH_ID
	CompareResponseJson "更新前のlikes" 0 '.[].likes'

	LikeBooth

	Get /booths/$BOOTH_ID
	CompareResponseJson "更新後のlikes" 1 '.[].likes'

	LikeBooth

	Get /booths/$BOOTH_ID
	CompareResponseJson "更新後のlikes" 1 '.[].likes'
}

LikeBooth()
{
	JSON='{
		"booth_id": "$BOOTH_ID",
		"user_id": "$USER_ID2"
	}'

	Post /likes/booths "$JSON" 200
}

Main
