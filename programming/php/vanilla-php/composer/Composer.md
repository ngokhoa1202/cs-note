#php #dependency-manager  #cli #installation #ubuntu


# Generate class file
```Bash
composer dump-autoload -o
```

# Install composer
- First, uninstall all the composer-related files on Ubuntu
```Bash
sudo apt-get remove composer -y
```
- Use the cmd
```Bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"  
php composer-setup.php --install-dir=/usr/bin/ --filename=composer
```
- Can switch a specific version according to https://medium.com/techvblogs/update-composer-in-ubuntu-4138e36205eb
# References
1. https://getcomposer.org/ 
2. https://medium.com/techvblogs/update-composer-in-ubuntu-4138e36205eb for switching Composer version.
