#!/bin/sh

WORKDIR=`dirname $0`
. $WORKDIR/env.txt
. $WORKDIR/func.sh

Main()
{
	Log 'INFO: ユーザの追加とトークンの取得'

	IDFV2=`uuidgen`

	SetToken new_user idfv $IDFV2

	CreateNewUser2
	USER_ID2=`ResponseJson .[].user_id `

	SetToken universe idfv $IDFV2

}

CreateNewUser2()
{
	JSON='{
		"idfv": "$IDFV2",
		"nick_name": "macrophage",
		"first_name": "phage",
		"last_name": "macro",
		"pass": "macro",
		"gender": 1,
		"birth": "1800-01-30"
	}'
	
	Post /me "$JSON" 200
}

Main
