-- =====================================================
-- Quête SQL : base wild_db_quest (historique du terminal)
-- =====================================================

-- =====================================================
-- CHALLENGE 1 : Créer la base et les tables
-- =====================================================

-- Étape 1 / 4 : Créer une base de données wild_db_quest et se placer dessus
mysql> CREATE DATABASE wild;
ERROR 1007 (HY000): Can't create database 'wild'; database exists
mysql> USE wild
Database changed
mysql> SHOW DATABASE;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'DATABASE' at line 1
mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| wild               |
+--------------------+
5 rows in set (0.82 sec)

mysql> CREATE TABLE wild_db_quest;
ERROR 4028 (HY000): A table must have at least one visible column.
mysql> CREATE BASE wild_db_quest;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'BASE wild_db_quest' at line 1
mysql> CREATE DATABASE wild_db_quest;
Query OK, 1 row affected (0.03 sec)

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| wild               |
| wild_db_quest      |
+--------------------+
6 rows in set (0.00 sec)

mysql> USE wild_db_quest;
Database changed


-- Étape 2 / 4 : Créer la table wizard
mysql> CREATE TABLE wizard (
    -> id INT NOT NULL AUTO_INCREMENT,
    -> firstname VARCHAR(100) NOT NULL,
    -> lastname VARCHAR(100) NOT NULL,
    -> birthday DATE DEFAULT NULL,
    -> birth_place BARCHAR(255) DEFAULT NULL,
    -> biography TEXT DEFAULT NULL,
    -> PRIMARY KEY (id)
    -> );
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'BARCHAR(255) DEFAULT NULL,
biography TEXT DEFAULT NULL,
PRIMARY KEY (id)
)' at line 6
mysql> CREATE TABLE wizard (
    -> id INT NOT NULL AUTO_INCREMENT,
    -> firstname VARCHAR(100) NOT NULL,
    -> lastname VARCHAR(100) NOT NULL,
    -> birthday DATE DEFAULT NULL,
    -> birth_place VARCHAR(255) DEFAULT NULL,
    -> biography TEXT DEFAULT NULL,
    -> PRIMARY KEY (id)
    -> );
Query OK, 0 rows affected (0.63 sec)

-- Étape 3 / 4 : Modifier la table wizard (ajout du champ is_muggle)
mysql> ALTER TABLE wizard ADD is_muggle BOOLEAN NOT NULL;
Query OK, 0 rows affected (0.31 sec)
Records: 0  Duplicates: 0  Warnings: 0

-- Vérification : DESCRIBE wizard
mysql> DESCRIBE wizard;
+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| id          | int          | NO   | PRI | NULL    | auto_increment |
| firstname   | varchar(100) | NO   |     | NULL    |                |
| lastname    | varchar(100) | NO   |     | NULL    |                |
| birthday    | date         | YES  |     | NULL    |                |
| birth_place | varchar(255) | YES  |     | NULL    |                |
| biography   | text         | YES  |     | NULL    |                |
| is_muggle   | tinyint(1)   | NO   |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+
7 rows in set (0.06 sec)


-- Étape 4 / 4 : Créer la table school
mysql> CREATE TABLE school (
    -> id INT NOT NULL AUTO_INCREMENT,
    -> name VARCHAR(100) NOT NULL,
    -> capacity INT DEFAULT NULL,
    -> country VARCHAR(255) NOT NULL,
    -> PRIMARY KEY (id)
    -> );
Query OK, 0 rows affected (0.07 sec)

-- Vérification : DESCRIBE school
mysql> DESCRIBE school
    -> ^C
mysql> DESCRIBE school;
+----------+--------------+------+-----+---------+----------------+
| Field    | Type         | Null | Key | Default | Extra          |
+----------+--------------+------+-----+---------+----------------+
| id       | int          | NO   | PRI | NULL    | auto_increment |
| name     | varchar(100) | NO   |     | NULL    |                |
| capacity | int          | YES  |     | NULL    |                |
| country  | varchar(255) | NO   |     | NULL    |                |
+----------+--------------+------+-----+---------+----------------+
4 rows in set (0.02 sec)

-- Vérification : SHOW TABLES
mysql> SHOW TABLE;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 1
mysql> SHOW TABLES;
+-------------------------+
| Tables_in_wild_db_quest |
+-------------------------+
| school                  |
| wizard                  |
+-------------------------+
2 rows in set (0.13 sec)

