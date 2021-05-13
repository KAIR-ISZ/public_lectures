# Edycja zmian w repozytorium Git

Jest to ostatni temat z środowiska Git, na tym laboratorium dowiecie się jak:
1. Przeglądać historię zmian, formatować i wyszukiwać informację w logach.
2. Porównywać rewizję i pliki.
3. Cofanie zmian zatwierdzonych i niezatwierdzonych 

## Przeglądanie historii 

Do przeglądania historii zatwierdzonych zmian służy polecenie `log`. Po jego wykonaniu zostanie nam zaprezentowana historia zmian naszego repozytorium. Przykładowy log:  

```
git log

commit 969818327d87bfdd866560e957d0e8a016d9157e (HEAD -> master, origin/npg_test, origin/master, origin/HEAD)
Author: Waldemar Bauer <48830226+waldemarbauer@users.noreply.github.com>
Date:   Sun May 17 23:08:48 2020 +0200

    dodanie merg_test

commit ac79c0c6935a338448c41d71d396f5e5b3bf59a5 (origin/test, remote)
Author: Waldemar Bauer <48830226+waldemarbauer@users.noreply.github.com>
Date:   Thu May 14 16:00:12 2020 +0200

    Dodanie ignora na test

commit b1d409e3a74df2dffbdaec43c132f7f51688b495
Author: Waldemar Bauer <48830226+waldemarbauer@users.noreply.github.com>
Date:   Thu May 14 15:56:11 2020 +0200

    przykad do ignora
:	
```
Komenda ta listuje zatwierdzone zmiany w repozytorium zawsze w następujący sposób: 
- odwrotnej kolejności chronologicznej, czyli pokazując najnowsze zmiany w pierwszej kolejności,
- sumę kontrolną SHA-1, zwaną hashem ( ciąg znaków po słowie commit np. *969818327d87bfdd866560e957d0e8a016d9157e*), stanowiącą jednocześnie identyfikator zatwierdzeni - identyfikator ten w skróconej wersji to sześć pierwszych znaków np. *969818*, *ac79c0*, *b1d409*, 
- w nawiasach kontrolnych pokazane są informację o branchach w repozytorium oraz gdzie ustawiony jest znacznik **HEAD** (Znacznik pokazuje w której rewizji obecnie pracujemy).
- nazwą z e-mailem autora zmian, 
- datę zapisu zmiany,
- informację opisującą zmiany.

Symbol `:` pokazuje, że istnieje dalsza historia zmian którą można wyświetlić (ale nie mieści się na konsoli), żeby to zrobić wystarczy wcisnąć klawisz *enter*, jeżeli natomiast dojdziemy do końca historii zmieni się na `(END)`. Wyjście z trybu przeglądania historii następuje po wciśnięciu klawisza `q`.

**Zadanie 1**
1. Wyświetl całą historię zmian dla swojego repozytorium.

### Wyszukiwanie i formatowanie logów

Komenda `log` posiada również rozszerzenia umożliwiające filtrowanie historii rewizji polecenia te to:

| Opcje             	| Opis                                                                     	| Przykład                      	|
|-------------------	|--------------------------------------------------------------------------	|-------------------------------	|
| -(n)              	| Pokaż ostatnie n zatwierdzeń                                             	| git log -3                    	|
| --since, --after  	| Pokaż zatwierdzenia po dacie                                             	| git log --since="2020-05-01"  	|
| --until, --before 	| Pokaż zatwierdzenia przed datą                                           	| git log --before="2020-05-31" 	|
| --author          	| Pokaż zatwierdzone zmiany przez danego autora                            	| git log --author=wbauer       	|
| --grep            	| Pokaż tylko zatwierdzenia z komunikatem zatwierdzenia zawierającym ciąg  	| git log --grep=konflikt       	|
| -S                	| Pokaż tylko zatwierdzenia, dodając lub usuwając kod w plikach pasujący do łańcucha 	| git log -S'Ala ma kota'          	|

Oczywiście wszystkie te polecenia można łączyć, np.:
`git log --author=wbauer --grep=konflikt`

**Zadanie 2**
1. Wyświetl ostatnie dwa wpisy w repozytorium.
2. Wyświetl wszystkie logi z maja 2021 roku.
3. Wyświetl zatwierdzenia zmieniając tekst: 'Jestem w'.

Poza możliwością wyszukiwani istnieje również opcja formatowania wyjścia, przy pomocy komend:

| Opcja       	| Opis                                                                  	|
|-------------	|-----------------------------------------------------------------------	|
| -p          	| Pokaż zmiany wprowadzoną przy każdym zatwierdzeniu.                   	|
| --stat      	| Pokaż statystyki dla plików zmodyfikowanych w każdym zatwierdzeniu.   	|
| --shortstat 	| Wyświetla tylko uproszczony --stat.                                   	|
| --name-only 	| Pokaż listę plików zmodyfikowanych w zatwierdzeniu.                   	|
| --graph     	| Wyświetl wykres ASCII gałęzi i scal historię obok danych wyjściowych. 	|
| --pretty    	| Pokaż zatwierdzenia w innym formacie.                                 	|

Do opcji `pretty` możemy użyć następujących znaczników:

| Opcja 	| Opis                                      	|
|-------	|-------------------------------------------	|
| %H    	| hash zmian                              	|
| %h    	| skrócony hash zmian                     	|
| %T    	| hash drzewa                               	|
| %t    	| skrócony hash drzewa                      	|
| %P    	| hash zmian nadrzędnego                  	|
| %p    	| skrócony hash zmian nadrzędnego         	|
| %an   	| Nazwa autora                              	|
| %ae   	| E-mail autora                             	|
| %ad   	| Data autora (odnosi się do --date=option) 	|
| %ar   	| Data autora, względna                     	|
| %cn   	| Nazwa zatwierdzającego zmiany             	|
| %ce   	| E-mail zatwierdzającego zmiany            	|
| %cd   	| Data zatwierdzającego zmiany              	|
| %cr   	| Data zatwierdzającego zmiany, względna    	|
| %s    	| Wiadomość                                 	|

Oczywiście w tym przypadku również możemy dowolnie łączyć opcje, np: `git log --pretty=format:"%h %s" --since="2020-05-01" --graph --before="2020-05-31"` wyświetli log podobny do: 

```
* 9698183 dodanie merg_test
* ac79c0c Dodanie ignora na test
* b1d409e przykad do ignora
*   a763292 rozwiazanie konfliktu
|\
| * 6838924 konflik test
* | a67a8fc konflikt test origin
|/
*   c44202c Merge branch 'master' of https://github.com/waldemarbauer/piaskownica
|\
| * 37dc3fb zmiana poprawna
* | 331c902 zmiany nie poprawne
|/
* 111d122 Initial commit
```
**Zadanie 3**
1. Wyświetl graph zmian dla swojego repozytorium które pokaże hash zmian, e-mail autor, wiadomość oraz datę zmian. 

## Porównywanie rewizji i plików
Git umożliwia również porównywanie plików i rewizji między sobą, służy do tego  polecenie `diff`. Które może porównywać całość zmian pomiędzy rewizjami, wtedy przyjmuje postać:
```git diff commit_hash1..commit_hash2```
Jeżeli chce porównać tylko konkretny plik wtedy: 
```git diff commit_hash1..commit_hash2 nazwa_pliku```.
Zaznaczyć należy, że jeżeli zmiany nie występują komenda nie wypisze niczego. Szybką metodą porównania jest użycie składni `git diff HEAD~2` porównaj dwie rewizje wstecz od znacznika HEAD. 
Przez analogię zachodzi porównywanie branchy
```git diff branch1..branch2```
i konkretnych plików wewnątrz nich:
```git diff branch1..branch1 <file>```

**Zadanie 4**
1. Porównaj zmiany w pliku README.md po między pierwszą i ostatnią rewizją.

## Cofanie zmian zatwierdzonych i niezatwierdzonych 
Często zdarza się, że dokonaliśmy zmian w projekcie które chcielibyśmy cofnąć. Git umożliwia nam to na kilku płaszczyznach: plików, rewizji oraz poczekalni.

W przypadku plików jeżeli dokonaliśmy zmian i chcemy je cofnąć tylko w tym pliku możemy posłużyć się poleceniem:
```git checkout -- nazwa_pliku numer_rewizji```
należy pamiętać, że dokonane w ten sposób zmiany są nieodwracalne.
Jeżeli chcemy cofnąć wszystkie zmiany wprowadzone w repozytorium należy użyć komendy:
```git reset --hard numer_rewizji```
W tym przypadku również zmiany są nieodwracalne.

Natomiast jeżeli chcemy dodać plik do wykonanego zatwierdzenia należy wykonać następujące polecenia:
```
git add zapomniane_pliki
git commit --amend
``` 
W przypadku gdy chcemy usunąć pliki z poczekalni należy użyć składni:
```
git reset HEAD lista_plików_do_wycofania
```

**Zadanie 5**
W celu przećwiczenia zagadnień z tego rozdziału opracuj zadania ze strony https://learngitbranching.js.org/:
1. Main
	1. Ramping Up
2. Remote
	1. Push & Pull -- Git Remotes!

