#!/bin/sh

WORKDIR=`dirname $0`
. $WORKDIR/env.txt
. $WORKDIR/func.sh

Main()
{
	Log 'INFO: ユーザの登録とトークンの取得'

	IDFV1=`uuidgen`

	SetToken new_user idfv $IDFV1

	CreateNewUser 
	USER_ID=`ResponseJson .[].user_id `

	SetToken universe idfv $IDFV1

}

CreateNewUser()
{
	JSON='{
		"idfv": "$IDFV1",
		"nick_name": "mogumogu",
		"first_name": "mogu",
		"last_name": "mogu",
		"pass": "mogu2",
		"gender": 0,
		"birth": "2000-01-30"
	}'
	
	Post /me "$JSON" 200
}

Main
