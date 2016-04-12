#!/bin/sh

WORKDIR=`dirname $0`
. $WORKDIR/env.txt
. $WORKDIR/func.sh

ItemList()
{
	ItemList1
	ItemList2
}

ItemList2()
{
cat <<-EOF
	item001
	item011
	item002
	item031
	item032
	item033
	item034
	item091
	item081
EOF
}

ItemList1()
{
cat <<-EOF
	item001
	item054
	item071
	item072
	item081
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

	rm $RESPONSE_BODY

	return $STATUS
}

Main