-- =====================================================
-- CHALLENGE 2 : Requêtes SELECT
-- =====================================================

-- Préparation : insertion des sorciers
mysql> INSERT INTO wild_db_quest.wizard
    ->   (firstname, lastname, birthday, birth_place, biography, is_muggle)
    ->   VALUES
    ->   ('harry', 'potter', '1980-07-31', 'london', '', '0'),
    ->   ('hermione', 'granger', '1979-09-19', '', 'Friend of Harry Potter', '0'),
    ->   ('lily', 'potter', '1960-01-30', '', 'mother of Harry Potter', '0'),
    ->   ('ron', 'weasley', '1980-03-01', '', 'Best friend of Harry', '0'),
    ->   ('ginny', 'weasley', '1981-08-11', '', 'Sister of Ron and girlfriend of Harry', '0'),
    ->   ('fred', 'weasley', '1978-04-01', '', '', '0'),
    ->   ('george', 'weasley', '1978-04-01', '', '', '0'),
    ->   ('arthur', 'weasley', '1950-02-06', '', '', '0'),
    ->   ('molly', 'weasley', '1949-01-01', '', '', '0'),
    ->   ('drago', 'malefoy', '1980-06-05', '', '', '0'),
    ->   ('albus', 'dumbledore', '1881-07-01', '', '', '0'),
    ->   ('severus', 'rogue', '1960-01-09', '', '', '0'),
    ->   ('tom', 'jédusor', '1926-12-31', '', 'Celui-Dont-On-Ne-Doit-Pas-Prononcer-Le-Nom alias Voldermort', '0'),
    ->   ('dudley', 'dursley', '1980-06-23', '', 'Cousin d\'Harry', '1');
Query OK, 14 rows affected (0.02 sec)
Records: 14  Duplicates: 0  Warnings: 0

-- -----------------------------------------------------
-- Entraînement (exemples du cours)
-- -----------------------------------------------------

-- Tous les sorciers
mysql> SELECT * FROM wizard;
+----+-----------+------------+------------+-------------+-------------------------------------------------------------+-----------+
| id | firstname | lastname   | birthday   | birth_place | biography                                                   | is_muggle |
+----+-----------+------------+------------+-------------+-------------------------------------------------------------+-----------+
|  1 | harry     | potter     | 1980-07-31 | london      |                                                             |         0 |
|  2 | hermione  | granger    | 1979-09-19 |             | Friend of Harry Potter                                      |         0 |
|  3 | lily      | potter     | 1960-01-30 |             | mother of Harry Potter                                      |         0 |
|  4 | ron       | weasley    | 1980-03-01 |             | Best friend of Harry                                        |         0 |
|  5 | ginny     | weasley    | 1981-08-11 |             | Sister of Ron and girlfriend of Harry                       |         0 |
|  6 | fred      | weasley    | 1978-04-01 |             |                                                             |         0 |
|  7 | george    | weasley    | 1978-04-01 |             |                                                             |         0 |
|  8 | arthur    | weasley    | 1950-02-06 |             |                                                             |         0 |
|  9 | molly     | weasley    | 1949-01-01 |             |                                                             |         0 |
| 10 | drago     | malefoy    | 1980-06-05 |             |                                                             |         0 |
| 11 | albus     | dumbledore | 1881-07-01 |             |                                                             |         0 |
| 12 | severus   | rogue      | 1960-01-09 |             |                                                             |         0 |
| 13 | tom       | jédusor    | 1926-12-31 |             | Celui-Dont-On-Ne-Doit-Pas-Prononcer-Le-Nom alias Voldermort |         0 |
| 14 | dudley    | dursley    | 1980-06-23 |             | Cousin d'Harry                                              |         1 |
+----+-----------+------------+------------+-------------+-------------------------------------------------------------+-----------+
14 rows in set (0.00 sec)

-- Prénoms et noms
mysql> SELECT firstname, lastname FROM wizard;
+-----------+------------+
| firstname | lastname   |
+-----------+------------+
| harry     | potter     |
| hermione  | granger    |
| lily      | potter     |
| ron       | weasley    |
| ginny     | weasley    |
| fred      | weasley    |
| george    | weasley    |
| arthur    | weasley    |
| molly     | weasley    |
| drago     | malefoy    |
| albus     | dumbledore |
| severus   | rogue      |
| tom       | jédusor    |
| dudley    | dursley    |
+-----------+------------+
14 rows in set (0.00 sec)

