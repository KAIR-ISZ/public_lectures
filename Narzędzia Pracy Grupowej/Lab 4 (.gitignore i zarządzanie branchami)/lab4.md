## .gitignore i zarządzanie branchami

Na tym laboratorium zostaną omówione zagadnienia dotyczące:
- tworzenia i zarządzanie plikiem .gitignore,
- tworzenia i zarządzanie branchami.

Wszystkie zadania należy wykonać na repozytorium z poprzednich zajęć. Raport ma być wykonany według zasad z poprzedniego laboratorium.

## .gitignore

W Git-cie każdy plik który ma dodany do kopii roboczej rozpoznaje jako:
- śledzony,
- nieśledzony,
- ignorowany - plik, który użytkownik kazał Gitowi zignorować przy pomocy pliku  .gitignore.


Pliki które chcemy ignorować najczęściej są plikami które tworzą programy edycyjne. Typowe przykłady to:
- pliki pamięci podręcznej, moduły biblioteczne
- efekty kompilacji kodu np.: .o, .pyc, .class, .exe
- katalogi wyjściowe kompilacji np.: /bin, /out lub /target
- pliki generowane w czasie wykonywania np.: .log, .lock lub .tmp
- ukryte pliki systemowe np.: .DS_Store lub Thumbs.db
- osobiste pliki konfiguracyjne IDE np.: .idea/workspace.xml

Informacje o wzorcach nazw plików i folderów  do ignorowania znajdują się w pliku .gitignore . Żeby dodać takie zestaw reguł do naszego repozytorium należy:

**Zadanie 1**

1. Utworzyć plik tekstowy o nazwie **.gitignore** (plik nie może mieć rozszerzenia) w katalogu głównym naszego repozytorium to znaczy w folderze npg_imię_nazwisko
2. Za pomocą linii poleceń dodań plik do repozytorium i zatwierdź go.


### Dodawanie wzorców do .gitignore

Żeby konkretny plik lub pliki/foldery odpowiadające wzorcowi były ignorowane przez Git należy w nowej linii pliku .gitignore dodać ścieżkę do pliku (ignorowany jest wtedy tylko konkretny plik) lub wzorzec nazw, ścieżek lub polików (ignorowany jest wtedy każdy plik który spełnia wzorzec). Ignorowanie oznacza, że zmiany w pliku nie będą śledzone przez repozytorium, to znaczy ich zmiana nie będzie widoczna po wydaniu polecenia `git status` i ich dodanie do śledzenia za pomocą `git add`. Konstrukcja wzorców odbywa się według następujących zasad:

