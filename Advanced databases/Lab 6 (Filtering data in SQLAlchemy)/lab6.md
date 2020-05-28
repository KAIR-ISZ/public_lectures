# Filtering data in SQLAlchemy

The purpose of these laboratory classes is to familiarize participants with methods to creating and execute select query with conditions.

The scope of this classes:
- using select() - to creating select query
- using query() - to creating query
- and_() , or_(), in_() - to add conditions to query
- order_by() - to sort results
- label() - to make alias
- limit() - to limit results of query

## Introduction 
From the previous classes we know two methods of creating a database model in SQLAlchemy based on:
- [mapper](https://docs.sqlalchemy.org/en/13/orm/mapping_api.html#sqlalchemy.orm.mapper)
-  [Class representation](https://docs.sqlalchemy.org/en/13/orm/tutorial.html)

For both, we must first connect to the database

```python

from sqlalchemy import create_engine

engine = create_engine(url_to_database)
```

We can use a script to initialize mapper operation:

```python
from sqlalchemy import create_engine, MetaData, Table

metadata = MetaData()

dic_table = {}
for table_name in db.table_names():
    dic_table[table_name] = Table(table_name, metadata , autoload=True, autoload_with=engine)
	
print(repr(dic_table['category']))
```
Where `dic_table` is the dictionary with tables representation where the key is the name of the table. The last line in the script above shows references to the table representation named *category*.

If we want youse Object representation we need run script:

```python
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

from sqlalchemy import Column, Integer, String, Date, ForeignKey

session = (sessionmaker(bind=engine))()

Base = declarative_base()

class Category(Base):
    __tablename__ = 'category'
    category_id  = Column(Integer, primary_key=True)
    name = Column(String(50))
    last_update  = Column(Date)
    def __str__(self):
        return 'Category id:{0}\nCategory name: {1}\nCategory last_update: {2}'.format(self.category_id,self.name,self.last_update)
```
At the moment we are ready to start creating database queries. The advantage of using ORM is that you don't have to rewrite queries when changing the database engine. The disadvantage, however, is that we are limited by query structures imposed by ORM.

If this does not suit us, we can of course run a query written by us:

```python 
stmt = 'select * from category'

results = db.execute(stmt).fetchall()

print(results)
```

## Basic select

To make query we can use script:

```python
from sqlalchemy import select

# select * from category

mapper_stmt = select([dic_table['category']]).limit(10)
print('Mapper select: ')
print(stmt)

session_stmt = session.query(Category)
print('\nSession select: ')
print(session_stmt)
```

```sql
Mapper select:
SELECT category.category_id, category.name, category.last_update 
FROM category

Session select:
SELECT category.category_id AS category_category_id, category.name AS category_name, category.last_update AS category_last_update 
FROM category
```
As can be seen in the case of a query based on the class session, aliases are added to the names of the columns returned. This is the only difference at this stage of building queries.

To run a query based on the select class:
```python
mapper_results = db.execute(mapper_stmt).fetchall()
print(results)
```
As a result of the script, we get a list of tuples representing the values of table rows. Examples:

```python
[(1, 'Action', datetime.datetime(2006, 2, 15, 9, 46, 27)), (2, 'Animation', datetime.datetime(2006, 2, 15, 9, 46, 27)), (3, 'Children', datetime.datetime(2006, 2, 15, 9, 46, 27)), (4, 'Classics', datetime.datetime(2006, 2, 15, 9, 46, 27)), (5, 'Comedy', datetime.datetime(2006, 2, 15, 9, 46, 27)), (6, 'Documentary', datetime.datetime(2006, 2, 15, 9, 46, 27)), (7, 'Drama', datetime.datetime(2006, 2, 15, 9, 46, 27)), (8, 'Family', datetime.datetime(2006, 2, 15, 9, 46, 27)), (9, 'Foreign', datetime.datetime(2006, 2, 15, 9, 46, 27)), (10, 'Games', datetime.datetime(2006, 2, 15, 9, 46, 27)), (11, 'Horror', datetime.datetime(2006, 2, 15, 9, 46, 27)), (12, 'Music', datetime.datetime(2006, 2, 15, 9, 46, 27)), (13, 'New', datetime.datetime(2006, 2, 15, 9, 46, 27)), (14, 'Sci-Fi', datetime.datetime(2006, 2, 15, 9, 46, 27)), (15, 'Sports', datetime.datetime(2006, 2, 15, 9, 46, 27)), (16, 'Travel', datetime.datetime(2006, 2, 15, 9, 46, 27))]
```
This form of results presentation is inconvenient if we use objectivity in all our software. To return results as a class, use the formula

```python
session_results = session_stmt.all()
# all results print
print(All results: )
print(session_results)
# print information from first category in result list
print(\nFirst category:)
print(session_results[0])
```

```python
All results:
[<__main__.Category object at 0x000001F996CB8588>, <__main__.Category object at 0x000001F996CB83C8>, <__main__.Category object at 0x000001F996CB8FC8>, <__main__.Category object at 0x000001F996CB8948>, <__main__.Category object at 0x000001F996C97F88>, <__main__.Category object at 0x000001F996C97988>, <__main__.Category object at 0x000001F996C97EC8>, <__main__.Category object at 0x000001F996C97DC8>, <__main__.Category object at 0x000001F996C97B08>, <__main__.Category object at 0x000001F996C97C48>, <__main__.Category object at 0x000001F996C97C08>, <__main__.Category object at 0x000001F996C974C8>, <__main__.Category object at 0x000001F996C97CC8>, <__main__.Category object at 0x000001F996C7CB88>, <__main__.Category object at 0x000001F996C7CAC8>, <__main__.Category object at 0x000001F996C6A1C8>]

First category:
Category id:1
Category name: Action
Category last_update: 2006-02-15 09:46:27
```
As you can easily see in this case, the overloaded operator operator ** __ str __ **. This approach is very useful in implementing business logic.

If we want to create a query for selected columns then we use the following pattern:

```python
mapper_stmt = select([dic_table['category'].columns.category_id,dic_table['category'].columns.name])

session_stmt = session.query(Category.category_id, Category.name)
```
In this case, the query will return a list of results in both cases. If you want to use object mapping, create a class  and set session query in this way:

```python
class Category_filter(Base):
    __tablename__ = 'category'
    __table_args__ = {'extend_existing': True}
    category_id  = Column(Integer, primary_key=True)
    name = Column(String(50))
    def __str__(self):
        return 'Category id:{0}\nCategory name: {1}'.format(self.category_id,self.name)
    
q = session.query(Category_filter)
print(q)
```


## Select with conditions

To start filtering according to a given criterion:
- mapper option:
```python
mapper_stmt = select([dic_table['category'].columns.category_id,dic_table['category'].columns.name]).where(dic_table['category'].columns.name == 'Games')

```
- session option:
```python
session_stmt = session.query(Category.category_id, Category.name).filter(Category.name == 'Games')

```

We can also use logical conditions, such as::
- or_
- and_
- in_

Example of use or_ and and_ in one query: 
```python
from sqlalchemy import or_, and_, in_

mapper_stmt = select([dic_table['category'].columns.category_id,dic_table['category'].columns.name]).\
where(and_(\
            or_(dic_table['category'].columns.category_id > 10,dic_table['category'].columns.category_id < 2), \
            or_(dic_table['category'].columns.category_id > 3,dic_table['category'].columns.category_id < 5)))

session_stmt = session.query(Category_filter).\
filter(and_(\
            or_(Category_filter.category_id > 10,Category_filter.category_id < 2), \
            or_(Category_filter.category_id > 3,Category_filter.category_id < 5)))
```

If we also want to use the in_ function:
```python

mapper_stmt = select([dic_table['category'].columns.category_id,dic_table['category'].columns.name]).\
where(and_(\
            or_(dic_table['category'].columns.category_id > 10,dic_table['category'].columns.category_id < 2),\
            or_(dic_table['category'].columns.category_id > 3,dic_table['category'].columns.category_id < 5),\
      dic_table['category'].columns.name.in_(['Sci-Fi','Horror','Action'])
     ))

session_stmt = session.query(Category_filter).\
filter(and_(\
            or_(Category_filter.category_id > 10,Category_filter.category_id < 2), \
            or_(Category_filter.category_id > 3,Category_filter.category_id < 5)),\
       Category_filter.name.in_(['Sci-Fi','Horror','Action'])
      )
```

## Sort results in query
In both cases it is possible to sort using the order_by function. For ascending sorting, the harvest will look like this:
```python
mapper_stmt = select([dic_table['category'].columns.category_id,dic_table['category'].columns.name]).\
where(and_(\
            or_(dic_table['category'].columns.category_id > 10,dic_table['category'].columns.category_id < 2), \
            or_(dic_table['category'].columns.category_id > 3,dic_table['category'].columns.category_id < 5))).\
order_by(dic_table['category'].columns.name)

mapper_results = db.execute(mapper_stmt).fetchall()

print(mapper_results)
```
```python
[(1, 'Action'), (11, 'Horror'), (12, 'Music'), (13, 'New'), (14, 'Sci-Fi'), (15, 'Sports'), (16, 'Travel')]

```
And in reverse:

```python
mapper_stmt = select([dic_table['category'].columns.category_id,dic_table['category'].columns.name]).\
where(and_(\
            or_(dic_table['category'].columns.category_id > 10,dic_table['category'].columns.category_id < 2), \
            or_(dic_table['category'].columns.category_id > 3,dic_table['category'].columns.category_id < 5))).\
order_by(dic_table['category'].columns.name.desc())

mapper_results = db.execute(mapper_stmt).fetchall()

print(mapper_results)
```
```python
[(16, 'Travel'), (15, 'Sports'), (14, 'Sci-Fi'), (13, 'New'), (12, 'Music'), (11, 'Horror'), (1, 'Action')]
```

The same applies to sessions:

```python
session_stmt_asc= session.query(Category_filter).\
filter(and_(\
            or_(Category_filter.category_id > 10,Category_filter.category_id < 2), \
            or_(Category_filter.category_id > 3,Category_filter.category_id < 5))).\
order_by(Category_filter.name)

session_stmt_desc= session.query(Category_filter).\
filter(and_(\
            or_(Category_filter.category_id > 10,Category_filter.category_id < 2), \
            or_(Category_filter.category_id > 3,Category_filter.category_id < 5))).\
order_by(Category_filter.name.desc())
```

## Alias name

Of course, you can also enter aliases for names via the label function. Examples of use:
```python
mapper_stmt = select([dic_table['category'].columns.category_id.label('id'),dic_table['category'].columns.name.label('category name')])
print(mapper_stmt)
```
```sql
SELECT category.category_id AS id, category.name AS "category name" 
FROM category
```
```python
session_stmt= session.query(Category_filter.category_id.label('id'), Category_filter.name.label('category name'))
print(session_stmt)

```
```sql
SELECT category.category_id AS id, category.name AS "category name" 
FROM category
```


## Limits on the results in query
To limit the number of records returned by the database, we can use the limit function. Her work is illustrated by examples:
```python
mapper_stmt = select([dic_table['category'].columns.category_id.label('id'),dic_table['category'].columns.name.label('category name')]).limit(3)
print(mapper_stmt)
```
```sql
SELECT category.category_id AS id, category.name AS "category name" 
FROM category
LIMIT :param_1
```
```python
session_stmt= session.query(Category_filter.category_id.label('id'), Category_filter.name.label('category name')).limit(3)
print(session_stmt)

```
```sql
SELECT category.category_id AS id, category.name AS "category name" 
FROM category
LIMIT %(param_1)s
```
## Exercise 

Use all of these methods to create queries for the test database. Check their execution time using the [profiling and timing code methods](https://jakevdp.github.io/PythonDataScienceHandbook/01.07-timing-and-profiling.html).

For queries:
1. How many categories of films we have in the rental?
2. Display list of categories in alphabetic order.
3. Find the oldest and youngest film in rental.
4. How many rentals were in between 2005-07-01 and 2005-08-01?
5. How many rentals were in between 2010-01-01 and 2011-02-01?
6. Find the biggest payment in the rental.
7. Find all customers from Polend or Nigeria or Bangladesh.
8. Where live staff memebers?
9. How many staff members live in Argentina or Spain?
10. Which categories of the films were rented by clients?
11. Find all categories of films rented in America.
12. Find all title of films where was playe: Olympia Pfeiffer or Julia Zellweger or Ellen Presley



