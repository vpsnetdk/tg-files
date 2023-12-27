#!/bin/bash
source <(curl -sSL https://raw.githubusercontent.com/vpsnetdk/tg-files/main/sources/exec)
declare -A dir=( [0]="." )
ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="x";;
"x")txt[$i]=".";;
"5")txt[$i]="s";;
"s")txt[$i]="5";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"4")txt[$i]="0";;
"0")txt[$i]="4";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
check_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}

edit_cost () {
msg -bar
echo -e "\033[1;37mRECUERDA EDITAR LOS COSTOS O TIEMPOS\n Para Salir Ctrl + C o 0 Para Regresar\033[1;33m"
echo -e " \033[1;31m[ !!! ]\033[1;33m RECUERDA, UNA VEZ EDITADO NO PODRAS VOLVER A \n TENER EL ORIGINAL, A MENOS QUE REINSTALES   \033[1;31m\033[1;33m"
msg -bar 
echo -e " \033[1;31mLuego de editar Presiona Ctrl + O y Enter \033[1;33m \033[1;31m\033[1;33m"
echo -e " \033[1;31m          Por Ultimo Ctrl + X  \033[1;33m \033[1;31m\033[1;33m"
echo -ne "\033[1;37m"
read -p " Presiona Enter para Continuar "
nano ${dir[0]}/sources/costes
systemctl restart BotGen-server &>/dev/null
echo -e " MODIFICADO EXITOSAMENTE"
bot_gen
}

change_pay () {
unset option
clear
echo -e "$bar"
echo -e "  MENSAJE ACTUAL $(cat < /etc/mpayu)"
echo -e "$bar"
echo -e "  \033[1;37mINGRESA TU METODO DE PAGO Y/O CORREO"
echo -e "$bar\n"
echo -e "Ingresa en este Orden o Secuencia \n PAYPAL : chumogh@gmail.com \n"
echo -e "$bar"
read -p "TEXTO: " opcion
[[ -z $opcion ]] && bot_gen && exit || echo "$opcion" > /etc/mpayu && echo "TOKEN APLICADO EXITOSAMENTE"
read -p " Enter para Continuar"
echo -e "$bar"
echo -e "  \033[1;37m NUMERO DE CONTACTO ACTUAL $(cat < /etc/numctc) "
echo -e "$bar\n"
echo -e " Ingresa en este Orden o FORMATO \n   593987072611  \n"
echo -e "$bar"
read -p "TEXTO: " opcion1
opcion1="$(echo -e "$opcion1" | sed -e 's/[^0-9]//ig')"
[[ -z $opcion ]] && return || { 
echo -e "$opcion1" > /etc/numctc
chmod +x /etc/numctc
echo "TOKEN APLICADO EXITOSAMENTE"
systemctl restart BotGen-server &>/dev/null
}
echo -e "$bar\n"
echo -e " AGREGA NUEVO URL DE CATALOGO / OPCIONAL \n  https://shoppy.gg/@drowkid01/  \n"
echo -e "$bar"
read -p "TEXTO: " nmsg
[[ -z $nmsg ]] && return || { 
echo -e "$nmsg" > /etc/urlCT
chmod +x /etc/urlCT
echo "URL APLICADO EXITOSAMENTE"
systemctl restart BotGen-server &>/dev/null
}
echo -e "$bar\n"
echo -e " AGREGA NUEVO ENLACE PARA DONACIONES / OPCIONAL \n  https://www.paypal.com/paypalme/ChumoGH  \n"
echo -e "$bar"
read -p "TEXTO: " donat
[[ -z $donat ]] && return || { 
echo -e "$donat" > /etc/urlDN
chmod +x /etc/urlDN
echo "URL APLICADO EXITOSAMENTE"
systemctl restart BotGen-server &>/dev/null
}
read -p " Enter para Continuar"
systemctl restart BotGen-server &>/dev/null
bot_gen
}

lim-bot () {
unset option
clear
echo -e "$bar"
echo -e "  \033[1;37mIngrese el Limite del Bot"
echo -e "$bar"
echo -n "Limite: "
read opcion
echo "$opcion" > ${CIDdir}/limit
echo "$opcion" > /etc/limit
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "kill_drop.sh")
if [[ ! $PIDGEN ]]; then
	msg -bar
	echo -ne "\033[1;97m Poner en linea KILL ID [s/n]: "
	read bot_ini
	msg -bar
