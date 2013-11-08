# rotate backup system
# rotate options
rotate_targets=(/foo/backup/$HOSTNAME /foo/backup/$HOSTNAME.{0..7})

rotate_num="${#rotate_targets[@]}"

if [[ "$rotate_num" -lt 2 ]]; then
	die "Not enough targets: $rotate_num"
fi

echo rm -rf ${rotate_targets[rotate_num-1]}
if [[ -e "${rotate_targets[rotate_num-1]}" ]]; then
	rm -rf "${rotate_targets[rotate_num-1]}"
fi

for ((i=rotate_num-2; i>0; i--)); do
	if [[ -e "${rotate_targets[i]}" ]]; then
		mv "${rotate_targets[i]}" "${rotate_targets[i+1]}"
	fi
done

if [[ -e "${rotate_targets[0]}" ]]; then
	case "$rotate_type" in
	  'link') cp -al "${rotate_targets[0]}" "${rotate_targets[1]}" ;;
	  *)      mv "${rotate_targets[0]}" "${rotate_targets[1]}" ;;
	esac
fi

