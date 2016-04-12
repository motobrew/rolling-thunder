#!/bin/sh

WORKDIR=`dirname $0`
. $WORKDIR/env.txt
. $WORKDIR/func.sh

Main()
{
	Log 'INFO: お店のタグの削除'

	Get /stores/$STORE_ID 200
	CompareResponseJson '削除前のタグ数' 2 '.[].tags | length'

	DeleteTag

	Get /stores/$STORE_ID 200
	CompareResponseJson '削除後のタグ数' 1 '.[].tags | length'
	CompareResponseJson 'タグ' 'キラキラ' '.[].tags[0]'
}

DeleteTag()
{
	JSON='{
		"tag": "こてこて",
		"user_id": "$USER_ID"
	}'

	Delete /stores/$STORE_ID/tags "$JSON" 200
}

Main
