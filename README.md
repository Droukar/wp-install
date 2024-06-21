# Script d'installation de WordPress

Ce script bash automatise l'installation de WordPress sur votre machine locale. Il configure également WordPress avec les informations de base de données fournies, installe et active un ensemble de plugins, et effectue d'autres configurations initiales.

## Prérequis

- MySQL
- wget
- Homebrew (pour les utilisateurs de Mac)
- WP-CLI

## Utilisation

1. Ouvrez un terminal.
2. Naviguez vers le répertoire contenant le script `wp_install.sh`.
3. Rendez le script exécutable avec la commande suivante :
    ```bash
    chmod +x wp_install.sh
    ```
4. Exécutez le script avec la commande suivante :
    ```bash
    ./wp_install.sh
    ```
5. Le script vous demandera d'entrer les informations suivantes :
    - Nom de la base de données
    - Nom d'utilisateur de la base de données
    - Mot de passe de la base de données
    - Hôte de la base de données
    - URL du site
    - Titre du site
    - Nom d'utilisateur de l'administrateur
    - Mot de passe de l'administrateur
    - Email de l'administrateur

## Ce que fait le script

1. Crée une base de données MySQL.
2. Télécharge la dernière version de WordPress.
3. Extrait WordPress et le déplace dans le répertoire souhaité.
4. Crée et configure le fichier `wp-config.php`.
5. Installe WP-CLI.
6. Installe WordPress via WP-CLI.
7. Change la langue de WordPress en français.
8. Modifie la structure des permaliens.
9. Crée des pages.
10. Définit les pages d'accueil et de blog.
11. Crée un menu et ajoute des éléments de menu.
12. Supprime les thèmes et plugins par défaut.
13. Installe et active le thème GeneratePress et son thème enfant.
14. Installe et active un ensemble de plugins.
15. Désactive les mises à jour automatiques pour les thèmes et plugins.

## Note

Ce script est destiné à être utilisé sur une machine locale pour le développement. Ne l'utilisez pas dans un environnement de production.
