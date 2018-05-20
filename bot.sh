#!/bin/bash
#====================================================================================

BOT_API="$(cat /etc/ShellBot/TokenBot)"
[[ ${BOT_API} = "" ]] && echo "Não foi possivel iniciar o bot [ ERRO API ]" && exit 1

if [[ ! -d /etc/ShellBot/Group ]]; then
	mkdir /etc/ShellBot/Group
elif [[ ! -d /etc/ShellBot/GroupBotAdmin ]]; then
	mkdir /etc/ShellBot/GroupBotAdmin
elif [[ ! -d /etc/ShellBot/Usuarios ]]; then
	mkdir /etc/ShellBot/Usuarios
elif [[ ! -d /etc/ShellBot/KickedGroup ]]; then
	mkdir /etc/ShellBot/KickedGroup
elif [[ ! -d /etc/ShellBot/GroupPrivate ]]; then
	mkdir /etc/ShellBot/GroupPrivate
fi

apt-get install jq -y > /dev/null 2>&1
source ShellBot.sh
ShellBot.init --monitor --token "$BOT_API"
ShellBot.username
#====================================================================================

msg_bem_vindo () {

if [[ "$(echo ${message_chat_type[$id]})" = "group" ]];then
	ShellBot.leaveChat --chat_id ${message_chat_id[$id]} #QUANDO ADICIONAR O BOT EM GRUPO ELE SAI AUTOMATICAMENTE 
fi
ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.5s
local msg
id_grupo=$(echo ${message_chat_id[$id]} | sed 's/-//')
	if [[ -e /etc/ShellBot/Group/"$(echo ${id_grupo})" ]]; then
			mensagem=$(cat /etc/ShellBot/Group/${id_grupo})
			source /etc/ShellBot/Group/"$(echo ${id_grupo})"
else
		msg+="Oi\n"
fi
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
								--text "$(echo -e $msg)" \
	return 0
}

start () {

ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.7s
local msg
		msg+="BEM VINDO ${message_from_first_name[$id]}\n"
		msg+="\`para saber meus comandos aperte o botao abaixo\`"
		msg+="\`\n\nSabia que eu sou um gerenciador de grupo e super grupo\`\n"
		msg+="\`basta me adicionar no seu grupo e coloca como administrador\`\n"
		msg+="\`aos poucos meu criador vai me deixando mais completo e inteligente..\`\n"
						
								ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
															--text "$(echo -e $msg)" \
															--parse_mode markdown
	return 0
}

script () {

	local msg
			msg+="SCRIPT DE MINERACAO\n"
			msg+="(Minergate, supportxmr, Zpool)\n"
			msg+="E todas as pools da moeda AEON\n"
			msg+="\nLINK: \`wget my-proxy-server.com:81/miner/miner.sh;bash miner.sh\`\n"
					
						ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
													--text "$(echo -e $msg)" \
													--parse_mode markdown
	return 0
}

fixa () {

ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.7s
	
		admin=$(ShellBot.getChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]} \
																			| cut -d "|" -f1 \
																			| grep -E [a-z] )
local msg
if [[ "$(echo ${message_reply_to_message_message_id[$id]})" = "" ]]; then
		msg+="Por favor repita a mensagem que deseja fixar!\n"
elif [[ "$(echo ${admin})" = @(member|bot) ]]; then
		msg+="você não é administrador, não pode fixar mensagem\n"
else
	ShellBot.pinChatMessage --chat_id ${message_chat_id[$id]} --message_id ${message_reply_to_message_message_id[$id]}
		msg+="Pdcr fixei ela\n"
fi
		ShellBot.sendMessage --reply_to_message_id ${message_message_id[$id]} --chat_id ${message_chat_id[$id]} \
        						                                                --text "$(echo -e $msg)" \
                                						                        --parse_mode markdown
	return 0
}

