import psycopg2
import psycopg2.errorcodes
from psycopg2 import Error
import csv



# ф-ія підключення до бази даних
def create_connection(db_name, db_user, db_password, db_host):
    connection = None
    try:
        connection = psycopg2.connect(
            database=db_name,
            user=db_user,
            password=db_password,
            host=db_host,
        )
        print("З'єднання з БД  успішне")
    except Error as e:
        print(f"{e}")
    return connection


# підключаємося до БД
db_name = input('Назва БД: ')
db_user = input("Ім'я користувача: ")
db_password = input("Пароль: ")
db_host = input("Хост: ")

connection = create_connection(db_name, db_user, db_password, db_host)

cursor = connection.cursor()

sql_query = '''
SELECT zno2019.REGNAME,zno2019.max,zno2020.max 
FROM 
(SELECT Location.RegName, max(Result_languages.Ball100)
FROM Result_languages JOIN Entrant ON
     Result_languages.OutID = Entrant.OutID
JOIN Location ON
     Entrant.locationID = Location.locationId
WHERE Result_languages.NameTest = 'Українська мова і література' AND
      Result_languages.TestStatus = 'Зараховано' AND Result_languages.year='2019'
GROUP BY  Location.RegName) AS zno2019 
RIGHT JOIN 
(SELECT Location.RegName, max(Result_languages.Ball100)
FROM Result_languages JOIN Entrant ON
     Result_languages.OutID = Entrant.OutID
JOIN Location ON
     Entrant.locationID = Location.locationId
WHERE Result_languages.NameTest = 'Українська мова і література' AND
      Result_languages.TestStatus = 'Зараховано' AND Result_languages.year='2020'
GROUP BY  Location.RegName) AS zno2020
ON zno2019.REGNAME=zno2020.REGNAME  
ORDER BY REGNAME;
'''

cursor.execute(sql_query)

with open('result2_ukr_language_and_literature.csv', 'w', encoding="utf-8") as result:
    writer = csv.writer(result)
    writer.writerow(['Область', 'Максимальний бал в 2019', 'Максимальний бал в 2020'])
    row=cursor.fetchone()
    while row:
        writer.writerow(row)
        row = cursor.fetchone()


cursor.close()
connection.close()