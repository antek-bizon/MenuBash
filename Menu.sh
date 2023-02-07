#!/bin/bash
source ~/.config/user-dirs.dirs
echo $XDG_DESKTOP_DIR

clear

OUTPUT="Menu.bash"

>$OUTPUT;

check_button () {
    button=$1
    if [ $button == 0 ]; then
	      echo "Wybrałeś Ok";
    elif [ $button == 1 ]; then
	      echo "Wybrałeś Anuluj"
	      exit 1
    else
	      echo "Niczego nie wybrałeś";
    fi
}

main_menu () {
    dialog --clear --title "Okno dialogowe Menu" --backtitle "BASH" --menu "Wybierz:" 10 40 3 1 "Użytkownicy i grupy" 2 "System" 3 "Inne" 2> $OUTPUT
    result=$(<$OUTPUT)
    check_button $?

    case $result in
        1) result=UM
           ;;
        2) result=SM
           ;;
        3) result=OM
           ;;
    esac
}

user_menu () {
    dialog --clear --title "User" --backtitle "BASH" --menu "Wybierz:" 11 40 4 1 "Użytkownicy" 2 "Grupy użytkownika" 3 "Zablokuj konto" 4 "Powrót" 2> $OUTPUT
    result=$(<$OUTPUT)
    check_button $?

    case $result in
        1) result=U1
           ;;
        2) result=U2
           ;;
        3) result=U3
           ;;
        4) result=U4
           ;;
    esac
}

system_menu () {
    dialog --clear --title "System" --backtitle "BASH" --menu "Wybierz:" 14 50 7 1 "Środowiska graficzne" 2 "Zmiana daty" 3 "Zmiana czasu" 4 "Wyświetl konfigurację karty sieciowej" 5 "Wyświetl ilość wolnego miejsca" 6 "Zmień umask" 7 "Powrót" 2> $OUTPUT
    result=$(<$OUTPUT)
    check_button $?

    case $result in
        1) result=S1
           ;;
        2) result=S2
           ;;
        3) result=S3
           ;;
        4) result=S4
           ;;
        5) result=S5
           ;;
        6) result=S6
           ;;
        7) result=S7
           ;;
    esac
}

others_menu () {
    dialog --clear --title "System" --backtitle "BASH" --menu "Wybierz:" 14 40 7 1 "Czas pracy systemu" 2 "Utworzenie komunikatu" 3 "Pliki TMP" 4 "Znajdź pliki" 5 "Zrzut ekranu" 6 "Test ee08" 7 "Powrót" 2> $OUTPUT
    result=$(<$OUTPUT)
    check_button $?

    case $result in
        1) result=O1
           ;;
        2) result=O2
           ;;
        3) result=O3
           ;;
        4) result=O4
           ;;
        5) result=O5
           ;;
        6) result=O6
           ;;
        7) result=O7
           ;;
    esac
}

date_menu () {
    dialog --clear --title "Data" --backtitle "BASH" --inputbox "Zmiana daty(rrrr-mm-dd)" 10 40 "" 2> $OUTPUT
    result=$(<$OUTPUT)
    check_button $?
}

time_menu () {
    dialog --clear --title "Czas" --backtitle "BASH" --inputbox "Zmiana czasu(gg:mm)" 10 40 "" 2> $OUTPUT  
    result=$(<$OUTPUT)
    check_button $?
}

umask_menu () {
    dialog --clear --title "UMASK" --backtitle "BASH" --inputbox "Zmiana UMASK-u" 10 40 "" 2> $OUTPUT     
    result=$(<$OUTPUT)
    check_button $?
}

find_menu () {
    dialog --clear --title "Znajdź pliki" --backtitle "BASH" --inputbox "Wielkość pliku powyżej" 10 40 "" 2> $OUTPUT     
    result=$(<$OUTPUT)
    check_button $?
}

block_menu () {
    dialog --clear --title "Zablokuj użytkownika" --backtitle "BASH" --inputbox "Nazwa użytkownika" 10 40 "" 2> $OUTPUT     
    result=$(<$OUTPUT)
    check_button $?   
}

mess_menu () {
        echo "mess"
        echo "Lubie uczyc sie do egzaminu ee08" > /home/$USER/Komunikat.txt
        chmod 444 /home/$USER/Komunikat.txt
        echo "15 15 * * *  $USER export DISPLAY=:0 && /usr/bin/gedit /home/$USER/Komunikat.txt" | sudo tee -a /etc/crontab
}

tmp_menu () {
    dialog --clear --title "Okno dialogowe Menu" --backtitle "BASH" --menu "Wybierz:" 10 40 3 1 "Wyświetl pliki TMP" 2 "Usuń pliki TMP" 3 "Powrót" 2> $OUTPUT
    result=$(<$OUTPUT)
    check_button $?

    case $result in
        1) result=LM
           ;;
        2) result=RM
           ;;
        3) result=OM
           ;;
    esac
}

a=0
b=1
c=1