|               Wzorzec               	|                                      Przykład dopasowania                                      	| Wyjaśnienia                                                                                                                             	|
|:-----------------------------------:	|:----------------------------------------------------------------------------------------------:	|-----------------------------------------------------------------------------------------------------------------------------------------	|
|               \*\*/logs               	|                  logs/debug.log   logs/monday/foo.bar   build/logs/debug.log                   	| ignorowanie katalogów w dowolnym miejscu repozytorium które mają w ścieżce np. logs                                                      	|
|          \*\*/logs/debug.log          	|            logs/debug.log   build/logs/debug.log   ale nie   logs/build/debug.log              	| ignorowanie konkretnego pliku w konkretnym katalogu z dowlnego miejsca w repozytorium                                                   	|
|                \*.log                	|                          debug.log   foo.log   .log   logs/debug.log                           	| ignorowanie plików o rozszerzeniu np. .log o dowolnej nazwie                                                                            	|
|        \*.log   !important.log       	|             debug.log   trace.log   ale nie   important.log   logs/important.log               	| ignorowanie plików np. log ale nie plików important.log, symbol **!** neguje wzorce poprzedzające ale nie następnych                    	|
| \*.log   !important/*.log   trace.* 	|              debug.log    important/trace.log    ale nie     important/debug.log               	| przykład działania **!** negacji z wzorcami po jej użyciu                                                                               	|
|              /debug.log             	|                             debug.log   ale nie   logs/debug.log                               	| ignorowanie konkretnego pliku w konkretnym katalogu (w tym przykładzie katalog główny)                                                  	|
|              debug.log              	|                                   debug.log   logs/debug.log                                   	| ignorowanie wszystkich plików o konkretnej nazwie i typie                                                                               	|
|              debug?.log             	|                         debug0.log   debugg.log   ale nie   debug10.log                        	| ignorowanie plików z jednym znakiem którego nie znamy, w jego miejsce wpisujemy **?**                                                   	|
|            debug[0-9].log           	|                          debug0.log   debug1.log   ale nie debug10.log                         	| ignorowanie plików w którym nazwa zawiera element z przedziłu umieszczonego w zbiorze **[]**, zbiór może być również literowy np. [a-z] 	|
|            debug[01].log            	|                    debug0.log   debug1.log   ale nie  debug2.log debug01.log                   	| ignorowanie plików w których występuje jeden ze znaków podany w zbiorze                                                                 	|
|            debug[!01].log           	|                 debug2.log   ale nie   debug0.log   debug1.log   debug01.log                   	| ignorowanie plików w którym nazwa nie zawiera element z przedziłu umieszczonego w zbiorze **[]**                                        	|
|                 logs                	|             logs logs/debug.log logs/latest/foo.bar build/logs build/logs/debug.log            	| ignorowanie plików i folderów o zdanej nazwie                                                                                           	|
|                logs/                	| logs/debug.log     logs/latest/foo.bar     build/logs/foo.bar    build/logs/latest/debug.log   	| ignorowanie wszystkich katalogów o zadanej nazwie np. logs                                                                               	|
|          logs/\*\*/debug.log          	|               logs/debug.log   logs/monday/debug.log   logs/monday/pm/debug.log                	| ignorowanie plików o zdanej nazwie w ścieżce która zaczyn się od np. logs    

### Ignorowanie konkretnych plików

**Zadanie 2**
1. Dodaj dowolny plik typu txt do repozytorium.
2. Wyślij zmiany na serwer.
3. Do pliku **.gitignore** dodaj regułę ignorowania tego konkretnego pliku.
4. Zatwierdź zmiany i wyślij je na serwer
5. Dokonaj edycji pliku txt który został dodany w punkcie 1. 
6. Za pomocą komendy `git status` sprawdź czy zmiany są widoczne w repozytorium.
7. Usuń plik txt z repozytorium przy pomocy polecenia `git rm nazwa_pliku`
8. Zatwierdź operację i zmiany wyślij na serwer.

### Ignorowanie plików i folderów o zadanym wzorcu

**Zadanie 3**
1. Dodaj regułę do ignorowania folderów o nazwie *log* i *build*
2. Dodaj regułę do ignorowania plików typu *.pdf*, *.tmp* i *.log*.
3. Zatwierdź zmiany i wyślij je na serwer.
4. Sprawdź działanie pliku .gitignore


## Zarządzanie branchami

Prawie każdy system kontroli wersji posiada wsparcie dla branchy (gałęzi). Główny branch repozytorium ma  domyślną nazwę *master*. Branch to odnoga dowolnego wątku w repozytorium (najczęściej mastera) który umożliwia pracę nad rozwojem projektu bez wprowadzania zmian do wątku z którego się wywodzi. Zapewnia to przejrzystoś w przypadku gdy nasze zmiany są wprowadzane dla testu lub rozwój naszej części projektu mógłby uniemożliwić pracę reszty zespołu. Ponieważ branche można ze sobą łączyć (*"mergeować"*) w dowolny sposób mechanizm ten zapewnia komfort pracy dla wszystkich członków zespołu.


### Tworzenie nowego brancha

Nowy brach możemy tworzyć gdy nie chcemy by nasze zmiany wpływały na pracę reszty zespołu oraz gdy chcemy na bazie przygotowanego rozwiązania stworzyć nową/demonstracyjną/rozszerzoną wersję. Dodawanie nowego branchu odbywa się według schematu:  

**Zadanie 4**

