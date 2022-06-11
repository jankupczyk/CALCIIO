#!/bin/bash


#	 			  	 ██████╗ █████╗ ██╗      ██████╗██╗██╗ ██████╗ 
#				 	██╔════╝██╔══██╗██║     ██╔════╝██║██║██╔═══██╗
#				 	██║     ███████║██║     ██║     ██║██║██║   ██║
#				 	██║     ██╔══██║██║     ██║     ██║██║██║   ██║
#				 	╚██████╗██║  ██║███████╗╚██████╗██║██║╚██████╔╝
#				  	 ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝╚═╝ ╚═════╝ 
###########################################LICENSE##########################################
# Permission is hereby granted, free of charge, to any person obtaining a copy			   #
# of this software and associated documentation files (the "Software"), to deal			   #
# in the Software without restriction, including without limitation the rights			   #
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell				   #
# copies of the Software, and to permit persons to whom the Software is					   #
# furnished to do so, subject to the following conditions:								   #
#																						   #
# The above copyright notice and this permission notice shall be included in all		   #
# copies or substantial portions of the Software.										   #
#																						   #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR			   #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,				   #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE			   #
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER				   #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,			   #
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  #
#                                                                                          #
#																						   #
# 					You should have received a copy of the MIT License					   #
###########################################HEADER###########################################
###############################Copyright (c) 2022 JAN KUPCZYK###############################

export TMOUT=0

SCRIPT_STAGE_=true

calciio_author="©Jan Kupczyk"
calciio_version="1.9.0"

log_date=$(date +"%T")

fg_red=`tput setaf 1`
fg_green=`tput setaf 2`
fg_yellow=`tput setaf 3`
fg_blue=`tput setaf 4`
fg_magenta=`tput setaf 5`
fg_cyan=`tput setaf 6`
fg_white=`tput setaf 7`
fg_def_col="\033[00m"

bin_sym='\xe2\x82\x82'
oct_sym='\xe2\x82\x88'
dec_sym='\xe2\x82\x81''\xe2\x82\x80'
hex_sym='\xe2\x82\x81''\xe2\x82\x86'

MENU_BREAK1="${fg_cyan}################# STANDARD #################${fg_white}\n"
MENU_BREAK2="${fg_cyan}################# PROGRAMMERS #################${fg_white}\n"
MENU_BREAK3="${fg_cyan}################### CURRENCY ####################${fg_white}\n"
MENU_BREAK4="${fg_cyan}################### SCIENTIFIC ####################${fg_white}\n"
MENU_BREAK4_2="${fg_cyan}#################### OTHER #####################${fg_white}\n"

	Help(){
		clear
        printf "${fg_white}Enter an option number to start (available from 1 to 10)${fg_white}\n\n"
		printf "${fg_white}Regardless of the result of the selected operation, you have the option to continue the script by pressing ENTER.${fg_white}\n\n"
        printf "${fg_white}A successful operation will be signaled with ${fg_green}green color${fg_white}\n\n"
		printf "${fg_white}The information will be marked with ${fg_magenta}🛈 ${fg_white} and ${fg_magenta}pink color${fg_white}\n\n"
        printf "${fg_white}Comments will be marked with ${fg_yellow}⚠ ${fg_white} and ${fg_yellow}yellow color${fg_white}\n\n"
        printf "${fg_white}Unsupported options and errors will be signaled with ${fg_red}🅧 ${fg_white} and ${fg_red}red color${fg_white}\n\n\n"
	}

	Debug(){
		bash -x ${0}
	}

	Verbose(){
		bash -v ${0}
	}


while getopts ":H :d :v" option; do
   case $option in
      H)
	  	 Help
		 exit 0;;
	  d)
	  	 Debug
		 exit 0;;
	  v)
		 Verbose
		 exit 0;;
     \?)
	 	 echo -e "${fg_red}[${log_date}] 🅧  ERROR:>> Incorrect option selected in: ${0} option-${@} << ${fg_white}"
	 	 echo -e "${fg_magenta}[${log_date}] 🛈  INFO:>> Flags available [H, d, v, S] << ${fg_white}"
         exit 1;;
   esac