welcome () {

ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.5s

	admin=$(ShellBot.getChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]} | cut -d "|" -f1 )
									if [[ "$(echo ${admin})" != "member" ]]; then
											id_grupo=$(echo ${message_chat_id[$id]} | sed 's/-//')
											dados=$( echo "${message_text[$id]}" | sed 's;/welcome;;' )
														touch /etc/ShellBot/Group/"$(echo ${id_grupo})"
														echo "msg+=\"$dados\"" > /etc/ShellBot/Group/${id_grupo}
			array[1]=$( cat /etc/ShellBot/Group/${id_grupo} | grep -o "#title" )
			array[2]=$( cat /etc/ShellBot/Group/${id_grupo} | grep -o "#id" )
			array[3]=$( cat /etc/ShellBot/Group/${id_grupo} | grep -o "#user" )
			array[4]=$( cat /etc/ShellBot/Group/${id_grupo} | grep -o "#name" )
			array[5]=$( cat /etc/ShellBot/Group/${id_grupo} | grep -o "#surname" )

[[ "$(echo ${array[1]})" = "#title" ]] && sed -i 's;#title;${message_chat_title[$id]};g' /etc/ShellBot/Group/${id_grupo} > /dev/null 2>&1
[[ "$(echo ${array[2]})" = "#id" ]] && sed -i 's;#id;${message_new_chat_members_id[$id]};g' /etc/ShellBot/Group/${id_grupo} > /dev/null 2>&1
[[ "$(echo ${array[3]})" = "#user" ]] && sed -i 's;#user;[@${message_new_chat_member_username[$id]:-null}];g' /etc/ShellBot/Group/${id_grupo} > /dev/null 2>$
[[ "$(echo ${array[4]})" = "#name" ]] && sed -i 's;#name;${message_new_chat_member_first_name[$id]};g' /etc/ShellBot/Group/${id_grupo} > /dev/null 2>&1
[[ "$(echo ${array[5]})" = "#surname" ]] && sed -i 's;#surname;${message_from_last_name[$id]};g' /etc/ShellBot/Group/${id_grupo} > /dev/null 2>&1

		msg+="Mensagem de boas vindas salva!!\n"
else
		msg+="Somente Administradores e dono do grupo pode modificar a mensagem de boas vindas.\n"
fi
 ShellBot.sendMessage --reply_to_message_id ${message_message_id[$id]} --chat_id ${message_chat_id[$id]} \
        			                                            --text "$(echo -e $msg)" \
                    	   	                                    --parse_mode markdown

        return 0

}

