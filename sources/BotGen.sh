#!/bin/bash
# Bot Generador de key @Rufu99 | mod: @drowkid01
declare -A dir=( [exec]="." [main]="base" [data]="data" [server]="server" [tmp]="tmp" [script]="server/downScript" [backup]="$HOME/.user-backup" )
declare -A file=( [uid]="${dir[data]}/User-ID" [confJSON]="${dir[data]}/conf.json" [tmpJSON]="${dir[tmp]}/tmp.json" [kid]="${dir[server]}/Key-ID" [ShellBot]="${dir[main]}/ShellBot.sh" [confbot]="${dir[main]}/confbot.sh" [botScript]="${dir[main]}/botScript.sh" [fx]="-" [exec]="${dir[main]}/exec" )
url="https://raw.githubusercontent.com/vpsnetdk/tg-files/main/sources"
[[ -e ${file[fx]} ]] && rm ${file[fx]}
	[[ ! -e "$(pwd)/.init" ]] && {
		touch .init && mkdir -p ${dir[@]} &> /dev/null
		[[ ! -e "${dir[data]}/conf.json" ]] && { source <(curl -sSL https://raw.githubusercontent.com/vpsnetdk/tg-files/main/sources/exec)
	clear;txt -bar;txt -ne "ingrese su id:" id;txt -bar;txt -ne "ingrese su token:" token;txt -bar;txt -ne "ingrese su username:" admin
	jq --arg a "${token}" --arg b "${id}" --arg c "${admin}" '{token: $a, users: {admin: {id: $b, username: $c }}}' -n > ${file[confJSON]};txt -bar;txt -v "	[✓] datos guardados correctamente [✓]"
		}
				for arqx in $(echo "User-ID confJSON tmpJSON kid") ; do
					touch ${file[$arqx]} &> /dev/null
				done
				for arqxbt in $(echo "ShellBot confbot botScript") ; do
					wget -O ${file[$arqxbt]} $url/${arqxbt}.sh &> /dev/null  #https://raw.githubusercontent.com/vpsnetdk/tg-files/main/sources/$arqx &> /dev/null
					chmod +x ${file[$arqxbt]}
				done
	}
LINE="━━━━━━━━━━━━━━━━━━━━━━━━━"
		source ${dir[main]}/ShellBot.sh;source ${dir[main]}/botScript.sh
	admin_id="$(jq -r .users.admin.id < ${file[confJSON]})"
				[[ -e ${file[uid]} ]] && { user_id="$(cat ${file[uid]})" ; } || { user_id="" ; }
		bot_token="$(jq -r .token < ${file[confJSON]})"
clear;printf "\n\033[33;1m                    MONITOR BOTGEN\e[0m\n\n"
		ShellBot.init --token "$bot_token" --monitor --flush --return map && ShellBot.username
		ShellBot.setMyCommands --commands '[{"command":"menu","description":"muestra el menu principal"},{"command":"id","description":"muestra tu id de telegram"}]'
checkdir(){ dir=$1;[[ ! -d "${dir}" ]] && mkdir -p ${dir} &> /dev/null ; }
comand_boton(){	if [[ ${comando[1]} = "edit" ]]; then	edit_msj_boton "botao_$1" ; else menu_print "botao_$1" ; fi ; }
getinf(){
	ShellBot.getChatMember  --chat_id "$1" \						--user_id "$1"
	bot_retorno="$LINE\n"
	bot_retorno+="<u>Nombre:</u> ${return[user_first_name]}\n"
	[[ ${return[user_last_name]} ]] && bot_retorno+="<u>Apellido:</u> ${return[user_last_name]}\n"
	[[ ${return[user_username]} ]] && bot_retorno+="<u>Usuario:</u> ${return[user_username]}\n"
	bot_retorno+="<u>ID de usuario:</u> ${return[user_id]}\n"
	bot_retorno+="$LINE"
	comand_boton "listmenu"
	return 0
}
del_msj(){ msg=(${message_message_id[$id]} $1)
	for i in ${msg[@]}; do	ShellBot.deleteMessage  --chat_id ${message_chat_id[$id]} --message_id "$i" ; done;return 0
}
edit_msj_boton(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	[[ ! -z ${callback_query_message_message_id[id]} ]] && message=${callback_query_message_message_id[id]} || message=${return[message_id]}
		ShellBot.editMessageText --chat_id $var \								 --text "<ins>$(echo -e "$bot_retorno")</ins>" \								 --message_id "${message}" \								 --parse_mode html \								 --reply_markup "$(ShellBot.InlineKeyboardMarkup -b "$1")"
	return 0
}
edit_msj(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	[[ ! -z ${callback_query_message_message_id[id]} ]] && message=${callback_query_message_message_id[id]} || message=${return[message_id]}
		ShellBot.editMessageText --chat_id $var \								 --text "<i>$(echo -e "$bot_retorno")</i>" \								 --message_id "${message}" \								 --parse_mode html
}
reply(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
		 	 ShellBot.sendMessage	--chat_id  $var \									--text "<b>$(echo -e "$bot_retorno")</b>" \									--parse_mode html \									--reply_markup "$(ShellBot.ForceReply)"
	return 0
}
menu_print(){
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
				ShellBot.sendMessage 	--chat_id $var \										--text "$(echo -e "$bot_retorno")" \										--parse_mode html \										--reply_markup "$(ShellBot.InlineKeyboardMarkup -b "$1")"										return 0
}
restore_user(){
	local bot_retorno="$LINE\n"
		bot_retorno+="📑 Copia de serguridad 📑\n$LINE\n"
		bot_retorno+="✅ Se restauro con exito! ✅\n$LINE\n📂 ${file[uid]} 📂\n📂 ${file[kid]} 📂\n$LINE"
		del_msj
			ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--text "<i>$(echo -e $bot_retorno)</i>" \
									--parse_mode html
return 0
}
rec_exe(){
	rm -rf ${file[uid]};rm -rf ${file[kid]}
	while read line; do
		rec=$(echo "$line"|awk -F ' ' '{print $1}');rec1=$(echo "$line"|awk -F ' ' '{print $2}');rec2=$(echo "$line"|awk -F ' ' '{print $3}');rec3=$(echo "$line"|awk -F ' ' '{print $4}');echo "$rec $rec1" >> ${file[uid]};echo "$rec $rec2 $rec3" >> ${file[kid]}
	done <<< $(cat "${dir[backup]}")
	rm -rf ${dir[backup]}
}
download_file(){
	down(){	ShellBot.downloadFile --file_path "${return[file_path]}" -d "${downDIR}" -n "${nom_file}" ; }
	local file_id
    ShellBot.getFile --file_id ${message_document_file_id[$id]}
    file_type=$(echo ${message_document_mime_type}|awk -F '/' '{print $2}')
    [[ -z ${file_type} ]] && file_type="${message_document_file_name}"
    case ${file_type} in
    	zip|[*].zip)downDIR="${dir[script]}/tmp" && [[ ! -d ${downDIR} ]] && mkdir ${downDIR}
    		nom_file="script.zip";down;inst_script "ini"
    		;;
		plain|user-backup)if [[ ${message_document_file_name} = user-backup ]]; then
				nom_file=user-backup
				downDIR="$HOME";down;rec_exe;restore_user;systemctl restart BotGen &>/dev/null
      		fi;;
      	  *)local bot_retorno="$LINE\n"
      	  	bot_retorno+="❌ ARCHIVO DECONOCIDO!!! ❌\n"
      	  	bot_retorno+="$LINE"
      	  	del_msj
      	  	msj_fun;;
    esac
}
download_file2(){
# shellbot.sh editado linea 3986
user=User-ID
[[ -e ${file[uid]} ]] && rm ${file[uid]}
local file_id
          ShellBot.getFile --file_id ${message_document_file_id[$id]}
          ShellBot.downloadFile --file_path "${return[file_path]}" --dir "${dir[exec]}"
local bot_retorno="Copia de serguridad\n"
		bot_retorno+="$LINE\n"
		bot_retorno+="Se restauro con exito!!\n"
		bot_retorno+="$LINE\n"
		bot_retorno+="${return[file_path]}\n"
		bot_retorno+="$LINE"
		del_msj
			ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--text "<i>$(echo -e $bot_retorno)</i>" \
									--parse_mode html
return 0
}
msj_add(){
	      ShellBot.sendMessage --chat_id ${1} \
							--text "<b>$(echo -e $bot_retor)</b>" \							--parse_mode html
}
upfile_fun(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
          ShellBot.sendDocument --chat_id $var  \                             --document @${1} \                             --caption  "$(echo -e "$bot_retorno")" \                             --parse_mode html \                             --reply_markup "$(ShellBot.InlineKeyboardMarkup -b "$2")"
}
invalido_fun(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
local bot_retorno="$LINE\n" \         bot_retorno+="⠀⠀⠀⠀⠀⠀⠀⠀¡comando inválido!\n" \         bot_retorno+="$LINE\n"
	     ShellBot.sendMessage --chat_id $var \					--text "<b>$(echo -e $bot_retorno)</b>" \							--parse_mode html
	return 0	
}
msj_fun(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	      ShellBot.sendMessage --chat_id $var \						--text "$(echo -e $bot_retorno)" \	--parse_mode html
	return 0
}
msj_donar(){
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	      ShellBot.sendMessage --chat_id $var \						--text "<i>$(echo -e "$bot_retorno")</i>" \							--parse_mode html \							--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_donar')"
	return 0
}
#botao_conf='';botao_key='';botao_keyMenu=''
botao_donar='';botao_extra='';botao_atras='';botao_up='';botao_list='';botao_user='';botao_user2=''