done

	clear   #wyczyść dla efektu wizualnego
	echo -e "\n${fg_magenta} [${log_date}] 🛈  INFO:>> Loading... CALCIIO << ${fg_white}"
	IFS=';' read updates security_updates < <(/usr/lib/update-notifier/apt-check 2>&1)
	if [[ $updates && $security_updates == 0 ]]; then
		echo -e "\n${fg_magenta} [${log_date}] 🛈  INFO:>> Installing dependencies... << ${fg_white}" && sudo apt-get install jq && clear && sudo apt install curl && clear && sudo apt install openssl && clear
		echo -e "\n${fg_magenta} [${log_date}] 🛈  INFO:>> Running apt-check... << ${fg_white}"
		echo -e "\n${fg_magenta} [${log_date}] 🛈  INFO:>> Nothing needs updating << ${fg_white}" && sleep 2s
	else
		echo -e "\n${fg_magenta} [${log_date}] 🛈  INFO:>> Installing dependencies... << ${fg_white}" && sudo apt-get install jq && clear && sudo apt install curl && clear && sudo apt install openssl && clear
		echo -e "\n${fg_magenta} [${log_date}] 🛈  INFO:>> Running apt-check... << ${fg_white}"
		echo -e "\n${fg_magenta} [${log_date}] 🛈  INFO:>> New updates are available: ${updates} << ${fg_white}" && sleep 2s
		echo -e "\n${fg_magenta} [${log_date}] 🛈  INFO:>> New security updates are available: ${security_updates} << ${fg_white}\n" && sleep 1s

		echo -e "${fg_magenta} [${log_date}] 🛈  INFO:>> Updating is recommended! << ${fg_white}\n" && sleep 1s
		read -p "${fg_magenta} Install Updates Now? [Y/n] ${fg_white} " update_inpt

		if [[ $update_inpt == "Y" ]]; then
			sudo apt-get update && sudo apt-get upgrade && sleep 2s && clear
		elif [[ $update_inpt == "n" ]]; then
			echo -e "\n${fg_magenta} [${log_date}] 🛈  INFO:>> Abort << ${fg_white}" && sleep 1s && clear
		else
			echo -e "\n${fg_magenta} [${log_date}] 🛈  INFO:>> Abort << ${fg_white}" && sleep 1s && clear
		fi
	fi

if [[ ${SCRIPT_STAGE_} == true ]]; then
	echo -e "\n${fg_magenta} [${log_date}] 🛈  INFO:>> Started ${0} << ${fg_white}" && sleep 1s && clear
else
	echo -e "\n${fg_red} [${log_date}] 🅧  ERROR:>> Program ${0} encountered an error! << ${fg_white}"
	exit 1
fi

while ${SCRIPT_STAGE_}; do
clear

    printf "${fg_cyan}

 ██████╗ █████╗ ██╗      ██████╗██╗██╗ ██████╗ 
██╔════╝██╔══██╗██║     ██╔════╝██║██║██╔═══██╗
██║     ███████║██║     ██║     ██║██║██║   ██║
██║     ██╔══██║██║     ██║     ██║██║██║   ██║
╚██████╗██║  ██║███████╗╚██████╗██║██║╚██████╔╝
 ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝╚═╝ ╚═════╝VER ${calciio_version}
${fg_cyan}~~Made with ${fg_magenta}❤${fg_cyan}  by ${calciio_author}
 ${fg_white}
