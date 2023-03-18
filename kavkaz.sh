
# Options
. <(wget -qO- https://raw.githubusercontent.com/letsnode/Utils/main/bashbuilder/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/letsnode/Utils/main/bashbuilder/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script performs many actions related to a Kusama node"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h,  --help    show the help page"
		echo -e "  -u,  --update  update the node"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://raw.githubusercontent.com/letsnode/Utils/main/installers/golang.sh - script URL"
		echo -e "https://t.me/letskynode — node Community"
		echo -e "https://teletype.in/@letskynode — guides and articles"
		echo
		return 0 2>/dev/null; exit 0
		;;
	-u|--update)
		function="update"
		shift
		;;
	*|--)
		break
		;;
	esac
done

# Functions
printf_n(){ printf "$1\n" "${@:2}"; }
install() {
	printf_n "${C_R}I don't want.${RES}"
}
update() {
	printf_n "${C_LGn}Checking for update...${RES}"
	status=`docker pull parity/polkadot`
	if ! grep -q "Image is up to date for" <<< "$status"; then
		printf_n "${C_LGn}Updating...${RES}"
		docker stop kusama_node
		docker rm kusama_node
                docker run -dit --name kusama_node --restart always --network host -v $HOME/.kusama:/data -u $(id -u ${USER}):$(id -g ${USER}) parity/polkadot --base-path /data --chain kusama --validator --name "kavkaz" --port 30333 --ws-port 9944 --rpc-port 9933 --prometheus-port 9615 --telemetry-url 'wss://telemetry-backend.w3f.community/submit 1' --telemetry-url 'wss://telemetry.polkadot.io/submit/ 1'
	else
		printf_n "${C_LGn}Node version is current!${RES}"
	fi
}

# Actions
sudo apt install wget -y &>/dev/null
. /root/.bash_profile
. <(wget -qO- https://raw.githubusercontent.com/letsnode/Utils/main/bashbuilder/logo.sh)
cd
$function
