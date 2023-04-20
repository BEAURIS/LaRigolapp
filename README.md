# LaRigol App

## Overview
LaRigol App est une application de blagues qui vous permet de lire et de partager des blagues amusantes avec vos amis. Elle utilise l'API de sv443.net pour récupérer des blagues dans différentes catégories et en plusieurs langues.

## Features

### Page d'accueil
La page d'accueil affiche une blague aléatoire à chaque fois que l'utilisateur l'ouvre. L'utilisateur peut appuyer sur le bouton "Suivante" pour afficher une autre blague aléatoire.

### Fil d'actualité
Le fil d'actualité affiche toutes les blagues récupérées depuis l'API dans l'ordre chronologique. L'utilisateur peut faire défiler les blagues et les partager avec ses amis en appuyant sur le bouton "Partager".

### Favoris
La page des favoris affiche toutes les blagues que l'utilisateur a marquées comme favorites. L'utilisateur peut ajouter ou supprimer des blagues de ses favoris en appuyant sur l'icône en forme de coeur.

### Rechercher
La page de recherche permet à l'utilisateur de rechercher des blagues dans l'API en fonction de différents critères, tels que la catégorie, le type, le langage, etc. L'utilisateur peut saisir des mots-clés dans la barre de recherche et appuyer sur le bouton "Rechercher" pour afficher les blagues correspondantes.

### Profil
La page de profil affiche les informations de l'utilisateur, telles que son nom, son adresse e-mail et sa photo de profil. L'utilisateur peut se connecter ou se déconnecter de son compte en appuyant sur le bouton "Connexion/Déconnexion". Lorsqu'il est connecté, l'utilisateur peut également voir ses blagues favorites et les blagues qu'il a partagées avec ses amis.

## Technologies utilisées
- Flutter pour le développement mobile multiplateforme
- Provider pour la gestion d'état
- Firebase pour l'authentification des utilisateurs
- HTTP pour l'appel d'API
- TimeZone pour la gestion des fuseaux horaires
- Flutter Local Notifications pour la planification des notifications

## Installation et configuration
1. Cloner le dépôt git
git clone https://github.com/username/LaRigolApp.git

2. Ouvrir le projet dans l'éditeur de code
cd LaRigolApp
code .

3. Installer les dépendances
flutter pub get

4. Configurer Firebase pour l'authentification
- Créer un projet Firebase sur la console Firebase
- Ajouter une application Android ou iOS à votre projet
- Télécharger le fichier google-services.json (pour Android) ou GoogleService-Info.plist (pour iOS) et ajoutez-le à votre projet Flutter
- Activer l'authentification par e-mail et par téléphone dans la console Firebase
- Ajouter les fichiers `auth_service.dart` et `auth_provider.dart` au répertoire `lib`

5. Lancer l'application sur un émulateur ou un appareil connecté
flutter run


## Contributions
Les contributions sont les bienvenues ! Si vous souhaitez contribuer à LaRigol App, veuillez d'abord discuter de la modification que vous souhaitez apporter en créant une nouvelle issue.

## Licence
MIT