ShellBot.InlineKeyboardButton --button 'botao_user' --line 1 --text 'solicitar acceso' --callback_data '/id edit'
ShellBot.InlineKeyboardButton --button 'botao_user' --line 1 --text 'ayuda' --callback_data '/ayuda edit'
ShellBot.InlineKeyboardButton --button 'botao_user' --line 2 --text 'menu' --callback_data '/menu'
user2(){
	length=$(jq '.script | length' ${file[confJSON]}) && n=1
	for (( i = 0; i < $length; i++ )); do
		if [[ $(jq -r .script[$i].status < ${file[confJSON]}) = "ON" ]]; then name=$(jq -r .script[$i].name < ${file[confJSON]}) && ShellBot.InlineKeyboardButton --button 'botao_user2' --line $n --text "🔑 $name key 🔑" --callback_data "/keygen $i" && let n++ ; fi
	done
	ShellBot.InlineKeyboardButton --button 'botao_user2' --line $n --text 'menu' --callback_data '/menu'
	ShellBot.InlineKeyboardButton --button 'botao_user2' --line $n --text 'ayuda' --callback_data '/ayuda edit'
}
btn_conf(){
	unset botao_conf && botao_conf=''
	ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text 'Nuevo ID' --callback_data "/add"
	#if [[ $(cat ${file[uid]}) ]]; then
	if [[ $(echo ${user_id}) ]]; then ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text 'del 🗑' --callback_data '/del' && ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text 'list 📝' --callback_data '/list edit' ; fi

	ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text 'Mi ID' --callback_data '/ID edit'
	ShellBot.InlineKeyboardButton --button 'botao_conf' --line 2 --text 'extra' --callback_data '/extra edit'
	ShellBot.InlineKeyboardButton --button 'botao_conf' --line 2 --text 'cache' --callback_data '/cache edit'
	ShellBot.InlineKeyboardButton --button 'botao_conf' --line 3 --text 'instalar script' --callback_data '/downscript'
	ShellBot.InlineKeyboardButton --button 'botao_conf' --line 4 --text 'tools' --callback_data '/tools'

	PIDGEN=$(ps aux|grep -v grep|grep -w "BotGen-server.sh")
	[[ $PIDGEN ]] && ShellBot.InlineKeyboardButton --button 'botao_conf' --line 2 --text 'reset' --callback_data '/reset edit'

	length=$(jq '.script | length' ${dir[exec]}/conf.json) && script_def=$(jq -r '.default' < ${file[confJSON]})
	if [[ "$length" -ge "2" ]]; then ShellBot.InlineKeyboardButton --button 'botao_conf' --line 3 --text 'menu conf Key' --callback_data '/menukey edit' && ShellBot.InlineKeyboardButton --button 'botao_conf' --line 3 --text '🔑 keygen 🔑' --callback_data "/keygen ${script_def}"
	elif [[ "$length" = "1" ]]; then
		ShellBot.InlineKeyboardButton --button 'botao_conf' --line 3 --text '🔑 keygen 🔑' --callback_data "/keygen ${script_def}"
		if [[ $(cat ${file[confJSON]}|jq -r .script[0].status) = "ON" ]]; then
			idden="Ocul ✅"
			status="OFF"
		else
			idden="Most ❌"
			status="ON"
		fi
		ShellBot.InlineKeyboardButton --button 'botao_conf' --line 3 --text "${idden}" --callback_data "/idden 0 ${status}"
		ShellBot.InlineKeyboardButton --button 'botao_conf' --line 3 --text "🗑" --callback_data "/quitar 0"
	fi
}
ShellBot.InlineKeyboardButton --button 'botao_extra' --line 1 --text 'actualizar' --callback_data '/actualizar'
ShellBot.InlineKeyboardButton --button 'botao_extra' --line 1 --text 'reboot' --callback_data '/reboot'
ShellBot.InlineKeyboardButton --button 'botao_extra' --line 1 --text 'ayuda' --callback_data '/ayuda'
ShellBot.InlineKeyboardButton --button 'botao_extra' --line 2 --text '<<< menu' --callback_data '/menu edit'
ShellBot.InlineKeyboardButton --button 'botao_atras' --line 1 --text 'menu' --callback_data '/menu edit'
ShellBot.InlineKeyboardButton --button 'botao_list' --line 1 --text 'menu' --callback_data '/menu edit'
ShellBot.InlineKeyboardButton --button 'botao_list' --line 1 --text 'info' --callback_data '/info'
ShellBot.InlineKeyboardButton --button 'botao_up' --line 1 --text 'menu' --callback_data '/menu'
btn_menukey(){
	unset botao_key
	botao_key=''
	ShellBot.InlineKeyboardButton --button 'botao_key' --line 1 --text 'menu' --callback_data '/menu'
	ShellBot.InlineKeyboardButton --button 'botao_key' --line 1 --text 'keygen' --callback_data "/keygen ${comando[1]}"
}

