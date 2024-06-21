# WordPress Installation Script

This bash script automates the installation of WordPress on your local machine. It also configures WordPress with the provided database information, installs and activates a set of plugins, and performs other initial configurations.

## Prerequisites

- MySQL
- wget
- Homebrew (for Mac users)
- WP-CLI

## Usage

1. Open a terminal.
2. Navigate to the directory containing the `wp_install.sh` script.
3. Make the script executable with the following command:
    ```bash
    chmod +x wp_install.sh
    ```
4. Run the script with the following command:
    ```bash
    ./wp_install.sh
    ```
5. The script will prompt you to enter the following information:
    - Database name
    - Database username
    - Database password
    - Database host
    - Site URL
    - Site title
    - Admin username
    - Admin password
    - Admin email

## What the Script Does

1. Creates a MySQL database.
2. Downloads the latest version of WordPress.
3. Extracts WordPress and moves it to the desired directory.
4. Creates and configures the `wp-config.php` file.
5. Installs WP-CLI.
6. Installs WordPress via WP-CLI.
7. Changes the WordPress language to French.
8. Modifies the permalink structure.
9. Creates pages.
10. Sets the home and blog pages.
11. Creates a menu and adds menu items.
12. Deletes default themes and plugins.
13. Installs and activates the GeneratePress theme and its child theme.
14. Installs and activates a set of plugins.
15. Disables automatic updates for themes and plugins.

## Note

This script is intended for use on a local machine for development purposes. Do not use it in a production environment.
