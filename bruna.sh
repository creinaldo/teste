#!/bin/bash
#####[ Ficha: ]############################################################
#
#
# Script: Memory View Recursivo - versão 0.0
#
# Escrito por: Cláudio Reinaldo
#
# Criado em: 16/07/2017
#
# Ultima Atualizacao: 23/09/2018
#
#
#
#####[ Descricao: ]########################################################
#
#
# Script converte cd em ficheiros de mp3 
#
#
#
##[ Versões ]############....
#
# Versão 0.1 : Nasceu
# Versão 1.0 : 
# Versão 0.2.1 : ...
#
#########################....

clear
#_____________________________Variaves -------------------

QUALIDADE='160'

#_____________________________ funções -------------------


function normal {
echo
echo
echo -e  "\033[0;40;36m	Bem vindo ao sript $(basename "$0") 0.1 \033[0m"
echo
echo

echo -en  '	\033[0;40;36m Digite o nome da banda ou artista : \033[0m'
read BANDA
echo

echo -en '	\033[0;40;36m Digite o nome do album : \033[0m'
read ALBUM
ALBUM1=$(echo $ALBUM | sed -r 's/(^.| .)/\U&/g' |sed 's/ //g' | sed 'y/áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚçÇ/aAaAaAaAeEeEiIoOoOoOuUcC/')
mkdir "$ALBUM1"
cd "$ALBUM1"
echo 
echo -en '	\033[0;40;36m Digite o ano cd : \033[0m'
read ANO
echo

echo -en '	\033[0;40;36m Digite quantas faixas tem o cd : \033[0m'
read NUMFAIXAS
echo



for (( i=1; i <= $NUMFAIXAS; i++ )); do
echo -en "\033[0;40;36m	Digite o nome da faixa $i : \033[0m"
read 	FAIXA[$i]
echo
done

echo  "	" >> "$ALBUM1".txt
echo  "	BANDA	| ANO	|  ALBUM	|  	NUMERO	|	FAIXA" >> "$ALBUM1".txt
echo  "	" >> "$ALBUM1".txt
# carrega o cdparanoia...
cdparanoia -vsQ

for (( i=1; i <= $NUMFAIXAS; i++)); do
#clear
echo
echo -e "	\033[0;40;36mExtraindo do CD a faixa de número  \033[0m\033[5;40;31m$i \033[0m"
echo
cdparanoia -B 0$i wav

done

#converter a wav para mp3 
for (( i=1; i <= $NUMFAIXAS; i++)); do
#clear
echo
echo -e "	\033[0;40;36m Convertendo para mp3 a faixa númerio : \033[0m \033[5;40;36m $i \033[0m"
echo

lame -b $QUALIDADE --ta "${BANDA}" --ty "${ANO}" --tl "${ALBUM}" --tn "${i}" --tt "${FAIXA[$i]}" $(ls track0$i.wav) "$(echo ${BANDA} ${ANO} ${ALBUM} 0${i}${FAIXA[$i]} | sed -r 's/(^.| .)/\U&/g' |sed 's/ //g' | sed 'y/áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚçÇ/aAaAaAaAeEeEiIoOoOoOuUcC/' )".mp3 

echo  "	${BANDA} | ${ANO} | ${ALBUM} | ${i} | ${FAIXA[$i]}" >> "$ALBUM1".txt
done

rm track0*.wav
}

function instalacao {
	sudo apt-get install lame cdparanoia
}


function versao {
			echo -e "\033[1;40;36m -------------------------------------------------"
			echo -e "\n\n Hoje é dia : $(date)"
			echo -e " \n \n	Bem vindo ao sript $(basename "$0") 1.0 \n "
			echo -e " Extrai música de cd de audio para mp3"	
			echo -e " Versão 0.1 "
			echo -e " 17 Julho de 2017 \n "
			echo -e	" Versão 1.0 "
			echo -e " 23 Setembro de 2018 \n"
			echo  	""
			echo -e	" Para fazer a instalação : $(basename "$0") -i \n" 
			echo 	"Dependecias a instaladas  lame cdparanoia	"
			echo	" "
			echo	" "
			echo -e " Cláudio Reinaldo \n  "
			echo -e " -------------------------------------------------\033[0m"
		

}


function testapacotes
	{
if [[ "$(lame) $?" -eq "127" ]]; then
	echo -e "\n Falta instalar o lame \n"
	
fi

if [[ "$(cdparanoia) $?" -eq "127" ]]; then 
	echo -e "\n Falta instalar o cdparanoia \n"
	exit 0
fi 

	}



case $1 in
 
	-i | -I )instalacao ;;
	-v | -V ) versao ;;
		*) testapacotes ; normal ;;
esac
