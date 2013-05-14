# rsync-pull backup system

rsync_pull_source="$rsync_pull_user@$rsync_pull_host"
rsync_pull_source="${rsync_pull_source#@}"

for rsync_pull_src in "${rsync_pull_srcs[@]}"; do
	rsync $rsync_pull_opts "$rsync_pull_source:${rsync_pull_src%/}" "${rsync_pull_dest%/}"
done

