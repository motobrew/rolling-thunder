#!/bin/sh

WORKDIR=`dirname $0`
. $WORKDIR/env.txt
. $WORKDIR/func.sh

Main()
{
	Log 'INFO: 商品のいいね'
	
	Get /products/$PRODUCT_ID
	CompareResponseJson "更新前のlikes" 0 '.[].likes'

	LikeProduct

	Get /products/$PRODUCT_ID
	CompareResponseJson "更新後のlikes" 1 '.[].likes'

	LikeProduct

	Get /products/$PRODUCT_ID
	CompareResponseJson "更新後のlikes" 1 '.[].likes'
}

LikeProduct()
{
	JSON='{
		"product_id": "$PRODUCT_ID",
		"user_id": "$USER_ID2"
	}'

	Post /likes/products "$JSON" 200
}

Main

