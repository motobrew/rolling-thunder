#!/bin/sh

WORKDIR=`dirname $0`
. $WORKDIR/env.txt
. $WORKDIR/func.sh

Main()
{
	Log 'INFO: お店のタグの削除'

	Get /booths/$BOOTH_ID 200
	CompareResponseJson '削除前のタグ数' 2 '.[].tags | length'

	DeleteTag

	Get /booths/$BOOTH_ID 200
	CompareResponseJson '削除後のタグ数' 1 '.[].tags | length'
	CompareResponseJson 'タグ' 'かっこいい' '.[].tags[0]'
}

DeleteTag()
{
	JSON='{
		"tag": "かわいい",
		"user_id": "$USER_ID"
	}'

	Delete /booths/$BOOTH_ID/tags "$JSON" 200
}

Main