1. Upewnij się, że wszystkie zmiany wprowadzone w repozytorium zostały zatwierdzone.
2. Sprawdź jakie branche obecnie znajdują się na twoim lokalnym repozytorium używając polecenia`git branch`.
3. Utwórz nowy branch o nazwie *npg_test* za pomocą polecenia `git branch nazwa_brancha`
4. Ponownie sprawdź jakie branche znajdują się w twoim repozytorium, branch w którym aktualnie się znajdujesz będzie oznaczony `*` przy nazwie. 
5. Przejedź do brnancha *npg_test* za pomocą komendy `git checkout nazwa_brancha`.
6. Sprawdź czy znajdujesz się w odpowiednim branchu.
7. Synchronizuj zdalne repozytorium z nowym branchem przy pomocy polecenia: `git push --set-upstream origin nazwa_brancha`.
8. Sprawdź czy branch został synchronizowany z serwerem, możesz do tego użyć komendy: `git branch --remote` lub krócej `git branch -r`. Lub sprawdzić na stronie repozytorium w miejscu: 

 <img src='./img/github_branch.png'>


Po utworzeniu brancha i przejściu do niego możemy zacząć w nim pracować: 

**Zadanie 5**

1. W branchu *npg_test* dodaj plik *merge_test.txt*, upewnij się, że jesteś we właściwym branchu.
2. Dodaj do niego treść: 'Jestem w branchu npg_test'.
3. Dodaj plik do repozytorium, zatwierdź zmiany i wyślij je na serwer już przy pomocy polecenia `git push`. 
4. Sprawdź czy branch został synchronizowany z serwerem.

### Łączenie (*"mergowanie"*) branchy

Po zatwierdzeniu zmian jakie chcieliśmy przeprowadzić w nowym branchu i uznaliśmy za wartościowe do wprowadzenia w wątku głównym, możemy je ze sobą połączyć. Łączenie branchy odbywa się w następujący sposób:  

**Zadanie 6**

1. Przy pomocy polecenia `checkout` przejdź do brancha `master`.
2. Sprawdź czy plik *merge_test.txt* istnieje (nie powinien).
3. Przystąpimy do połączenia (**merge**) branchy w tym celu wydaj komendę `git merge npg_test`
4. Sprawdź czy plik *merge_test.txt* został do dany do  tego brancha.
5. Wprowadź zmiany w pliku *merge_test.txt*
5. Wyślij zmiany na serwer.
6. Sprawdź jak wyglądają oba wątki w repozytorium. 

### Usuwanie brancha

Jeżeli uznamy, że któryś z branchy jest nam już niepotrzebny a historia jego rozwoju nie będzie dalej nam potrzebna możemy go usunąć. Pamiętajmy jednak o dwóch zasadach:
- usunięcie brancha lokalnie nie spowoduje jego usunięcia w repozytorium zdalnym,
- historia wszystkich zmian zostanie również usunięta.

Jeżeli jednak nasza decyzja o usunięciu została podjęta, możemy tego dokonać przy pomocy następujących czynności:

**Zadanie 7**

1. Usuń lokalnie branch *npg_test* za pomocą polecenia `git branch -d nazwa_brancha`
2. Sprawdź czy nadal znajduje się na liście branchy lokalnych.
3. Sprawdź czy nadal znajduje się na liście branchy zdalnych.
4. Usuń zdalny branch przy pomocy polecenia `git push url_repozytorium --delete nazwa_brancha`
5. Sprawdź efekty w zdalnym i lokalnym repozytorium.


### Zadania uzupełniające (obowiązkowe)

Dla lepszego zrozumienia i zobrazowania procesu działania repozytorium i  branchy zachęcam do  sięgnięcia do interaktywnych webowych kursów:
- https://try.github.io/ 
- http://git-school.github.io/visualizing-git/#free
- https://learngitbranching.js.org/
lub kursów offline:
- https://github.com/jlord/git-it-electron#what-to-install

**Zadanie 8**

Wykonaj ćwiczenia **Introduction Sequence** (4 zadania) z zakładki **Main** ze strony https://learngitbranching.js.org/
 