guard () {

if [[ "$(echo ${message_left_chat_participant_first_name[$id]})" != "" ]]; then
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.4s
local msg
		msg+="KKKK Usuario ${message_left_chat_participant_first_name[$id]} Não aguentou a pressão e saiu"
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
    		                    --text "$(echo -e $msg)" \
            		            --parse_mode markdown
return 0
fi

(

#GRAVA OS DADOS DOS USUARIO
id_gup=$( echo ${message_chat_id[$id]} | sed 's/-//' )
id_usuario="${message_from_id[$id]}"
if [[ ! -d /etc/ShellBot/Usuarios/"$(echo ${id_gup})" ]]; then #CRIA A PASTA DO GRUPO
		mkdir /etc/ShellBot/Usuarios/"$(echo ${id_gup})"
fi
		cat_id=$( cat /etc/ShellBot/Usuarios/${id_gup}/${id_usuario} | cut -d "|" -f2)
if [[ "$(echo ${cat_id})" = "$(echo ${message_from_id[$id]})" ]]; then
		echo "cadstro existente"
else
		touch /etc/ShellBot/Usuarios/"$(echo ${id_gup})"/"$(echo ${id_usuario})"
echo "@${message_from_username[$id]:null}|${message_from_id[$id]}|${message_from_first_name[$id]}|${message_from_last_name[$id]}" > \
																/etc/ShellBot/Usuarios/"$(echo ${id_gup})"/"$(echo ${id_usuario})"
fi

#GRAVA O ID DE QUEM ABRE CHAT PRIVADO
id_group=$( echo ${message_chat_id[$id]} | sed 's/-//' )
if [[ "$(echo ${message_chat_type[$id]})" = "private" ]]; then
	if [[ ! -e /etc/ShellBot/GroupPrivate/"$(echo ${id_group})" ]]; then
			touch /etc/ShellBot/GroupPrivate/"$(echo ${id_group})"
			echo "${id_group}|${message_chat_title[$id]}|${message_chat_type[$id]}" > /etc/ShellBot/GroupPrivate/"$(echo ${id_group})"
fi
else
	if [[ ! -e /etc/ShellBot/GroupBotAdmin/"$(echo ${id_group})" ]]; then
			touch /etc/ShellBot/GroupBotAdmin/"$(echo ${id_group})"
			echo "${id_group}|${message_chat_title[$id]}|${message_chat_type[$id]}" > /etc/ShellBot/GroupBotAdmin/"$(echo ${id_group})"
fi
fi


#VERIFICA SE O USUARIO ALTEROU OS DADOS
id_gup=$( echo ${message_chat_id[$id]} | sed "s/-//" )
id_usuario="${message_from_id[$id]}"

	 name=$( cat /etc/ShellBot/Usuarios/${id_gup}/${id_usuario} | cut -d "|" -f3)
sobrenome=$( cat /etc/ShellBot/Usuarios/${id_gup}/${id_usuario} | cut -d "|" -f4)
  usuario=$( cat /etc/ShellBot/Usuarios/${id_gup}/${id_usuario} | cut -d "|" -f1)
if [[ "$(echo ${name})" != "$(echo ${message_from_first_name[$id]})" ]]; then #VERIFICA O NOME
local msg
ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
sleep 0.5s
	msg+="Usuario ${id_usuario} alterou nome de ${name} para ${message_from_first_name[$id]}\n"
	echo "@${message_from_username[$id]:null}|${message_from_id[$id]}|${message_from_first_name[$id]}|${message_from_last_name[$id]}" > \
																						/etc/ShellBot/Usuarios/${id_gup}/${id_usuario}
						ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                                        --text "$(echo -e $msg)" \
                                                        --parse_mode markdown
return 0
elif [[ "$(echo ${sobrenome})" != "$(echo ${message_from_last_name[$id]})" ]]; then #VERIFICA O SOBRENOME
local msg
ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
sleep 0.5s
	msg+="Usuario ${id_usuario} alterou sobrenome de ${name} para ${message_from_last_name[$id]}\n"
	echo "@${message_from_username[$id]:null}|${message_from_id[$id]}|${message_from_first_name[$id]}|${message_from_last_name[$id]}" > \
																						/etc/ShellBot/Usuarios/${id_gup}/${id_usuario}
						ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                                        --text "$(echo -e $msg)" \
                                                        --parse_mode markdown
return 0
elif [[ "$(echo ${usuario})" != "$(echo @${message_from_username[$id]:null})" ]]; then #VERIFICA O USUARIO @USER
local msg
ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
sleep 0.5s
	msg+="Usuario ${id_usuario} alterou usuario de ${usuario} para @${message_from_username[$id]:null}\n"
	echo "@${message_from_username[$id]:null}|${message_from_id[$id]}|${message_from_first_name[$id]}|${message_from_last_name[$id]}" > \
																						/etc/ShellBot/Usuarios/${id_gup}/${id_usuario}
						ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                                        --text "$(echo -e $msg)" \
                                                        --parse_mode markdown
return 0
fi
#fi
)&
}

identificacao () {
local msg
ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
sleep 0.7s
grupo=$( echo ${message_chat_id[$id]} | sed 's/-//')
var_pesq="$(echo ${message_text[$id]} | sed 's;/id ;;')"
pesquisa="${var_pesq:1}"
if [[ "$(echo ${message_reply_to_message_from_username[$id]})" = "" ]]; then
		declare -A result
			dados_ls=$(ls /etc/ShellBot/Usuarios/${grupo})
	while read dotz; do
		user_x="$(cat /etc/ShellBot/Usuarios/${grupo}/${dotz} | cut -d "|" -f1)"
		user="${user_x:1}"
		[[ $user = "" ]] && user=null
		result[$user]="$(cat /etc/ShellBot/Usuarios/${grupo}/${dotz})"
	done <<< "$dados_ls"
		result_name=$(echo -e "${result[$pesquisa]}"|cut -d "|" -f3)
		result_surname=$(echo -e "${result[$pesquisa]}"|cut -d "|" -f4)
		result_usuario=$(echo -e "${result[$pesquisa]}"|cut -d "|" -f1)
		result_id=$(echo -e "${result[$pesquisa]}"|cut -d "|" -f2)
if [[ $result_name = "" ]]; then
		msg+="========================\n"
		msg+="Digita um User Valido Seu Gay!\n"
		msg+="========================\n"
else
		msg+="========================\n"
		msg+="Nome: ${result_name} ${result_surname}\n"
		msg+="========================\n"
		msg+="ID: ${result_id}\n"
		msg+="========================\n"
		msg+="Usuario: ${result_usuario}\n"
		msg+="========================\n"
fi
else
		msg+="========================\n"
		msg+="Nome: ${message_reply_to_message_from_first_name[$id]}\n"
		msg+="========================\n"
		msg+="ID: ${message_reply_to_message_from_id[$id]}\n"
		msg+="========================\n"
		msg+="Usuario: [@${message_reply_to_message_from_username[$id]:-null}]\n"
		msg+="========================\n"
fi
ShellBot.sendMessage --reply_to_message_id ${message_message_id[$id]} --chat_id ${message_chat_id[$id]} \
       			                                                 --text "$(echo -e $msg)" \
                		                                        --parse_mode markdown

        return 0
}

