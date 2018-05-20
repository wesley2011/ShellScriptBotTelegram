# Bot Para Telegram em SHELL SCRIPT
Bot para telegram usando a linguagem ShellScript

Criador do bot: wesley 
Telegram: t.me/digitandoo

Desenvolvedor da API Juliano Santos (SHAMAN)
link da api: https://github.com/shellscriptx/shellbot
-----------------------------------------------------------------------

COMO USAR O BOT 

crie seu bot no t.me/BotFather
copie sua API e execute o comando abaixo com a sua API
    
     echo "API DO BOT AQUI" > /etc/ShellBot/TokenBot
apenas uma vez

recomendo clonar o repositorio no diretio /etc do servidor pois o script inteiro foi feito ai
erros e duvidas me contate para adcionar novos comando leia a wiki no git do desenvolvedor 

depois de coloca sua api é so iniciar seu bot 

link para clona os arquivos

    apt-get install git -y && git clone https://github.com/wesley2011/ShellScriptBotTelegram.git ShellScript

deixa ele rodando em screen

           apt-get install screen
           cd /etc/ShellBot/
           chmod +x bot.sh
           screen -dmS Bot bot.sh
com esse comando ele ja iniciará em segundo plano depois disso e so chama seu bot no privado e da o /help para ver os comandos disponivel

 
