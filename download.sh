# ユーザーとホスト
USER=user_name
HOST=example.example.jp

# SSH
ID_RSA=/home/user_name/.ssh/id_rsa

# 作業した時刻の取得
WORK_DATE=`date +%Y%m%d_%H%M%S`

# サイトディレクトリ
SITEDIR=/home/user_name/public_html/path

# バックアップディレクトリ作成
BACKUP_DIR=backup_$WORK_DATE
if [ ! -d $BACKUP_DIR ]; then
  mkdir $BACKUP_DIR
fi

# ログ用ディレクトリ作成
LOGDIR=log
if [ ! -d $LOGDIR ]; then
  mkdir $LOGDIR
fi

result=$(sftp -i $ID_RSA $USER@$HOST << EOF 2>&1

cd ${SITEDIR}
# ↓ローカルにscssフォルダを作成しないといけない！
get -r to/file.scss ./${BACKUP_DIR}/to/file.scss

EOF
)

echo "$result" > log/$WORK_DATE.log