-- Alias de colonne
mysql> SELECT lastname AS student_name FROM wizard;
+--------------+
| student_name |
+--------------+
| potter       |
| granger      |
| potter       |
| weasley      |
| weasley      |
| weasley      |
| weasley      |
| weasley      |
| weasley      |
| malefoy      |
| dumbledore   |
| rogue        |
| jédusor      |
| dursley      |
+--------------+
14 rows in set (0.00 sec)

-- Prénom et date de naissance des Weasley
mysql> SELECT firstname, birthday FROM  wizard WHERE lastname='Weasley';
+-----------+------------+
| firstname | birthday   |
+-----------+------------+
| ron       | 1980-03-01 |
| ginny     | 1981-08-11 |
| fred      | 1978-04-01 |
| george    | 1978-04-01 |
| arthur    | 1950-02-06 |
| molly     | 1949-01-01 |
+-----------+------------+
6 rows in set (0.00 sec)

-- Weasley nés entre 1970 et 2000
mysql> SELECT firstname, birthday
    -> FROM wizard
    -> WHERE
    -> lastname LIKE 'Weas%' AND
    -> birthday BETWEEN '1970-01-01' AND '2000-01-01';
+-----------+------------+
| firstname | birthday   |
+-----------+------------+
| ron       | 1980-03-01 |
| ginny     | 1981-08-11 |
| fred      | 1978-04-01 |
| george    | 1978-04-01 |
+-----------+------------+
4 rows in set (0.00 sec)

-- Les 5 premiers sorciers
mysql> SELECT * FROM wizard LIMIT 5;
+----+-----------+----------+------------+-------------+---------------------------------------+-----------+
| id | firstname | lastname | birthday   | birth_place | biography                             | is_muggle |
+----+-----------+----------+------------+-------------+---------------------------------------+-----------+
|  1 | harry     | potter   | 1980-07-31 | london      |                                       |         0 |
|  2 | hermione  | granger  | 1979-09-19 |             | Friend of Harry Potter                |         0 |
|  3 | lily      | potter   | 1960-01-30 |             | mother of Harry Potter                |         0 |
|  4 | ron       | weasley  | 1980-03-01 |             | Best friend of Harry                  |         0 |
|  5 | ginny     | weasley  | 1981-08-11 |             | Sister of Ron and girlfriend of Harry |         0 |
+----+-----------+----------+------------+-------------+---------------------------------------+-----------+
5 rows in set (0.00 sec)

mysql> SELECT * FROM wizard LIMIT 5;
+----+-----------+----------+------------+-------------+---------------------------------------+-----------+
| id | firstname | lastname | birthday   | birth_place | biography                             | is_muggle |
+----+-----------+----------+------------+-------------+---------------------------------------+-----------+
|  1 | harry     | potter   | 1980-07-31 | london      |                                       |         0 |
|  2 | hermione  | granger  | 1979-09-19 |             | Friend of Harry Potter                |         0 |
|  3 | lily      | potter   | 1960-01-30 |             | mother of Harry Potter                |         0 |
|  4 | ron       | weasley  | 1980-03-01 |             | Best friend of Harry                  |         0 |
|  5 | ginny     | weasley  | 1981-08-11 |             | Sister of Ron and girlfriend of Harry |         0 |
+----+-----------+----------+------------+-------------+---------------------------------------+-----------+
5 rows in set (0.00 sec)

-- Pagination : 5 sorciers après les 20 premiers
mysql> SELECT * FROM wizard LIMIT 5 OFFSET 20;
Empty set (0.00 sec)