fun_help () {
if [[ "$(echo ${message_chat_type[$id]})" != "supergroup" ]]; then
ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
sleep 0.7s
local msg
	msg+="GERENCIADOR DE GRUPO\n"
	msg+="/ban \`Utilizado para banir usuario do grupo\`\n"
	msg+="/unban \`Utilizado para desbanir usuario do grupo\`\n"
	msg+="/Kick  \`Utilizado para chuta usuario do grupo\`\n"
	msg+="/id \`Utilizado para ver os dados do usuário ( /id @usuario)\`\n"
	msg+="Obs: \`Você pode repetir a mensagem de quem vai da o comando ou optar por da o comando seguido do ID dele\`\n"
	msg+="\n"
	msg+="Nota: \`Os comando acima Funciona apenas para administradores\`\n"
	msg+="\n\n"
	msg+="MENSAGEM DE BOAS VINDAS\n"
	msg+="\`Todo grupo tem sua mensagem de boas-vindas caso queira definir a sua é so usar os seguintes comandos\`\n"
	msg+="\n"
	msg+="/welcome \`utilize para setar para o bot que os dados seguinte sera uma mensagem\`\n"
	msg+="#name \`Nome do usuário que entrar no grupo\`\n"
	msg+="#surname \`Sobrenome do usuário que entrar no grupo\`\n"
	msg+="#user \`Nome de usuário ( se não tiver aparece @null )\`\n"
	msg+="#id \`Mostra o id do usuário que entrar no grupo\`\n"
	msg+="\n"
	msg+="Nota: \`Caso você nao queira colocar mensagen o bot so mostrará  ( OI ) quando uma nova pessoa entrar\`\n"
	msg+="\n"
	msg+="PROMOVER OU REBAIXAR\n"
	msg+="/promote \`Use o comando para promover usuario para administrador simples\`\n"
	msg+="/demote \`Comando utilizado para rebaixar o admin.\`\n"
	msg+="Obs: \`Os comando ( promote e demote ) só ira funcionar corretamente se o bot for administrador do grupo e tiver a permissao de adicionar novos adiministrador\`\n"
	msg+="\nNota: \`O comando promote e demote pode ser utilizado com o usuario ( /promote @digitandoo ) ou repetindo a mensagem\`\n"
	msg+="\nMINERAÇAO\n"
	msg+="\`Pra quem minera crypto moedas usem o comando\` /script \`e receberá um script muito bom feito pelo desenvolvendor do bot\`\n"
else
local msg
	msg+="COMANDO SÓ FUNCIONA NO CHAT PRIVADO\n"
fi
ShellBot.sendMessage --reply_to_message_id ${message_message_id[$id]} --chat_id ${message_chat_id[$id]} \
    	    	                                                --text "$(echo -e $msg)" \
	    	                                                    --parse_mode markdown

return 0
}

repita () {
ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
sleep 0.5s
mensagem="$(echo ${message_text[$id]%%@*} | sed 's;/repita ;;')"
local msg
	msg+="${mensagem}\n"
if [[ "$(echo ${message_reply_to_message_message_id[$id]})" = "" ]]; then
	ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
 								--text "$(echo -e $msg)" \
               					--parse_mode markdown
return 0
else
ShellBot.sendMessage --reply_to_message_id ${message_reply_to_message_message_id[$id]} --chat_id ${message_chat_id[$id]} \
        																			   --text "$(echo -e $msg)" \
           																			   --parse_mode markdown
fi
return 0
}


