#!/bin/bash

# Variables à configurer
echo "Entrez le nom de la base de données:"
read DB_NAME
echo "Entrez le nom d'utilisateur de la base de données:"
read DB_USER
echo "Entrez le mot de passe de la base de données:"
read DB_PASSWORD
echo "Entrez l'hôte de la base de données:"
read DB_HOST
echo "Entrez l'URL du site:"
read SITE_URL
echo "Entrez le titre du site:"
read SITE_TITLE
echo "Entrez le nom d'utilisateur de l'administrateur:"
read ADMIN_USER
echo "Entrez le mot de passe de l'administrateur:"
read ADMIN_PASSWORD
echo "Entrez l'email de l'administrateur:"
read ADMIN_EMAIL

# Répertoire où WordPress sera installé
WP_DIR="/Applications/MAMP/htdocs/wordpress"

# Créer une db mysql
mysql -u root -proot -e "CREATE DATABASE IF NOT EXISTS $DB_NAME"

# Vérifier et installer wget si nécessaire
if ! command -v wget &> /dev/null; then
    echo "wget non trouvé, installation avec Homebrew..."
    brew install wget
fi

# Télécharger la dernière version de WordPress
wget https://wordpress.org/latest.tar.gz

# Extraire WordPress
tar -xzf latest.tar.gz

# Déplacer WordPress dans le répertoire souhaité
mv wordpress "$WP_DIR"

# Supprimer le fichier tar.gz téléchargé
rm latest.tar.gz

# Changer de répertoire pour le répertoire WordPress
cd "$WP_DIR"

# Créer le fichier wp-config.php à partir de wp-config-sample.php
cp wp-config-sample.php wp-config.php

# Configurer le fichier wp-config.php avec les informations de la base de données
sed -i '' "s/database_name_here/$DB_NAME/" wp-config.php
sed -i '' "s/username_here/$DB_USER/" wp-config.php
sed -i '' "s/password_here/$DB_PASSWORD/" wp-config.php
sed -i '' "s/localhost/$DB_HOST/" wp-config.php

# Définir les clés de sécurité
SECURITY_KEYS=$(wget -q -O - https://api.wordpress.org/secret-key/1.1/salt/)
sed -i '' "/AUTH_KEY/d" wp-config.php
sed -i '' "/SECURE_AUTH_KEY/d" wp-config.php
sed -i '' "/LOGGED_IN_KEY/d" wp-config.php
sed -i '' "/NONCE_KEY/d" wp-config.php
sed -i '' "/AUTH_SALT/d" wp-config.php
sed -i '' "/SECURE_AUTH_SALT/d" wp-config.php
sed -i '' "/LOGGED_IN_SALT/d" wp-config.php
sed -i '' "/NONCE_SALT/d" wp-config.php
echo "$SECURITY_KEYS" >> wp-config.php

# Installer WP-CLI (outil en ligne de commande pour WordPress)
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# Installer WordPress via WP-CLI
wp core install --url="$SITE_URL" --title="$SITE_TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_EMAIL"

# Changer la langue de WordPress en français
wp language core install fr_FR
wp site switch-language fr_FR

echo "------------------------------------"
echo "La langue a été changée avec succès."
echo "------------------------------------"

# Modifier la structure des permaliens
wp rewrite structure "/%postname%/"

echo "--------------------------------------------"
echo "Les permaliens ont été modifiés avec succès."
echo "--------------------------------------------"

# Créer des pages
wp post create --post_type=page --post_title='Accueil' --post_status=publish
wp post create --post_type=page --post_title='Blog' --post_status=publish

echo "-------------------------------------"
echo "Les pages ont été créées avec succès."
echo "-------------------------------------"

# Définir les pages d'accueil et de blog
wp option update show_on_front page
wp option update page_on_front 5
wp option update page_for_posts 6

echo "---------------------------------------"
echo "Les pages ont été définies avec succès."
echo "---------------------------------------"

# Créer un menu et ajouter des éléments de menu
wp menu create "Menu principal"
wp menu location assign menu-principal primary
wp menu item add-post menu-principal 5 --title="Accueil"
wp menu item add-post menu-principal 6 --title="Blog"

echo "-------------------------------"
echo "Le menu a été créé avec succès."
echo "-------------------------------"

wp plugin delete akismet
wp plugin delete hello

echo "----------------------------------------"
echo "Les thèmes et plugins par défaut ont été supprimés."
echo "----------------------------------------"

wp theme install generatepress
wp scaffold child-theme generatepress-child --parent_theme=generatepress --theme_name="GeneratePress Child"
wp theme activate generatepress-child

themes=$(wp theme list --status=inactive --field=name | grep -E 'twenty')
for theme in $themes; do
    wp theme delete $theme
done

echo "----------------------------------------------"
echo "Le thème a été installé et activé avec succès."
echo "----------------------------------------------"

# Liste des plugins à installer
plugins=(
    elementor
    seo-by-rank-math
    all-in-one-wp-security-and-firewall
    google-site-kit
    wp-fastest-cache
    duplicator
    forminator
    formidable
)

# Installer et activer chaque plugin
for plugin in "${plugins[@]}"; do
    wp plugin install "$plugin" --activate
    wp plugin update --all
done

wp plugin auto-updates disable --all
wp theme auto-updates disable --all
wp option update auto_update_core_major disabled
wp option update auto_update_core_minor disabled
wp option update auto_update_core_translation enabled


echo "--------------------------------------------------"
echo "Installation de WordPress et des plugins terminée."
echo "--------------------------------------------------"