[[ $bot_ini = @(s|S|y|Y) ]] && {

	echo -e "[Unit]
Description=BotGen Service by @drowkid01
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/bin/bash ${dir[0]}/sources/kill_drop.sh 
Restart=always
RestartSec=60s

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/btkill.service
	systemctl enable btkill &>/dev/null
	systemctl start btkill &>/dev/null
	msg -bar
	echo -e "\033[1;31m            Bot ID KILL ACTIVADO"
	msg -bar
	}
else
killall kill_drop.sh &>/dev/null
systemctl stop btkill &>/dev/null
systemctl disable btkill &>/dev/null
rm /etc/systemd/system/btkill.service &>/dev/null
clear
msg -bar
echo -e "\033[1;31m            Bot ID KILL fuera de linea"
msg -bar
fi
read -p "Presione Enter para continuar "
bot_gen


#echo "sed -i "s/1001282138571/0/g" /etc/gerar-sh-log
#echo '#!/bin/bash -e
#sleep 24h' > ${CIDdir}/sumlimit
#echo 'newq=$(cat < ${dir[0]}/limit)
#opcion=$(cat < /etc/limit)
#newsum=$(($newq + $opcion))
#echo "$newsum" > ${dir[0]}/limit
#screen -dmS sumlimit bash ${dir[0]}/sumlimit&
#exit' >> ${CIDdir}/sumlimit
#echo -e "$bar"
#read -p "Presione Enter para continuar "
#screen -dmS sumlimit bash ${dir[0]}/sumlimit&
#bot_gen
}

veryfy_fun () {
SRC="${dir[0]}/sources" && [[ ! -d ${SRC} ]] && mkdir ${SRC}
unset ARQ
case $1 in
"BotGen.sh")ARQ="${dir[0]}/";;
*)ARQ="${dir[0]}/main/";;
esac
mv -f $HOME/update/$1 ${ARQ}/$1 && echo -e "\033[1;31m- \033[1;32mRecibido!" || echo -e "\033[1;31m- \033[1;31mFalla (no recibido!)"
chmod +x ${ARQ}/$1
}