mysql> SELECT * FROM wizard;
+----+-----------+------------+------------+-------------+-------------------------------------------------------------+-----------+
| id | firstname | lastname   | birthday   | birth_place | biography                                                   | is_muggle |
+----+-----------+------------+------------+-------------+-------------------------------------------------------------+-----------+
|  1 | harry     | potter     | 1980-07-31 | london      |                                                             |         0 |
|  2 | hermione  | granger    | 1979-09-19 |             | Friend of Harry Potter                                      |         0 |
|  3 | lily      | potter     | 1960-01-30 |             | mother of Harry Potter                                      |         0 |
|  4 | ron       | weasley    | 1980-03-01 |             | Best friend of Harry                                        |         0 |
|  5 | ginny     | weasley    | 1981-08-11 |             | Sister of Ron and girlfriend of Harry                       |         0 |
|  6 | fred      | weasley    | 1978-04-01 |             |                                                             |         0 |
|  7 | george    | weasley    | 1978-04-01 |             |                                                             |         0 |
|  8 | arthur    | weasley    | 1950-02-06 |             |                                                             |         0 |
|  9 | molly     | weasley    | 1949-01-01 |             |                                                             |         0 |
| 10 | drago     | malefoy    | 1980-06-05 |             |                                                             |         0 |
| 11 | albus     | dumbledore | 1881-07-01 |             |                                                             |         0 |
| 12 | severus   | rogue      | 1960-01-09 |             |                                                             |         0 |
| 13 | tom       | jédusor    | 1926-12-31 |             | Celui-Dont-On-Ne-Doit-Pas-Prononcer-Le-Nom alias Voldermort |         0 |
| 14 | dudley    | dursley    | 1980-06-23 |             | Cousin d'Harry                                              |         1 |
+----+-----------+------------+------------+-------------+-------------------------------------------------------------+-----------+
14 rows in set (0.00 sec)

mysql> SELECT * FROM wizard LIMIT 5 OFFSET 20;
Empty set (0.00 sec)

-- Tri par nom croissant puis date de naissance décroissante
mysql> SELECT firstname, lastname FROM wizard ORDER BY lastname ASC, birthday DESC;
+-----------+------------+
| firstname | lastname   |
+-----------+------------+
| albus     | dumbledore |
| dudley    | dursley    |
| hermione  | granger    |
| tom       | jédusor    |
| drago     | malefoy    |
| harry     | potter     |
| lily      | potter     |
| severus   | rogue      |
| ginny     | weasley    |
| ron       | weasley    |
| fred      | weasley    |
| george    | weasley    |
| arthur    | weasley    |
| molly     | weasley    |
+-----------+------------+
14 rows in set (0.00 sec)

-- Les 3 Weasley les plus jeunes
mysql> SELECT * FROM wizard WHERE lastname='Weasley' ORDER BY birthday DESC LIMIT 0,3;
+----+-----------+----------+------------+-------------+---------------------------------------+-----------+
| id | firstname | lastname | birthday   | birth_place | biography                             | is_muggle |
+----+-----------+----------+------------+-------------+---------------------------------------+-----------+
|  5 | ginny     | weasley  | 1981-08-11 |             | Sister of Ron and girlfriend of Harry |         0 |
|  4 | ron       | weasley  | 1980-03-01 |             | Best friend of Harry                  |         0 |
|  6 | fred      | weasley  | 1978-04-01 |             |                                       |         0 |
+----+-----------+----------+------------+-------------+---------------------------------------+-----------+
3 rows in set (0.00 sec)

-- -----------------------------------------------------
-- Requêtes du challenge
-- -----------------------------------------------------

-- Étape 1 / 4 : Tous les champs des sorciers nés entre 1975 et 1985
mysql> SELECT * FROM wizard WHERE birthday BETWEEN '1975-01-01' AND '1985-12-31';
+----+-----------+----------+------------+-------------+---------------------------------------+-----------+
| id | firstname | lastname | birthday   | birth_place | biography                             | is_muggle |
+----+-----------+----------+------------+-------------+---------------------------------------+-----------+
|  1 | harry     | potter   | 1980-07-31 | london      |                                       |         0 |
|  2 | hermione  | granger  | 1979-09-19 |             | Friend of Harry Potter                |         0 |
|  4 | ron       | weasley  | 1980-03-01 |             | Best friend of Harry                  |         0 |
|  5 | ginny     | weasley  | 1981-08-11 |             | Sister of Ron and girlfriend of Harry |         0 |
|  6 | fred      | weasley  | 1978-04-01 |             |                                       |         0 |
|  7 | george    | weasley  | 1978-04-01 |             |                                       |         0 |
| 10 | drago     | malefoy  | 1980-06-05 |             |                                       |         0 |
| 14 | dudley    | dursley  | 1980-06-23 |             | Cousin d'Harry                        |         1 |
+----+-----------+----------+------------+-------------+---------------------------------------+-----------+
8 rows in set (0.00 sec)

-- Étape 2 / 4 : Prénom des sorciers dont le prénom commence par H
mysql> SELECT firstname FROM wizard WHERE 'H%';
Empty set, 1 warning (0.02 sec)