"
	echo -e "${MENU_BREAK1}${fg_cyan}[${fg_yellow}1${fg_cyan}] ${fg_yellow}Addition\n${fg_cyan}[${fg_yellow}2${fg_cyan}] ${fg_yellow}Subtraction\n${fg_cyan}[${fg_yellow}3${fg_cyan}] ${fg_yellow}Multiplication\n${fg_cyan}[${fg_yellow}4${fg_cyan}] ${fg_yellow}Division\n${MENU_BREAK2}${fg_cyan}[${fg_yellow}5${fg_cyan}] ${fg_yellow}Converter of number systems\n${fg_cyan}[${fg_yellow}6${fg_cyan}] ${fg_yellow}Unit converter\n${MENU_BREAK3}${fg_cyan}[${fg_yellow}7${fg_cyan}] ${fg_yellow}Gold prices\n${fg_cyan}[${fg_yellow}8${fg_cyan}] ${fg_yellow}Currency Exchange\n${MENU_BREAK4}${fg_cyan}[${fg_yellow}9${fg_cyan}] ${fg_yellow}Prime\n${fg_cyan}[${fg_yellow}10${fg_cyan}] ${fg_yellow}Strong\n${MENU_BREAK4_2}${fg_cyan}[${fg_yellow}w${fg_cyan}] ${fg_yellow}Exit${fg_def_col}\n"
	read -p "Choose option: " choice
	echo -e ""

	function calciio_get_basic_addition(){
		clear
		printf "${fg_cyan}------------------------Addition------------------------\n${fg_white}"
		echo -e "[${fg_yellow}Enter numbers, separate numbers with a space!${fg_white}]"
		read -p "Enter numbers: " numbers

			result=0
			for number in $numbers; do
				result=$(($result+$number))
			done
			echo -e "\n${fg_green}The result of the addition is: ${fg_green}${result}${fg_def_col}"
	}

	function calciio_get_basic_subtraction(){
		clear
		printf "${fg_cyan}------------------------SUBTRACTION------------------------\n${fg_white}"
		read -p "Enter number 1: " number1
		read -p "Enter number 2: " number2
		result=$(($number1-$number2))
		echo -e "\n${fg_yellow}The result of the subtraction is: ${fg_green}${result}${fg_def_col}"
	}

	function calciio_get_basic_multiplication(){
		clear
				printf "${fg_cyan}------------------------MULTIPLICATION------------------------\n${fg_white}"
		        echo -e "[${fg_yellow}Enter numbers, separate numbers with a space!${fg_white}]"
                read -p "Enter numbers: " numbers

                result=1
                for number in $numbers; do
                        result=$(($result*$number))
                done
                echo -e "\n${fg_green}The result of the multiplication is: ${fg_green}${result}${fg_def_col}"
	}

	function calciio_get_basic_division(){
		clear
		printf "${fg_cyan}------------------------DIVISION------------------------\n${fg_white}"
		read -p "Number 1: " number1
		read -p "Number 2: " number2

		result=$(($number1/$number2))
		echo -e "\n${fg_green}The result of the division is: ${fg_green}${result}${fg_def_col}"
	}

	function calciio_get_developer_convertion(){
        clear
		printf "${fg_cyan}------------CONVERTER OF NUMBER SYSTEMS------------\n${fg_white}"

		read -p "Enter number: " inpt_cc_number
		read -p "Enter the system of the entered number(enter: 2, 8, 10, 16): " inpt_sys1
		read -p "Enter the system to be converted(enter: 2, 8, 10, 16): " inpt_sys2

		final_convertion=$(bc <<< obase=${inpt_sys2}";"ibase=${inpt_sys1}";"${inpt_cc_number})

		if [[ $inpt_sys2 == "2" ]];then
			printf ${fg_green}"Converted number is: "${final_convertion}${bin_sym}${fg_white}
			printf "\n\n"
		elif [[ $inpt_sys2 == "8" ]];then
			printf ${fg_green}"Converted number is: "${final_convertion}${oct_sym}${fg_white}
			printf "\n\n"
		elif [[ $inpt_sys2 == "10" ]];then
			printf ${fg_green}"Converted number is: "${final_convertion}${dec_sym}${fg_white}
			printf "\n\n"
		elif [[ $inpt_sys2 == "16" ]];then
			printf ${fg_green}"Converted number is: "${final_convertion}${hex_sym}${fg_white}
			printf "\n\n"
		fi
	}

	function calciio_get_developer_unit(){
        clear
		printf "${fg_cyan}------------------------UNIT CONVERTER------------------------\n${fg_white}"

		echo -e "${fg_cyan}[${fg_yellow}1${fg_cyan}]${fg_yellow} Exchange MB${fg_white}"
		echo -e "${fg_cyan}[${fg_yellow}2${fg_cyan}]${fg_yellow} Exchange GB${fg_white}"
		read -p "Choose option: " conver_option
		echo -e "\n"

		if [[ $conver_option == "1" ]];then
			read -p "Enter amount(MB): " MB_number
			B_MB=$(($MB_number*1024*1024))
			kB_MB=$(($MB_number*1024))
			MB_MB=$(($MB_number))
			GB_MB=$(($MB_number/1024))
			TB_MB=$(($MB_number/1000000))

			echo -e "\n${fg_green}${MB_number}MB:${fg_green}${fg_def_col}"
			echo -e "\n${fg_green}${B_MB}B${fg_green}${fg_def_col}"
			echo -e "\n${fg_green}${kB_MB}kB${fg_green}${fg_def_col}"
			echo -e "\n${fg_green}${MB_MB}MB${fg_green}${fg_def_col}"
			echo -e "\n${fg_green}${GB_MB}GB${fg_green}${fg_def_col}"
			echo -e "\n${fg_green}${TB_MB}TB${fg_green}${fg_def_col}"

			echo -e "${fg_magenta}[${log_date}] 🛈  INFO:>> Since bash does not support rounding, it is possible that if you enter a small value, your program will output zero! << ${fg_white}"

		elif [[ $conver_option == "2" ]];then
			read -p "Enter amount(GB): " GB_number
			B_GB=$(($GB_number*1000000000))
			kB_GB=$(($GB_number*1048576))
			MB_GB=$(($GB_number*1024))
			GB_GB=$(($GB_number))
			TB_GB=$(($GB_number/1000))

			echo -e "\n${fg_green}${GB_number}GB:${fg_green}${fg_def_col}"
			echo -e "\n${fg_green}${B_GB}B${fg_green}${fg_def_col}"
			echo -e "\n${fg_green}${kB_GB}kB${fg_green}${fg_def_col}"
			echo -e "\n${fg_green}${MB_GB}MB${fg_green}${fg_def_col}"
			echo -e "\n${fg_green}${GB_GB}GB${fg_green}${fg_def_col}"
			echo -e "\n${fg_green}${TB_GB}TB${fg_green}${fg_def_col}"

			echo -e "${fg_magenta}[${log_date}] 🛈  INFO:>> Since bash does not support rounding, it is possible that if you enter a small value, your program will output zero! << ${fg_white}"
		fi

	}

	function calciio_get_exchange_gold(){
        clear
		printf "${fg_cyan}------------------------GOLD PRICES------------------------\n${fg_white}"
		read -p "Enter the date of purchase of gold (yyyy-mm-dd) (today)]: " gold_date
		read -p "Enter the amount of gold (.g): " gold_amount

		gold_price=$(curl -s "http://api.nbp.pl/api/cenyzlota/${gold_date}/?format=json" | jq -r '.[].cena'*${gold_amount})

		echo -e "\n${fg_green}$gold_amount a gram of gold will cost you $gold_price zł(polish zloty)${fg_white}"

		echo -e "${fg_magenta}[${log_date}] 🛈  INFO:>> It may happen that for some dates the API (NBP.pl) does not have data, then try entering another date! << ${fg_white}\n"
	}

	function calciio_get_exchange_foreign(){
	    clear
		printf "${fg_cyan}------------------------CURRENCY EXCHANGE------------------------\n${fg_white}"
		read -p "Enter the currency - from (ISO 4217): " currency_from
		read -p "Enter the currency - to (ISO 4217): " currency_to
		read -p "Enter the amount to exchanged: " currency_amount

		exchange_=$(curl -s "https://currency-api.appspot.com/api/${currency_from}/${currency_to}.json?amount=${currency_amount}" | jq -r .amount)

		echo -e "\n${fg_green}${currency_amount}${currency_from} = ${exchange_}${currency_to}${fg_white}\n"
	}

	function calciio_get_scientific_prime(){
		clear
		printf "${fg_cyan}------------------------PRIME------------------------\n${fg_white}"
		read -p "Enter number: " number

		none_Factors=0
		for i in $( seq 1 $number ); do
			if [[ $(($number%$i)) == 0 ]]; then
				none_Factors=$(($none_Factors+1))
			fi
		done
		if [[ $none_Factors > 2 ]]; then
			echo -e "\n${fg_green}Number ${number}, is a composite number${fg_white}${fg_def_col}"
		else
			echo -e "\n${fg_green}number ${number}, is a prime number${fg_white}${fg_def_col}"
		fi
	}

	function calciio_get_scientific_factorial(){
		clear
		printf "${fg_cyan}------------------------STRONG------------------------\n${fg_white}"
		read -p "Calculate strongly from a number: " factorial_counter

		if ! [[ "$factorial_counter" =~ ^[0-9]+$ ]]; then
			printf "${fg_red} [${log_date}] 🅧  ERROR:>> Provide valid number! << ${fg_white}\n"
		else
			x=1
			while [ $factorial_counter -gt 0 ]
			do
			x=$(( $x * $factorial_counter ))
			factorial_counter=$(( $factorial_counter - 1 ))
			done
				echo -e "\n${fg_green}Strong ${x}${fg_white}${fg_def_col}"
		fi
	}

	function calciio_shutdown(){
        printf "\n${fg_magenta}❤${fg_white}  Thanks for using CALCIIO !! ${fg_magenta}❤ ${fg_white} ${fg_white}\n" && exit 0
	}

case "$choice" in
  "1") calciio_get_basic_addition ;;
  "2") calciio_get_basic_subtraction ;;
  "3") calciio_get_basic_multiplication ;;
  "4") calciio_get_basic_division ;;
  "5") calciio_get_developer_convertion ;;
  "6") calciio_get_developer_unit ;;
  "7") calciio_get_exchange_gold ;;
  "8") calciio_get_exchange_foreign ;;
  "9") calciio_get_scientific_prime ;;
  "10") calciio_get_scientific_factorial ;;
  "w") calciio_shutdown ;;
  *) echo -e "${fg_red}[${log_date}] 🅧  ERROR:>> Invalid option *${choice}* << ${fg_white}"
esac

	read -p "Press enter to continue ..."
done
printf "\n${fg_white}"

trap '' EXIT