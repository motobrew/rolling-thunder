#!/bin/sh

WORKDIR=`dirname $0`
. $WORKDIR/env.txt
. $WORKDIR/func.sh

Main()
{
	Log 'INFO: ユーザ/お店/売り場/商品の削除'
	
	DeleteProduct
	Get /products/$PRODUCT_ID 404

	DeleteBooth
	Get /booths/$BOOTH_ID 404

	DeleteStore
	Get /stores/$STORE_ID 404

	DeleteUser
	Get /users/$USER_ID 404
	Get /me 500
}

DeleteProduct()
{
	JSON='{ "user_id": "$USER_ID" }'

	Delete /products/$PRODUCT_ID "$JSON" 200
}

DeleteStore()
{
	JSON='{ "user_id": "$USER_ID" }'

	Delete /stores/$STORE_ID "$JSON" 200
}

DeleteBooth()
{
	JSON='{ "user_id": "$USER_ID" }'

	Delete /booths/$BOOTH_ID "$JSON" 200
}

DeleteUser()
{
	JSON='{ "user_id": "$USER_ID" }'

	Delete /me "$JSON" 200
}

Main
