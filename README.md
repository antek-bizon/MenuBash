# Wymagania
- zainstalowane polecenie **dialog**
- zainstalowane polecenie **gnome-screenshot**
- zainstalowane **gedit**

# Notatki
Do poprawnej działania skryptu wymagane są pliki: Autor.txt, Egzamin.txt, Logo.txt, Menu.bash, Menu.sh.

Do poruszania się po skrypcie używane są **strzałki** i **ENTER**, użyć można także cyfr w menu, a także liter w teście.

Konfiguracja karty sieciowej może nie w pełni zmieścić się w okienku skryptu. Aby zobaczyć całość należy rozszerzyć je.

Plik z odpowiedziami (Egzamin_odp) jest resetowany przy każdym uruchomieniu testu! Jeśli nie potrzebujemy już tego pliku możemy go spokojnie usunąć, gdyż skrypt stworzy go automatycznie przy uruchomieniu testu.

Podczas pracy skryptu mogą zostać stworzone pliki tmp, w których przechowywane są niektóre informacje. Są one jednak każdorazowo usuwane, więc nie powinno być problemu z ich zaleganiem.

Zalecane jest uruchamianie skryptu w aktualnych shellu. Aby to zrobić należy zamiast `./nazwa_skryptu`, użyć source nazwa_skryptu lub `. nazwa_skryptu`.

Na pracę skryptu nie powinny mieć wpływu ustawienia systemu takie jak umask, czy wersja językowa.
