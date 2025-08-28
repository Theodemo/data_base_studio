# 🎬 Base de Données Relationnelle – Studio Mappa

Projet réalisé dans le cadre du **semestre S3 - Informatique (Bases de données relationnelles) à l’ENIB**.
Objectif : concevoir et implémenter une base de données permettant d’**analyser les paramètres qui influencent le succès des saisons d’animés** produits par un studio.

## 👥 Auteurs

* **Théo de Morais**
* **Yann Weber Segarra**

---

## 📌 Cahier des charges

Le studio Mappa souhaite un système d’information permettant de gérer :

* Les **studios** (nom, capital, saisons produites)
* Les **animés** (titre, genre, score moyen, nombre de saisons)
* Les **saisons** (titre, score, visionnages, date de diffusion, nombre d’épisodes, personnel, personnages)
* Les **personnes** (nom, prénom, date de naissance)
* Le **personnel** (rôle, lien avec une personne et une saison)
* Les **personnages** (nom, rôle, doubleur associé)

---

## 🏗️ Conception

### 1. Identification des entités & associations

* Un **animé** est composé de plusieurs saisons
* Une **saison** est réalisée par un ou plusieurs studios
* Une **saison** fait intervenir du personnel et des personnages
* Un **personnage** est doublé par un membre du personnel

### 2. Modélisation UML

Plusieurs versions successives ont permis de définir :

* Les entités et attributs
* Les cardinalités
* Les tables associatives (gestion des relations N-N)

---

## 🗄️ Structure SQL

### Tables principales

* **Studio** (id, nom, capital, #saison\_id)
* **Animé** (id, titre, nombre\_saisons, genre, score\_moyen)
* **Saison** (id, titre, score, nb\_visionnages, date\_diffusion, nb\_episodes, #anime\_id)
* **Personne** (id, nom, prénom, date\_naissance)
* **Personnel** (id, rôle, #personne\_id, #saison\_id)
* **Personnage** (id, nom, rôle, #personnel\_id)

### Tables associatives

* **Participants** (#saison\_id, #personne\_id)
* **Production** (#studio\_id, #saison\_id)

👉 Les scripts SQL de création et d’insertion d’exemples sont disponibles dans le projet.

---

## 🔎 Cas d’usage

Exemples de requêtes sur la base de données :

1. Sélection des studios avec un capital entre 0 et 10 000 €
2. Liste des personnages de l’animé *Tokyo Revengers*
3. Liste des personnes ayant participé à une saison mais n’étant pas doubleurs
4. Comptage des saisons avec le moins de participants
5. Requêtes avec `JOIN`, `GROUP BY`, `HAVING`, etc.

---

## 🚀 Installation & Utilisation

1. Cloner le dépôt :

```bash
git clone https://github.com/username/projet-bdd-mappa.git
```

2. Importer le script SQL dans votre SGBD (MySQL, PostgreSQL ou SQLite) :

```sql
SOURCE create_tables.sql;
SOURCE insert_data.sql;
```

3. Exécuter les requêtes disponibles dans `queries.sql`.

---

## 📚 Technologies utilisées

* **UML** pour la modélisation
* **SQL** pour la structuration de la base de données
* **SGBD relationnel** (compatibilité MySQL/PostgreSQL/SQLite)

---

## 📄 Licence

Projet académique – ENIB – 2022.