mysql> SELECT firstname FROM wizard WHERE firstname 'H%';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ''H%'' at line 1
mysql> SELECT firstname FROM wizard WHERE firstname LIKE 'H%';
+-----------+
| firstname |
+-----------+
| harry     |
| hermione  |
+-----------+
2 rows in set (0.00 sec)

-- Étape 3 / 4 : Prénoms et noms de la famille Potter, triés par prénom
mysql> SELECT firstname, lastname FROM wizard WHERE lastname = 'potter' ORDER BY firstname ASC;
+-----------+----------+
| firstname | lastname |
+-----------+----------+
| harry     | potter   |
| lily      | potter   |
+-----------+----------+
2 rows in set (0.00 sec)

-- Étape 4 / 4 : Prénom, nom et date de naissance du plus vieux sorcier
mysql> SELECT firstname, lastname, birthday FROM wizard ORDER BY birthday DESC;
+-----------+------------+------------+
| firstname | lastname   | birthday   |
+-----------+------------+------------+
| ginny     | weasley    | 1981-08-11 |
| harry     | potter     | 1980-07-31 |
| dudley    | dursley    | 1980-06-23 |
| drago     | malefoy    | 1980-06-05 |
| ron       | weasley    | 1980-03-01 |
| hermione  | granger    | 1979-09-19 |
| fred      | weasley    | 1978-04-01 |
| george    | weasley    | 1978-04-01 |
| lily      | potter     | 1960-01-30 |
| severus   | rogue      | 1960-01-09 |
| arthur    | weasley    | 1950-02-06 |
| molly     | weasley    | 1949-01-01 |
| tom       | jédusor    | 1926-12-31 |
| albus     | dumbledore | 1881-07-01 |
+-----------+------------+------------+
14 rows in set (0.00 sec)

mysql> SELECT firstname, lastname, birthday FROM wizard ORDER BY birthday ASC LIMIT 0,1;
+-----------+------------+------------+
| firstname | lastname   | birthday   |
+-----------+------------+------------+
| albus     | dumbledore | 1881-07-01 |
+-----------+------------+------------+
1 row in set (0.00 sec)

-- =====================================================
-- CHALLENGE 3 : INSERT, UPDATE et DELETE sur school
-- =====================================================

-- -----------------------------------------------------
-- Entraînement (exemples du cours)
-- -----------------------------------------------------

-- Insertion d'une école
mysql> INSERT INTO school
    ->   (name, country, capacity)
    -> VALUES
    ->   ('Hogwarts School of Witchcraft and Wizardry', 'United Kingdom', 400);
Query OK, 1 row affected (0.02 sec)

-- Insertion de plusieurs écoles
mysql> INSERT INTO school
    ->   (name, country, capacity)
    -> VALUES
    ->   ('Beauxbatons Academy of Magic', 'France', 550),
    ->   ('Castelobruxo', 'Brazil', 380),
    ->   ('Durmstrang Institute', 'Norway', 570);