download () {
clear
msg -bar
echo -e "\033[1;33mDescargando archivos... ESPERE "
msg -bar
wget -q --no-check-certificate -O $HOME/files.tar #
[[ -d $HOME/update ]] && rm -rf $HOME/update/* || mkdir $HOME/update
[[ -e $HOME/files.tar ]] && tar xpf $HOME/files.tar -C $HOME/update && rm -f $HOME/files.tar
echo 999 > ${CIDdir}/limit
n=1
for arqx in `ls $HOME/update`; do
echo -ne "\033[1;33mFichero \033[1;31m[${n}.bot] "
[[ -e $HOME/update/$arqx ]] && veryfy_fun $arqx
n=$(($n + 1))
done
cd $HOME && rm -rf $HOME/update && rm -f $HOME/files.tar
echo -ne "\033[1;31m[ ! ] RESTAUDANDO ADMINISTRADOR "
(
[[ -e $HOME/costes ]] && mv $HOME/costes ${dir[0]}/sources/costes 
[[ -e $HOME/token ]] && mv $HOME/token ${dir[0]}/token 
[[ -e $HOME/resell ]] && mv $HOME/resell ${dir[0]}/resell
[[ -e $HOME/Admin-ID ]] && mv $HOME/Admin-ID ${dir[0]}/Admin-ID 
[[ -e $HOME/User-ID ]] && mv $HOME/User-ID ${dir[0]}/User-ID 
[[ -e $HOME/ress ]] && mv $HOME/ress ${dir[0]}/ress
[[ -e $HOME/limit ]] && mv $HOME/limit ${dir[0]}/limit
[[ -e $HOME/num-key.cont ]] && mv $HOME/num-key.cont ${dir[0]}/num-key.cont
) && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
[[ ! -e ${CIDdir}/resell ]] && echo "@drowkid01" > ${CIDdir}/resell
[[ ! -e $(cat < /etc/mpayu) ]] && echo "Paypal : chumogh@outlook.com" > /etc/mpayu && echo "593987072611" > /etc/numctc
 rm $HOME/lista-arq
 systemctl restart BotGen-server &>/dev/null
 bot_gen
}

ini_token () {
clear
echo -e "$bar"
echo -e "  \033[1;37mIngrese el token de su bot"
echo -e "$bar"
echo -n "TOKEN: "
read opcion
echo "$opcion" > ${CIDdir}/token
echo -e "$bar"
echo -e "  \033[1;32mtoken se guardo con exito!" && echo -e "$bar" && echo -e "  \033[1;37mPara tener acceso a todos los comandos del bot\n  deve iniciar el bot en la opcion 2.\n  desde su apps (telegram). ingresar al bot!\n  digite el comando \033[1;31m/id\n  \033[1;37mel bot le respodera con su ID de telegram.\n  copiar el ID e ingresar el mismo en la opcion 3" && echo -e "$bar"
read -p "Presione Enter para continuar "
bot_gen
}

ini_res () {
clear
txt -bar;txtct "user del admin";txt -bar;txt -ne "Alias:" alias;echo "$alias" > ${CIDdir}/resell;txt -bar
read -p "Presione Enter para continuar "
bot_gen
}

ini_id () {
clear;txt -bar;txt -ne "Ingresa tu ID:" id;echo "$id" > ${CIDdir}/Admin-ID;txt -bar;read -p "Presione Enter para continuar "
bot_gen
}

start_bot () {
[[ ! -e "${CIDdir}/token" ]] && echo "null" > ${CIDdir}/token
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "BotGen.sh")
if [[ ! $PIDGEN ]]; then
echo -e "[Unit]
Description=BotGen Service by @drowkid01
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/bin/bash ${CIDdir}/BotGen.sh -start
Restart=always
RestartSec=3s

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/BotGen-server.service

		systemctl enable BotGen-server &>/dev/null
    	systemctl start BotGen-server &>/dev/null
else
killall BotGen.sh &>/dev/null
systemctl stop BotGen-server &>/dev/null
systemctl disable BotGen-server &>/dev/null
rm /etc/systemd/system/BotGen-server.service &>/dev/null
clear
msg -bar
echo -e "\033[1;31m            BotGen fuera de linea"
msg -bar
read -p "Presione Enter para continuar "
fi
bot_gen
}
bot_conf () {
[[ -e ${dir[0]}/token ]] && mv ${dir[0]}/token /root/token
[[ -e ${dir[0]}/Admin-ID ]] && mv ${dir[0]}/Admin-ID /root/Admin-ID
check_ip
function_verify
instaled=${dir[0]}/sources && [[ ! -d ${instaled} ]] && download
}

msj_prueba () {

TOKEN="$(cat ${dir[0]}/token)"
ID="$(cat ${dir[0]}/Admin-ID)"

[[ -z $TOKEN ]] && {
	clear
	echo -e "$bar"
	echo -e "\033[1;37m Aun no a ingresado el token\n No se puede enviar ningun mensaje!"
	echo -e "$bar"
	read foo
} || {
	[[ -z $ID ]] && {
		clear
		echo -e "$bar"
		echo -e "\033[1;37m Aun no a ingresado el ID\n No se puede enviar ningun mensaje!"
		echo -e "$bar"
		read foo
	} || {
		MENSAJE="---------📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩--------\n"
		MENSAJE+="Esto es un mesaje de prueba!\n"
		MENSAJE+="$bar\n"
		URL="https://api.telegram.org/bot$TOKEN/sendMessage"
		curl -s -X POST $URL -d chat_id=$ID -d text="$MENSAJE" &>/dev/null
		clear
		echo -e "---------📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩--------\n"
		echo -e "\033[1;37m Mensaje enviado Exitosamente...!"
		echo -e "$bar"
		sleep 3s
	}
}

bot_gen
}

addnewmss() {
unset yesno
unset dnew
let foc++
echo -e "$bar"
echo -e "  \033[1;37mINGRESA EL MENSAJE A ENVIAR"
echo -e "$bar"
read -p " $foc TEXTO: " addmss 
MSS+="$addmss\n"
echo -e "${cor[3]} ¿DESEAS AÑADIR OTRO SMS ? "
read -p " [S/N]: " -e -i s sshsn
tput cuu1 && tput dl1
tput cuu1 && tput dl1
[[ "$sshsn" = @(s|S|y|Y) ]] && addnewmss
}



msj_ind () {
foc=1
TOKEN="$(cat ${dir[0]}/token)"
echo -e "$bar" 
echo -e "  \033[1;37mIngrese su ID de telegram a Mensajear"
echo -e "$bar"
read -p "ID: " ID 
[[ -z $ID ]] && ID="$(cat ${dir[0]}/Admin-ID)"
[[ -z $TOKEN ]] && {
	clear
	echo -e "$bar"
	echo -e "\033[1;37m Aun no a ingresado el token\n No se puede enviar ningun mensaje!"
	echo -e "$bar"
	read foo
} || {
	[[ -z $ID ]] && {
		clear
		echo -e "$bar"
		echo -e "\033[1;37m Aun no a ingresado el ID\n No se puede enviar ningun mensaje!"
		echo -e "$bar"
		read foo
	} || {
		MENSAJE="Hola, Mensale de Prueba del BotGen Generador!"
echo -e "$bar"
echo -e "  \033[1;37mINGRESA EL MENSAJE A ENVIAR"
echo -e "$bar"
read -p " $foc TEXTO: " addmss 
MSS+="$addmss\n"
echo -e "${cor[3]} ¿DESEAS AÑADIR OTRO SMS ? "
read -p " [S/N]: " -e -i s sshsn
tput cuu1 && tput dl1
tput cuu1 && tput dl1
[[ "$sshsn" = @(s|S|y|Y) ]] && addnewmss
MENSAJE='  ---------📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩--------\n'
MENSAJE+="$MSS \n "
echo -e "$bar"
echo -e "  \033[1;37mPEGA RUTA DE IMAGEN"
echo -e "$bar"
read -p "IMG: " img 
#[[ -z $img ]] && img="https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/favi.png"
#[[ -z $img ]] && img="/var/www/html/bot_vmess_qr.png"
[[ -z $MENSAJE ]] && MENSAJE="Hola, Mensale de Prueba del BotGen Generador!"
		URL="https://api.telegram.org/bot$TOKEN/sendMessage"
		URG="https://api.telegram.org/bot$TOKEN/sendPhoto"
		curl -s -X POST $URG -F chat_id=$ID -F photo="@$img" #-F caption="<code>New Script @drowkid01</code>" #-F width="100" -F height="100"
		curl -s -X POST $URL -d chat_id=$ID -d text="$(echo -e "$MENSAJE")" &>/dev/null
#		clear
		echo -e "@$img"
		echo -e "$bar"
		echo -e "\033[1;37m Mensaje enviado Exitosamente...!"
		echo -e "$bar"
		read -p "ENTER PARA Continuar"
	}
}

bot_gen
}



act-bot () {
echo "Respaldando TOKEN y ADMINISTRADOR" 
[[ -e ${dir[0]}/token ]] && mv ${dir[0]}/token /root/token
[[ -e ${dir[0]}/Admin-ID ]] && mv ${dir[0]}/Admin-ID /root/Admin-ID
[[ -e ${dir[0]}/User-ID ]] && mv ${dir[0]}/User-ID /root/User-ID
[[ -e ${dir[0]}/ress ]] && mv ${dir[0]}/ress /root/ress
[[ -e ${dir[0]}/sources/costes ]] && mv ${dir[0]}/sources/costes /root/costes
[[ $(cat < ${dir[0]}/resell) != "@drowkid01" ]] && mv ${dir[0]}/resell /root/resell
rm -rf ${dir[0]}/sources/gerar_key && download
}

respon () {
[[ ! -e /etc/menu_ito ]] && credd=$(cat < /etc/SCRIPT/menu_credito) || credd=$(cat /etc/menu_ito ) 
[[ -e ${CIDdir}/ress ]] && {
echo -e "DESACTIVANDO RESELLER $credd FIJO EN BotGEN"
echo -e "   AHORA SE FIJARA EL NOMBRE DE QUIEN GENERE LA KEY"
read -p "ENTER PARA VOLVER"
rm -f ${CIDdir}/ress 
} || { 
echo -e "ACTIVANDO RESELLER $credd FIJO EN BotGEN"
echo -e "AHORA SE FIJARA $credd EN TODAS LAS KEYS "
read -p "ENTER PARA VOLVER"
touch ${CIDdir}/ress
}
bot_gen
}


bot_gen () {
clear
unset PID_GEN
CIDdir=${dir[0]} && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
PID_GEN=$(ps x|grep -v grep|grep "BotGen.sh")
PID_on=$(ps x|grep -v grep|grep "modelid")
[[ ! $PID_on ]] && PID_on="\033[1;31mOFF" || PID_on="\033[1;32mON"
[[ ! -e /etc/systemd/system/btkill.service ]] && PID_kill="\033[1;31mOFF" || PID_kill="\033[1;32mON"
[[ ! $PID_GEN ]] && PID_GEN="\033[1;31mOFF" || PID_GEN="\033[1;32mON"
[[ -e ${CIDdir}/token ]] && tk="\033[1;32mOK" || tk="\033[1;31mNULL"
[[ -e /etc/numctc ]] && nm="\033[1;32mNUM" || nm="\033[1;31mNULL"
[[ -e /etc/urlDN ]] && dn="\033[1;32mDON" || dn="\033[1;31mNULL"
[[ -e /etc/urlCT ]] && ct="\033[1;32mCAT" || ct="\033[1;31mNULL"
[[ -e ${CIDdir}/Admin-ID ]] && adid="\033[1;32mOK" || adid="\033[1;31mNULL"
[[ -e ${CIDdir}/ress ]] && rfij="\033[1;32mRESELLER FIJO (Bot Personal )" || rfij="\033[1;31mRESELLER ALEATORIO ( Bot Custom )"
limcont=$(cat ${dir[0]}/limit) 
[[ "${limcont}" = "999" ]] && limted=" ∞ " || limted=$(cat ${dir[0]}/limit)
msg -bar
echo -e "  - LIMITADOR \033[1;32m ( $limted ) \033[1;37m KILL ID VENCIDOS ${PID_kill} "
msg -bar 
echo -e "\033[0;35m[\033[0;36m1\033[0;35m] \033[0;35m> \033[1;37m TOKEN DEL BOT $tk "
echo -e "\033[0;35m[\033[0;36m2\033[0;35m] \033[0;35m> \033[1;37m INICIAR/PARAR BOT $PID_GEN\033[0m"
echo -e "\033[0;35m[\033[0;36m3\033[0;35m] \033[0;35m> \033[1;37m ID DE USUARIO TELEGRAM  $adid"
echo -e "\033[0;35m[\033[0;36m4\033[0;35m] \033[0;35m> \033[1;37m Cambiar Contacto -> $(cat < ${CIDdir}/resell)"
echo -e "\033[0;35m[\033[0;36m5\033[0;35m] \033[0;35m> \033[1;37m MENSAJE DE PRUEBA"
echo -e "\033[0;35m[\033[0;36m6\033[0;35m] \033[0;36m> \033[1;37m MANUAL De Uso"
echo -e "\033[0;35m[\033[0;36m7\033[0;35m] \033[0;35m> \033[1;37m Limite de KEYS "
echo -e "\033[0;35m[\033[0;36m8\033[0;35m] \033[0;35m> \033[1;37m ENLACES $nm | $dn | $ct "
echo -e "\033[0;35m[\033[0;36m9\033[0;35m] \033[0;35m> \033[1;37m $rfij"
echo -e "\033[0;35m[\033[0;36m10\033[0;35m] \033[0;35m> \033[1;37m MSG POR ID"
echo -e "\033[0;35m[\033[0;36m11\033[0;35m] \033[0;35m> \033[1;37m Modificar COSTES DEL BOT"
msg -bar
echo -e "\033[0;35m[\033[0;36m0\033[0;35m] \033[0;34m<\033[0;33m SALIR"
msg -bar
selection=$(selection_fun 11)
case ${selection} in
0) gerar && exit ;;
1) ini_token;;
2) start_bot;;
3) ini_id;;
4) ini_res;;
5) msj_prueba;;
6) ayuda_fun;;
#7) source <(curl -sSL https://www.dropbox.com/s/f5mlwun3hkpq6k8/bot-permited.sh) ;;
#8) act-bot ;;
7) lim-bot ;;
8) change_pay;;
9) respon;;
10)msj_ind;;
11)edit_cost;;
*) bot_gen;;
esac
}