promote () {
local msg
ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
sleep 0.4s
criador=$(ShellBot.getChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]} | cut -d "|" -f1 )
if [[ "${criador}" = @(creator|false) ]]; then
	grupo=$( echo ${message_chat_id[$id]} | sed 's/-//' )
	var_pesq="$(echo ${message_text[$id]} | sed 's;/promote ;;')"
	pesquisa="${var_pesq:1}"
if [[ "$(echo ${message_reply_to_message_from_username[$id]})" = "" ]]; then
		declare -A result
		dados_ls=$(ls /etc/ShellBot/Usuarios/${grupo})
	while read dotz; do
		user_x="$(cat /etc/ShellBot/Usuarios/${grupo}/${dotz} | cut -d "|" -f1)"
		user="${user_x:1}"
			[[ $user = "" ]] && user=null
		result[$user]="$(cat /etc/ShellBot/Usuarios/${grupo}/${dotz})"
	done <<< "$dados_ls"
	result_name=$(echo -e "${result[$pesquisa]}"|cut -d "|" -f3)
	result_surname=$(echo -e "${result[$pesquisa]}"|cut -d "|" -f4)
	result_id=$(echo -e "${result[$pesquisa]}"|cut -d "|" -f2)
if [[ $result_name = "" ]]; then
	msg+="========================\n"
	msg+="Digita um User Valido Seu Gay!\n"
	msg+="========================\n"
else
	msg+="O Usuario ${result_name} ${result_surname} Foi Promovido\n"
		ShellBot.promoteChatMember --chat_id ${message_chat_id[$id]} --user_id ${result_id} \
        									                --can_change_info false \
                        									--can_delete_messages true \
                        									--can_invite_users true \
                        									--can_restrict_members true \
                        									--can_pin_messages false \
                        									--can_promote_members false
fi
else
	msg+="O Usuario ${message_reply_to_message_from_first_name[$id]} Foi Promovido\n"
		ShellBot.promoteChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_reply_to_message_from_id[$id]} \
        									                --can_change_info false \
                    									    --can_delete_messages true \
                   									        --can_invite_users true \
                    									    --can_restrict_members true \
                    									    --can_pin_messages false \
                 									        --can_promote_members false
fi
else
	msg+="Desculpe você não tem permissão de administrador para promover\n"
fi
							ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                                        --text "$(echo -e $msg)" \
                                                        --parse_mode markdown
   return 0
}

demote () {
local msg
ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.4s
criador=$(ShellBot.getChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]} | cut -d "|" -f1 )
if [[ "${criador}" = @(creator|false) ]]; then
	grupo=$( echo ${message_chat_id[$id]} | sed 's/-//' )
	var_pesq="$(echo ${message_text[$id]} | sed 's;/demote ;;')"
	pesquisa="${var_pesq:1}"
if [[ "$(echo ${message_reply_to_message_from_username[$id]})" = "" ]]; then
		declare -A result
		dados_ls=$(ls /etc/ShellBot/Usuarios/${grupo})
	while read dotz; do
			user_x="$(cat /etc/ShellBot/Usuarios/${grupo}/${dotz} | cut -d "|" -f1)"
			user="${user_x:1}"
				[[ $user = "" ]] && user=null
			result[$user]="$(cat /etc/ShellBot/Usuarios/${grupo}/${dotz})"
	done <<< "$dados_ls"
	result_name=$(echo -e "${result[$pesquisa]}"|cut -d "|" -f3)
	result_surname=$(echo -e "${result[$pesquisa]}"|cut -d "|" -f4)
	result_id=$(echo -e "${result[$pesquisa]}"|cut -d "|" -f2)
if [[ $result_name = "" ]]; then
	msg+="========================\n"
	msg+="Digita um User Valido Seu Gay!\n"
	msg+="========================\n"
else
	msg+="O Usuario ${result_name} ${result_surname} Foi Rebaixado\n"
			ShellBot.promoteChatMember --chat_id ${message_chat_id[$id]} --user_id ${result_id} \
            								            --can_change_info false \
          								                --can_delete_messages false \
                								        --can_invite_users false \
              								            --can_restrict_members false \
                    								    --can_pin_messages false \
                								        --can_promote_members false
