# Ćwiczenie 1 - Data Scientist Toolbox

Celem zajęć jest zapoznanie się ze środowiskiem pracy na przedmiocie Analiza i Bazy Danych.

## Zadanie 1

Zainstaluj wirtualne środowisko conda/pip na systemie Ubuntu.

1. Stworzenie środowiska wirtualnego, którego nazwa to imięnazwisko.
2. Aktywacja środowiska wirtualnego.
3. Instalacja pakietów Python z pliku requirements.txt.
4. Wylistowanie zainstalowanych pakietów.
5. Zrobienie zrzutu ekranu i dodanie do kursu na upel.agh.edu.pl

### Venv & pip (natywne narzędzia Pythona)

Dokumentacja narzędzi

- [venv](https://docs.python.org/3/library/venv.html)
- [Python Documentation - Installing Python Modules](https://docs.python.org/3/installing/index.html)
- [PyPi - pip](https://pypi.org/project/pip/)

1. Tworzenie nowego środowiska o nazwie `"venv"`

```
python3 -m venv venv
```

2. Aktywacja środowiska (Linux)

```
source venv/bin/activate
```

3. Instalacja paczek (bez pliku requirements.txt)

```
python3 -m pip install <lista paczek>
```

4. Instalacja paczek (z pliku requirements.txt)

```
python3 -m pip install -r <ścieżka do pliku requirements.txt>
```

### Conda

Dokumentacja

- [Conda - managing environments](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)

1. Tworzenie środowiska conda o nazwie `"venv"`

```
conda create --name venv
```

2. Aktywacja środowiska o nazwie `"venv"`

```
conda activate venv
```

3. Instalacja paczek [dokumentacja](https://docs.conda.io/projects/conda/en/latest/commands/install.html) (bez requirements.txt)

```
conda install --name <nazwa środowiska> -c <nazwa kanału> <nazwa paczki>
```

4. Instalacja paczek (z plikiem requirements.txt)

```
conda install --name <nazwa środowiska> -c <nazwa kanału> <nazwa paczki> --file <ścieżka do pliku requirements.txt>
```

### Materiały:

[Conda Environment Guide](http://uoa-eresearch.github.io/eresearch-cookbook/recipe/2014/11/20/conda)  
[Python Pip List Freeze](https://note.nkmk.me/en/python-pip-list-freeze/)

## Zadanie 2

Utwórz własne repozytorium do przedmiotu na github.com.

1. Utworzenie własnego repozytorium.
2. Sklonowanie repozytorium.
3. Dodanie plików do repozytorium.
4. Wstawienie linku do repozytorium do kursu na upel.agh.edu.pl.

## Zadanie 3

Zdefiniuj poniższą funkcję i sporządź jej wykres dla argumentów z danego przedziału:

$f(x)=x^2+5$

1. $x>-1 oraz x<1$
2. $x>-6 oraz x<6$
3. $x>0 oraz x<5$

Wspierając się dokumentacją [Matplotlib](https://matplotlib.org/). Dodaj do wykresu etykiety osi, tytuły wykresów i legendy.

Wskazówki: Deklaracja [funkcji](https://www.w3schools.com/python/python_functions.asp) w Python.

W Pythonie bloki kodu (w tym również funkcje) są wyróżniane za pomocą wcięć. Do wizualizacji wyników w Pythonie używa się pakietu [Matplotlib](https://matplotlib.org/).

W pliku mają być zawarte: imię, nazwisko, opis wykonywanego ćwiczenia - formatowanie markdown w poszczególnych komórkach.

## Zadanie 4

Utwórz [dataframe](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.html), w którym kolumny mają nazwy: name, surname, age, sex. Uzupełnij pięcioma dowolnymi rekordami oraz wyświetl informacje o danych [pandas .info()](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.info.html), opis danych [pandas .describe()](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.describe.html), wyświetl pierwsze trzy rekordy [pandas .head()](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.head.html).

Plik z rozwiązaniem zadania 3 i zadania 4 opatrzonym komentarzami, dodaj do kursu na upel.agh.edu.pl
