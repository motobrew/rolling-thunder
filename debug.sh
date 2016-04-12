#!/bin/sh

WORKDIR=`dirname $0`
. $WORKDIR/env.txt
. $WORKDIR/func.sh

ItemList()
{
cat <<-EOF
	item001
	item901
EOF
}

Main()
{
	ItemList | while read item
	do
		Log "START: [$item]"
		. ${WORKDIR}/${item}.sh
		if [ $? -ne 0 ]; then
			exit 1
		fi
		Log "END: [$item]"
	done
	STATUS=$?

	#rm $RESPONSE_BODY

	return $STATUS
}

Main