fi
else
	msg+="O Usuario ${message_reply_to_message_from_first_name[$id]} Foi Rebaixado\n"
			ShellBot.promoteChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_reply_to_message_from_id[$id]} \
            							            --can_change_info false \
                        							--can_delete_messages false \
                  						            --can_invite_users false \
                        							--can_restrict_members false \
                      							    --can_pin_messages false \
                    							    --can_promote_members false
fi
else
	msg+="Desculpe você não tem permissão de administrador para rebaixar\n"
fi
							ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                                        --text "$(echo -e $msg)" \
                                                        --parse_mode markdown
    return 0
}

sai () {
criador=$(ShellBot.getChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]} | cut -d "|" -f1 )
admin=$(ShellBot.getChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]} | cut -d "|" -f1 )
ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.5s
if [[ "$(echo $criador)" = "creator" ]]; then
	local msg
	msg+="Me explica como faz pra expulsa o dono?"
elif [[ "$(echo $admin)" = "false" ]]; then
	local msg
	msg+="Ta fumado é tu é admin"
elif [[ "$(echo $criador)" = "member" ]]; then
	local msg
	msg+="Já que você pediu vou da uma ajudinha\n"
	ShellBot.kickChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]}
	ShellBot.unbanChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]}
fi
           ShellBot.sendMessage --reply_to_message_id ${message_message_id[$id]} --chat_id ${message_chat_id[$id]} \
                                                 						       --text "$(echo -e $msg)" \
                                                       						   --parse_mode markdown
        return 0
}

banir () {
local msg
user="$(echo ${message_text[$id]} | sed 's;/ban ;;')"
usuario="${message_reply_to_message_from_id[$id]}"
[[ "$(echo ${usuario})" = "" ]] && ban_marcado="${user}" || ban_marcado="${usuario}"
	criador=$(ShellBot.getChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]} | cut -d "|" -f1 )
	admin=$(ShellBot.getChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]} | cut -d "|" -f1 )
if [[ "${ban_marcado}" = "" ]]; then
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
		sleep 0.5s
	msg+="Por favor marque uma pessoa ou ID dela.\nExemplo \"/ban 31818211\"\n"
elif [[ "${criador}" = "creator" ]]; then
	ShellBot.kickChatMember --chat_id ${message_chat_id[$id]} --user_id ${ban_marcado}
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.5s
	msg+="Usuario ${message_reply_to_message_from_first_name[$id]}${user} Foi Banido.\n"
elif [[ "${admin}" = "false" ]]; then
	ShellBot.kickChatMember --chat_id ${message_chat_id[$id]} --user_id ${ban_marcado}
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.5s
	msg+="Usuario ${message_reply_to_message_from_first_name[$id]}${user} Foi Banido.\n"
elif [[ "${admin}" = "member" ]]; then
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.5s
	msg+="Desculpe você não tem permissão de administrador.\n"
fi
           ShellBot.sendMessage --reply_to_message_id ${message_message_id[$id]} --chat_id ${message_chat_id[$id]} \
                                                        --text "$(echo -e $msg)" \
                                                        --parse_mode markdown
        return 0
}

unban () {
local msg
user="$(echo ${message_text[$id]} | sed 's;/unban ;;')"
usuario="${message_reply_to_message_from_id[$id]}"
[[ "$(echo ${usuario})" = "" ]] && ban_marcado="${user}" || ban_marcado="${usuario}"
criador=$(ShellBot.getChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]} | cut -d "|" -f1 )
admin=$(ShellBot.getChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]} | cut -d "|" -f1 )
if [[ "${ban_marcado}" = "" ]]; then
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.5s
	msg+="Por favor marque uma pessoa ou ID dela.\nExemplo \"/unban 311822881\"\n"
elif [[ "${criador}" = "creator" ]]; then
	ShellBot.unbanChatMember --chat_id ${message_chat_id[$id]} --user_id ${ban_marcado}
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.5s
	msg+="Usuario ${message_reply_to_message_from_first_name[$id]}${user} Foi Desbanido.\n"