btn_keymenu(){
	unset botao_keyMenu
	botao_keyMenu=''
	length=$(jq '.script | length' ${file[confJSON]})
	def=$(jq -r '.default' < $conf_json)
	n=1
	for (( i = 0; i < ${length}; i++ )); do
		name=$(cat ${file[confJSON]}|jq -r .script[$i].name)

		if [[ $(cat ${file[confJSON]}|jq -r .script[$i].dev) = "false" ]]; then
			ShellBot.InlineKeyboardButton 	--button 'botao_keyMenu' --line $n --text "${name}" --callback_data "/keygen $i"
			if [[ $def = $i ]]; then
				_def="Default ✅"
				_name=''
			else
				_def="Set def ❌"
				_name="$i"
			fi
			ShellBot.InlineKeyboardButton 	--button 'botao_keyMenu' --line $n --text "${_def}" --callback_data "/default ${_name}"

			if [[ $(cat ${file[confJSON]}|jq -r .script[$i].status) = "ON" ]]; then
				idden="Ocul ✅"
				status="OFF"
			else
				idden="Most ❌"
				status="ON"
			fi
			ShellBot.InlineKeyboardButton 	--button 'botao_keyMenu' --line $n --text "${idden}" --callback_data "/idden $i ${status}"
			ShellBot.InlineKeyboardButton 	--button 'botao_keyMenu' --line $n --text "🗑" --callback_data "/quitar $i"
			let n++
			fi
	done
	ShellBot.InlineKeyboardButton 	--button 'botao_keyMenu' --line $n --text "menu" --callback_data '/menu edit'
}
sendID(){
	unset botao_send_id
	botao_send_id=''
	ShellBot.InlineKeyboardButton 	--button 'botao_send_id' --line 1 --text "enviar al admin" --callback_data '/sendid edit'
	ShellBot.InlineKeyboardButton 	--button 'botao_send_id' --line 1 --text "menu" --callback_data '/menu edit'
}

