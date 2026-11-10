<h1 align="center">SQL Wizard</h1>

<p align="center">
  Quête d'initiation à SQL (MySQL) réalisée dans le cadre de la Wild Code School,<br>
  sur le thème de l'univers des sorciers.
</p>

---

## Sommaire

- [Contenu du dépôt](#contenu-du-dépôt)
- [Challenges réalisés](#challenges-réalisés)
- [Challenge 4 : MCD des potions](#challenge-4--mcd-des-potions)
  - [Le problème à modéliser](#le-problème-à-modéliser)
  - [Les entités](#les-entités)
  - [L'association](#lassociation)
  - [Les cardinalités](#les-cardinalités)
  - [Passage au MLD](#passage-au-mld)

---

## Contenu du dépôt

| Fichier | Description |
|:---|:---|
| `wild_db_quest.sql` | Les requêtes SQL de la quête |
| `mcd.png` | Le MCD du challenge sur les potions |

---

## Challenges réalisés

| # | Challenge | Notions abordées |
|:---:|:---|:---|
| 1 | Créer la base et les tables | `CREATE DATABASE`, `CREATE TABLE`, `ALTER TABLE` |
| 2 | Requêtes SELECT | `WHERE`, `LIKE`, `BETWEEN`, `ORDER BY`, `LIMIT`, `OFFSET` |
| 3 | INSERT, UPDATE et DELETE | `INSERT INTO`, `UPDATE`, `DELETE`, `TRUNCATE` |
| 4 | MCD | Entités, associations, cardinalités |

---

## Challenge 4 : MCD des potions

<p align="center">
  <img src="mcd.png" alt="MCD Potion - Ingredient" width="800">
</p>

### Le problème à modéliser

Chaque potion a un nom et utilise des ingrédients. Chaque ingrédient est lui aussi défini par son nom.
L'objectif est de stocker en base de données **quels ingrédients sont nécessaires pour chaque potion**.

### Les entités

**Potion**

| Attribut | Description |
|:---|:---|
| `id` | Identifiant de la potion |
| `name` | Nom de la potion |
| `description` | Ce que fait la potion |
| `color` | Couleur de la potion une fois prête (pas sûre de me garder) |
| `difficulty` | Niveau de difficulté de préparation |

**Ingredient**

| Attribut | Description |
|:---|:---|
| `id` | Identifiant de l'ingrédient |
| `name` | Nom de l'ingrédient |
| `origin` | Origine de l'ingrédient (animale, végétale, minérale…) |
| `rarity` | Rareté de l'ingrédient (commun, rare…) |

### L'association

Les deux entités sont reliées par l'association **Contient** : une potion *contient* des ingrédients.

### Les cardinalités

| Côté | Cardinalité | Lecture |
|:---|:---:|:---|
| Potion | **1,N** | Une potion contient au moins 1 ingrédient, et peut en contenir plusieurs |
| Ingredient | **0,N** | Un ingrédient peut n'être utilisé dans aucune potion, ou dans plusieurs |

> Le minimum est à **1** côté Potion, car une potion sans ingrédient n'a pas de sens.
> Il est à **0** côté Ingrédient, car on peut enregistrer un ingrédient avant de l'utiliser dans une recette.

### Passage au MLD

Comme les deux cardinalités maximales sont **N**, il s'agit d'une relation **plusieurs-à-plusieurs**.
Lors du passage au MLD, l'association `Contient` deviendra une **table de jointure** contenant deux clés étrangères :

- `potion_id`, qui référence la table `potion`
- `ingredient_id`, qui référence la table `ingredient`