Query OK, 3 rows affected (0.05 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM school;
+----+--------------------------------------------+----------+----------------+
| id | name                                       | capacity | country        |
+----+--------------------------------------------+----------+----------------+
|  1 | Hogwarts School of Witchcraft and Wizardry |      400 | United Kingdom |
|  2 | Beauxbatons Academy of Magic               |      550 | France         |
|  3 | Castelobruxo                               |      380 | Brazil         |
|  4 | Durmstrang Institute                       |      570 | Norway         |
+----+--------------------------------------------+----------+----------------+
4 rows in set (0.00 sec)

-- Modification de la capacité de Hogwarts
mysql> UPDATE school
    -> SET capacity = 450
    -> WHERE id = 1;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM school;
+----+--------------------------------------------+----------+----------------+
| id | name                                       | capacity | country        |
+----+--------------------------------------------+----------+----------------+
|  1 | Hogwarts School of Witchcraft and Wizardry |      450 | United Kingdom |
|  2 | Beauxbatons Academy of Magic               |      550 | France         |
|  3 | Castelobruxo                               |      380 | Brazil         |
|  4 | Durmstrang Institute                       |      570 | Norway         |
+----+--------------------------------------------+----------+----------------+
4 rows in set (0.00 sec)

-- Suppression d'une école par son id
mysql> DELETE FROM school
    -> WHERE id = 3;
Query OK, 1 row affected (0.00 sec)

mysql> SELECT * FROM school;
+----+--------------------------------------------+----------+----------------+
| id | name                                       | capacity | country        |
+----+--------------------------------------------+----------+----------------+
|  1 | Hogwarts School of Witchcraft and Wizardry |      450 | United Kingdom |
|  2 | Beauxbatons Academy of Magic               |      550 | France         |
|  4 | Durmstrang Institute                       |      570 | Norway         |
+----+--------------------------------------------+----------+----------------+
3 rows in set (0.00 sec)

-- Suppression des écoles de plus de 500 places
mysql> DELETE FROM school
    -> WHERE capacity > 500;
Query OK, 2 rows affected (0.00 sec)

-- Vider complètement la table
mysql> TRUNCAT school
    -> c^C
mysql> TRUNCAT school;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'TRUNCAT school' at line 1
mysql> TRUNCATE school;
Query OK, 0 rows affected (0.10 sec)

-- -----------------------------------------------------
-- Requêtes du challenge
-- -----------------------------------------------------

-- Étape 1 / 4 : Insérer les 8 écoles
mysql> INSERT INTO school (name, country, capacity)
    -> VALUES
    -> ('Beauxbatons Academy of Magic', 'France', '550'),
    -> ('Castelobruxo', 'Brazil', '380'),
    -> ('Durmstrang Institute', 'Norway', 570),('Hogwarts School of Witchcraft and Wizardry', 'United Kingdom', 450),('Ilvermorny School of Witchcraft and Wizardry', 'USA', 300),('Koldovstoretz', 'Russia', 125),('Mahoutokoro School of Magic', 'Japan', 800),('Uagadou School of Magic', 'Uganda', 350);
Query OK, 8 rows affected (0.00 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> UPDATE school
    -> ^C
mysql> SELECT * FROM schol
    -> ^C
mysql> SELECT * FROM school;
+----+----------------------------------------------+----------+----------------+
| id | name                                         | capacity | country        |
+----+----------------------------------------------+----------+----------------+
|  1 | Beauxbatons Academy of Magic                 |      550 | France         |
|  2 | Castelobruxo                                 |      380 | Brazil         |
|  3 | Durmstrang Institute                         |      570 | Norway         |
|  4 | Hogwarts School of Witchcraft and Wizardry   |      450 | United Kingdom |
|  5 | Ilvermorny School of Witchcraft and Wizardry |      300 | USA            |
|  6 | Koldovstoretz                                |      125 | Russia         |
|  7 | Mahoutokoro School of Magic                  |      800 | Japan          |
|  8 | Uagadou School of Magic                      |      350 | Uganda         |
+----+----------------------------------------------+----------+----------------+
8 rows in set (0.00 sec)

-- Étape 2 / 4 : Passer la capacité de Koldovstoretz à 150
mysql> UPDATE school
    -> SET capacity = 150
    -> WHERE id = 6;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

-- Étape 3 / 4 : Modifier le pays de Durmstrang Institute (Sweden)
mysql> UPDATE school
    -> SET name country = Sweden
    -> WHERE id = 3;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'country = Sweden
WHERE id = 3' at line 2
mysql> UPDATE school
    -> SET country = Sweden
    -> WHERE id = 3;
ERROR 1054 (42S22): Unknown column 'Sweden' in 'field list'
mysql> UPDATE school
    -> SET country = 'Sweden'
    -> WHERE id = 3;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

-- Étape 4 / 4 : Supprimer les écoles contenant "Magic" dans leur nom
mysql> DELETE FROM school
    -> WHERE name LIKE '%Magic%';
Query OK, 3 rows affected (0.00 sec)

mysql> SELECT * FROM school;
+----+----------------------------------------------+----------+----------------+
| id | name                                         | capacity | country        |
+----+----------------------------------------------+----------+----------------+
|  2 | Castelobruxo                                 |      380 | Brazil         |
|  3 | Durmstrang Institute                         |      570 | Sweden         |
|  4 | Hogwarts School of Witchcraft and Wizardry   |      450 | United Kingdom |
|  5 | Ilvermorny School of Witchcraft and Wizardry |      300 | USA            |
|  6 | Koldovstoretz                                |      150 | Russia         |
+----+----------------------------------------------+----------+----------------+
5 rows in set (0.00 sec)

-- =====================================================
-- CHALLENGE 4 : MCD potions / ingrédients
-- =====================================================

-- Voir le schéma MCD (image exportée depuis Excalidraw).
-- Entités : Potion (id, name) et Ingredient (id, name)
-- Association : Contient
-- Cardinalités : Potion 1,N / Ingredient 0,N