test_menu () {
    echo "" > Egzamin_odp.txt
    while [ $b -lt 26 ]; do
        dialog --clear --title "Egzamin ee08" --backtitle "BASH" --menu "$(head -n "$b" Egzamin.txt | tail -n 1)" 13 60 4 A "$(head -n "$[b+1]" Egzamin.txt | tail -n 1)" B "$(head -n "$[b+2]" Egzamin.txt | tail -n 1)" C "$(head -n "$[b+3]" Egzamin.txt | tail -n 1)" D "$(head -n "$[b+4]" Egzamin.txt | tail -n 1)" 2> $OUTPUT
        result=$(<$OUTPUT)
        check_button $?

        if [ $result = $(head -n "$[b+5]" Egzamin.txt | tail -n 1) ]; then
            echo "Zadanie $c : Poprawna odpowiedź!" >> Egzamin_odp.txt
            a=$[a+1]
        else
            echo "Zadanie $c : Niepoprawna odpowiedź, poprawna odpowiedź to $(head -n "$[b+5]" Egzamin.txt | tail -n 1)." >> Egzamin_odp.txt
        fi
        b=$[b+6]
        c=$[c+1]
    done
    dialog --clear --title "Egzamin ee08" --backtitle "BASH" --msgbox "Zdobyłeś $a punktów." 10 40
    echo "Zdobyłeś $a punktów." >> Egzamin_odp.txt
    a=0
    b=1
    c=1
    result=OM
}

i=25
logo_animation () {
    while [ $i -lt 389 ]; do
        head -n "$i" Logo.txt | tail -n 25
        sleep 0.06s
        clear
        i=$[i+26]
    done
    
}

start_menu () {
    resize -s 28 90
    F_VDOBLE="\033#6"
    printf "${F_VDOble}Esto es..\n"
    clear
    sleep 0.1s
    logo_animation
    tail -n 25 Logo.txt
    sleep 2s
    clear
    cat Autor.txt
    sleep 2s
    main_menu
}


OUT=$(<$OUTPUT)

start_menu
echo "result: $result"

while true; do
    case $result in
        MM) main_menu
            ;;
        UM) user_menu
            ;;
        SM) system_menu
            ;;
        OM) others_menu
            ;;
	      U1) echo "U1"
	          sed s/:.*// /etc/passwd > Users.tmp
            chmod 444 Users.tmp
	          dialog --clear --title "Okno dialogowe" --backtitle "BASH" --textbox "Users.tmp" 22 40
	          rm -f Users.tmp
	          result=UM
	          ;;
	      U2) echo "U2"
	          groups > Groups.tmp
            chmod 444 Groups.tmp
	          dialog --clear --title "Okno dialogowe" --backtitle "BASH" --textbox "Groups.tmp"  10 80
	          rm -f Groups.tmp
	          result=UM
	          ;;
	      U3) echo "U3"
            block_menu
            sudo usermod --lock "$result"
	          result=UM
	          ;;
        U4) echo "U4"
            result=MM
            ;;
	      S1) echo "S1"
	          ls /usr/share/xsessions >> Graficzne.tmp
            chmod 444 Graficzne.tmp
	          dialog --clear --title "Okno dialogowe" --backtitle "BASH" --textbox "Graficzne.tmp"  15 40
	          rm -f Graficzne.tmp
	          result=SM
	          ;;
	      S2) echo "S2"
	          date_menu
            sudo timedatectl set-ntp off
	          sudo date --set "$result"
            result=SM
	          ;;
	      S3) echo "S3" 
	          time_menu
            sudo timedatectl set-ntp off
	          sudo date --set "$result"
            result=SM
	          ;;
	      S4) echo "S4"
	          ip a > IP.tmp
            chmod 444 IP.tmp
	          dialog --clear --title "Okno dialogowe" --backtitle "BASH" --textbox "IP.tmp"  20 105
	          rm -f IP.tmp
	          result=SM
	          ;;  
	      S5) echo "S5"
	          df -h > Dysk.tmp
            chmod 444 Dysk.tmp
	          dialog --clear --title "Okno dialogowe" --backtitle "BASH" --textbox "Dysk.tmp"  15 60
	          rm -f Dysk.tmp
	          result=SM
	          ;;  
	      S6) echo "S6"
	          umask_menu
       	    umask "$result"
	          result=SM
	          ;;  
	      S7) echo "S7"
	          result=MM
	          ;;
        O1) echo "O1"
            uptime | head -c 19 | tail -c 6 > Uptime.tmp
            chmod 444 Uptime.tmp
            dialog --clear --title "Okno dialogowe" --backtitle "BASH" --textbox "Uptime.tmp" 10 40
            rm -f Uptime.tmp
            result=OM
            ;;
        O2) echo "O2"
            mess_menu
            dialog --clear --title "Okno dialogowe" --backtitle "BASH" --msgbox "Operacja się powiodła" 10 40

            result=OM
            ;;
        O3) echo "O3"
            tmp_menu
            ;;
        LM) echo "LM"
            ls /tmp > TMP.tmp
            chmod 444 TMP.tmp
            dialog --clear --title "Okno dialogowe" --backtitle "BASH" --textbox "TMP.tmp"  15 60
            rm -f TMP.tmp
            result=O3
            ;;
        RM) echo "RM"
            sudo rm -r /tmp/*
            dialog --clear --title "Okno dialogowe" --backtitle "BASH" --msgbox "Operacja się powiodła" 10 40
            result=O3
            ;;
        O4) echo "O4"
            find_menu
            find -size +$result | cat -n > Find.tmp
            chmod 444 Find.tmp
            dialog --clear --title "Okno dialogowe" --backtitle "BASH" --textbox "Find.tmp"  15 60
	          rm -f Find.tmp
            result=OM
            ;;
        O5) echo "O5"
            DATE=$(date +%Y-%m-%d-%H:%M:%S)
            gnome-screenshot -f $XDG_DESKTOP_DIR/Screenshot-$DATE.png
            result=OM
            ;;
        O6) echo "O6"
            test_menu
            ;;
        O7) echo "O7"
            result=MM
            ;;
        *) echo "EXIT"
	         break
	         ;;
    esac
done