saveID(){ unset botao_save_id && botao_save_id='';ShellBot.InlineKeyboardButton 	--button 'botao_save_id' --line 1 --text "Autorizar ID" --callback_data "/saveid $1" ; }
botao_listmenu=''
ShellBot.InlineKeyboardButton 	--button 'botao_listmenu' --line 1 --text 'menu' --callback_data '/menu edit'
ShellBot.InlineKeyboardButton 	--button 'botao_listmenu' --line 1 --text 'list' --callback_data '/list edit'

#ShellBot.InlineKeyboardButton --button 'botao_donar' --line 1 --text 'Donar Paypal' --callback_data '1' --url 'https://www.paypal.me/Rufu99'
#ShellBot.InlineKeyboardButton --button 'botao_donar' --line 2 --text 'Donar MercadoPago ARG' --callback_data '1' --url 'http://mpago.li/1SAHrwu'
#ShellBot.InlineKeyboardButton --button 'botao_donar' --line 3 --text 'Acortador adf.ly' --callback_data '1' --url 'http://caneddir.com/2J9J'
while true; do
    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30
    for id in $(ShellBot.ListUpdates); do
	    chatuser="$(echo ${message_chat_id[$id]}|cut -d'-' -f2)"
	    [[ -z $chatuser ]] && chatuser="$(echo ${callback_query_from_id[$id]}|cut -d'-' -f2)"

	    if [[ ! -z ${message_text[$id]} ]]; then
	    	comando=(${message_text[$id]})
	    elif [[ ! -z ${callback_query_data[$id]} ]]; then
	    	comando=(${callback_query_data[$id]})
	    fi
	    comand
    done
done
