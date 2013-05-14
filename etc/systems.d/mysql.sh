# mysql system blargup script

mysql_backup() {
for mysql_db in "$@"; do
	case "$mysql_db" in
		'*')
			mysql_backup $(echo 'show databases;' \
				| mysql $mysql_opts \
				| egrep -v 'Database|information_schema|performance_schema|mysql|\*')
		;;
		'**')
			mysqldump $mysql_opts --events --all-databases >"$mysql_destdir/mysqldump.sql"
		;;
		*)
			mysqldump $mysql_opts --databases "$mysql_db" >"$mysql_destdir/${mysql_db}dump.sql"
		;;
	esac
done
}

mysql_backup "${mysql_dbs[@]}"

