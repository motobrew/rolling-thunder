OK()
{
	Log "OK: $1"
}
NG()
{
	Log "NG: $1"
}
Log()
{
#	echo "### `date '+%Y/%m/%d %H:%M:%S'`: $1"
	echo "### $1" 1>&2
}

ConvertJson()
{
	TempJson=`echo "$1" | sed -e 's/"/\\\\"/g'`
	eval echo $TempJson
}

ResponseJson()
{
	cat $RESPONSE_BODY | jq "$1" | tr -d \"
}

# ContainReopnseJson()
# レスポンスの中のある配列に引数の値が含まれていればTRUEを返す
# 含まれていなければ NG EXIT
ContainResponseJson()
{
	Message=$1
	Data=$2
	Array=`ResponseJson "$3"`

	for val in $Array
	do
		if [ "$val" = "$Data" ]; then
			OK "$Message [$Data] $Array"
			return 0
		fi
	done

	NG "$Message [$Data]"
	exit 1
}

# CompareResponseJson()
# レスポンスの中のある要素が引数の値に一致すればTRUEを返す
# 一致しなければ NG EXIT
CompareResponseJson()
{
	Message=$1
	CompareData=$2
	ResponseData=`ResponseJson "$3" `

	if [ "$ResponseData" == "$CompareData" ]; then
		OK "$Message 期待値[$CompareData] 結果[$ResponseData]"
		return 0
	else
		NG "$Message 期待値[$CompareData] 結果[$ResponseData]"
		exit 1
	fi
}

RequestWebAPI()
{
	case $method in
	GET)
		cmd="curl --compressed -s -o $RESPONSE_BODY -X $method -H 'Authorization: miti_token $MITI_TOKEN' -w '%{http_code}' ${BASE_URL}$url "
#		cmd="curl -s -o $RESPONSE_BODY -X $method -H 'Authorization: miti_token $MITI_TOKEN' -w '%{http_code}' ${BASE_URL}$url "
    	;;
    POST|PUT|DELETE)
		cmd="curl -s -o $RESPONSE_BODY -X $method -H 'Authorization: miti_token $MITI_TOKEN' -H 'Content-Type: application/json' -d '$data' -w '%{http_code}' ${BASE_URL}$url "
    	;;
    esac

	[ "$DEBUG" == 1 ] && Log "EXEC: $cmd"
	response_code=`eval $cmd`
	status=$?
	if [ $status -ne 0 ]; then
		NG "curl status: $status"
		exit 1
	fi

	if [ -z "$expected" ]; then
		OK "$method $url"
	else
		if [ "$response_code" = "$expected" ]; then
			OK "$response_code $method $url"
		else
			NG "$response_code $method $url"
			cat $RESPONSE_BODY | grep message
			exit 1
		fi
	fi
}

Get()
{
	method=GET
	url=$1
	expected=$2

	RequestWebAPI
}

Post()
{
	method=POST
	url=$1
	data=`ConvertJson "$2"`
	expected=$3

	RequestWebAPI
}

Put()
{
	method=PUT
	url=$1
	data=`ConvertJson "$2"`
	expected=$3

	RequestWebAPI
}

Delete()
{
	method=DELETE
	url=$1
	data=`ConvertJson "$2"`
	expected=$3

	RequestWebAPI
}

SetToken()
{
	scope=$1
	grant_type=$2

	case "$grant_type" in
	"idfv")
		idfv=$3
		JSON='{
			"grant_type": "idfv",
			"idfv": "$idfv",
			"scope": "$scope"
		}'
		;;
	*)
		return
		;;
	esac

	Post /token "$JSON" 200
	MITI_TOKEN=`ResponseJson .[].access_token`
}