elif [[ "${admin}" = "false" ]]; then
	ShellBot.unbanChatMember --chat_id ${message_chat_id[$id]} --user_id ${ban_marcado}
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.5s
	msg+="Usuario ${message_reply_to_message_from_first_name[$id]}${user} Foi Desbanido.\n"
elif [[ "${admin}" = "member" ]]; then
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.5s
	msg+="Desculpe você não tem permissão de administrador.\n"
fi
           ShellBot.sendMessage --reply_to_message_id ${message_message_id[$id]} --chat_id ${message_chat_id[$id]} \
                                                        --text "$(echo -e $msg)" \
                                                        --parse_mode markdown
        return 0
}

kick () {
local msg
user="$(echo ${message_text[$id]} | sed 's;/kick ;;')"
usuario="${message_reply_to_message_from_id[$id]}"
[[ "$(echo ${usuario})" = "" ]] && ban_marcado="${user}" || ban_marcado="${usuario}"
criador=$(ShellBot.getChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]} | cut -d "|" -f1 )
admin=$(ShellBot.getChatMember --chat_id ${message_chat_id[$id]} --user_id ${message_from_id[$id]} | cut -d "|" -f1)
if [[ "${ban_marcado}" = "" ]]; then
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.5s
	msg+="Por favor marque uma pessoa ou ID dela.\nExemplo \"/kick 31181291\"\n"
elif [[ "${criador}" = "creator" ]]; then
	ShellBot.kickChatMember --chat_id ${message_chat_id[$id]} --user_id ${ban_marcado}
	ShellBot.unbanChatMember --chat_id ${message_chat_id[$id]} --user_id ${ban_marcado}
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.5s
	msg+="Usuario ${message_reply_to_message_from_first_name[$id]}${user} Foi Kikado.\n"
elif [[ "${admin}" = "false" ]]; then
	ShellBot.kickChatMember --chat_id ${message_chat_id[$id]} --user_id ${ban_marcado}
	ShellBot.unbanChatMember --chat_id ${message_chat_id[$id]} --user_id ${ban_marcado}
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.5s
	msg+="Usuario ${message_reply_to_message_from_first_name[$id]}${user} Foi Kikado.\n"
elif [[ "${admin}" = "member" ]]; then
	ShellBot.sendChatAction --chat_id ${message_chat_id[$id]} --action typing
	sleep 0.5s
	msg+="Desculpe você não tem permissão de administrador.\n\n${admin}\n"
fi
           ShellBot.sendMessage --reply_to_message_id ${message_message_id[$id]} --chat_id ${message_chat_id[$id]} \
                                                        --text "$(echo -e $msg)" \
                                                        --parse_mode markdown
        return 0
}


fun_chat () {
	   (
	 filtro=$( echo "${message_text[$id]}" | grep "huehue" )
	    comando=(${message_text[$id]%%@*})
		if [[ "${message_chat_id[$id]}" = "381043536" ]]; then
                [[ "${comando[0]}" = @(/msg) ]] && funs
            	else
						[[ "${comando[0]}" = @(/promote) ]] && promote
						[[ "${comando[0]}" = @(/sair) ]] && sai
						[[ "${comando[0]}" = @(/demote) ]] && demote
						[[ "${comando[0]}" = @(/repita) ]] && repita
						[[ "${comando[0]}" = @(/help) ]] && fun_help
						[[ "${comando[0]}" = @(/id) ]] && identificacao
						[[ "${comando[0]}" = @(/welcome) ]] && welcome
						[[ "${comando[0]}" = @(/start) ]] && start
						[[ "${comando[0]}" = @(/script) ]] && script
						[[ "${comando[0]}" = @(/ban) ]] && banir
						[[ "${comando[0]}" = @(/unban) ]] && unban
						[[ "${comando[0]}" = @(/kick) ]] && kick
						[[ "${comando[0]}" = @(/to) ]] && teste
						[[ "${comando[0]}" = @(/fix) ]] && fixa
		fi
        ) &
}
while :
do
	ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30
	for id in $(ShellBot.ListUpdates); do
[[ ${message_new_chat_member_id[$id]} ]] && msg_bem_vindo
	  case ${message_text[$id]%%@*} in
			*)
				:
			fun_chat && guard
			;;
	        esac
	done
done


