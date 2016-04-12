#!/bin/sh

WORKDIR=`dirname $0`
. $WORKDIR/env.txt
. $WORKDIR/func.sh

Main()
{
	Log 'INFO: お店のフォロー'
	
	Get /stores/$STORE_ID 200
	CompareResponseJson "更新前のfollows" 0 '.[].follows'

	FollowStore

	Get /stores/$STORE_ID 200
	CompareResponseJson "更新後のfollows" 1 '.[].follows'
	
	FollowStore

	Get /stores/$STORE_ID 200
	CompareResponseJson "更新後のfollows" 1 '.[].follows'
}

FollowStore()
{
	JSON='{
		"store_id": "$STORE_ID",
		"user_id": "$USER_ID2"
	}'

	Post /follows "$JSON" 200
}

Main
