#php #composer #dependency-manager #lifecycle #build-tools #continuous-delivery #continuous-integration 
# Introduction
## Composer Lifecycle Overview
- Composer executes ==series of events== during package installation and updates.
- Each event can trigger ==custom scripts== for automation.
- Lifecycle hooks enable ==build automation==, cache clearing, asset compilation, and deployment tasks.
## Lifecycle Stages
```
composer install/update
    ↓
pre-install-cmd / pre-update-cmd
    ↓
Dependency Resolution
    ↓
Package Download
    ↓
post-install-cmd / post-update-cmd
    ↓
Autoload Generation
    ↓
post-autoload-dump
```

***
# Lifecycle Events

## Installation Events
```
composer install
    ↓
1. pre-install-cmd          → Before any packages installed
    ↓
2. pre-dependencies-solving → Before dependency resolution
    ↓
3. post-dependencies-solving → After dependency resolution
    ↓
4. [Package Installation]    → Download and install packages
    ↓
5. post-install-cmd         → After all packages installed
    ↓
6. post-autoload-dump       → After autoloader generated
```

## Update Events
```
composer update
    ↓
1. pre-update-cmd           → Before any packages updated
    ↓
2. pre-dependencies-solving → Before dependency resolution
    ↓
3. post-dependencies-solving → After dependency resolution
    ↓
4. [Package Updates]        → Download and update packages
    ↓
5. post-update-cmd          → After all packages updated
    ↓
6. post-autoload-dump       → After autoloader generated
```

## Package-Level Events
```
pre-package-install    → Before individual package installed
post-package-install   → After individual package installed
pre-package-update     → Before individual package updated
post-package-update    → After individual package updated
pre-package-uninstall  → Before individual package removed
post-package-uninstall → After individual package removed
```

***
# Script Configuration

## Basic Scripts
```json
{
    "scripts": {
        "pre-install-cmd": "echo 'Starting installation...'",
        "post-install-cmd": "echo 'Installation complete!'",
        "pre-update-cmd": "echo 'Starting update...'",
        "post-update-cmd": "echo 'Update complete!'",
        "post-autoload-dump": "echo 'Autoloader generated'"
    }
}
```

## Multiple Commands per Event
```json
{
    "scripts": {
        "post-install-cmd": [
            "echo 'Clearing cache...'",
            "rm -rf var/cache/*",
            "echo 'Building assets...'",
            "npm run build",
            "echo 'Setup complete!'"
        ]
    }
}
```

## Referencing Other Scripts
```json
{
    "scripts": {
        "clear-cache": "rm -rf var/cache/*",
        "build-assets": "npm run build",
        "setup": [
            "@clear-cache",
            "@build-assets",
            "echo 'Setup complete!'"
        ],
        "post-install-cmd": [
            "@setup"
        ]
    }
}
```

# PHP Script Handlers
## Static Method Handler
```json
{
    "scripts": {
        "post-install-cmd": "App\\Scripts\\PostInstall::execute",
        "post-update-cmd": "App\\Scripts\\PostUpdate::execute"
    }
}
```

```php
<?php
// File: src/Scripts/PostInstall.php

namespace App\Scripts;

use Composer\Script\Event;
use Composer\Installer\PackageEvent;

class PostInstall
{
    public static function execute(Event $event): void
    {
        $io = $event->getIO();
        $composer = $event->getComposer();

        $io->write('<info>Running post-install tasks...</info>');

        // Clear cache
        self::clearCache($io);

        // Generate configuration
        self::generateConfig($io);

        // Set permissions
        self::setPermissions($io);

        $io->write('<info>Post-install completed!</info>');
    }

    private static function clearCache($io): void
    {
        $io->write('Clearing cache...');
        exec('rm -rf var/cache/*');
    }

    private static function generateConfig($io): void
    {
        $io->write('Generating configuration...');

        if (!file_exists('.env')) {
            copy('.env.example', '.env');
            $io->write('<comment>.env file created</comment>');
        }
    }

    private static function setPermissions($io): void
    {
        $io->write('Setting permissions...');
        exec('chmod -R 755 var/');
        exec('chmod -R 755 public/uploads/');
    }
}
```

## Event Object Methods
```php
<?php

namespace App\Scripts;

use Composer\Script\Event;

class CustomScript
{
    public static function run(Event $event): void
    {
        // Get IO interface for output
        $io = $event->getIO();

        // Get Composer instance
        $composer = $event->getComposer();

        // Get root package
        $package = $composer->getPackage();

        // Get package name
        $packageName = $package->getName();
        $io->write("Package: {$packageName}");

        // Get arguments passed to script
        $args = $event->getArguments();

        // Check if running in dev mode
        $devMode = $event->isDevMode();

        // Ask user for input
        $confirmed = $io->askConfirmation(
            'Do you want to continue? [y/n] ',
            false
        );

        if ($confirmed) {
            $io->write('<info>Continuing...</info>');
        } else {
            $io->write('<warning>Aborted</warning>');
            return;
        }

        // Write different message types
        $io->write('<error>Error message</error>');
        $io->write('<warning>Warning message</warning>');
        $io->write('<info>Info message</info>');
        $io->write('<comment>Comment message</comment>');
    }
}
```
# Framework Integration
## Laravel Lifecycle
```json
{
    "scripts": {
        "post-autoload-dump": [
            "Illuminate\\Foundation\\ComposerScripts::postAutoloadDump",
            "@php artisan package:discover --ansi"
        ],
        "post-update-cmd": [
            "@php artisan vendor:publish --tag=laravel-assets --ansi --force",
            "@php artisan view:cache",
            "@php artisan config:cache"
        ],
        "post-root-package-install": [
            "@php -r \"file_exists('.env') || copy('.env.example', '.env');\""
        ],
        "post-create-project-cmd": [
            "@php artisan key:generate --ansi",
            "@php artisan storage:link"
        ]
    }
}
```

## Symfony Lifecycle
```json
{
    "scripts": {
        "auto-scripts": {
            "cache:clear": "symfony-cmd",
            "assets:install %PUBLIC_DIR%": "symfony-cmd",
            "security:check": "script"
        },
        "post-install-cmd": [
            "@auto-scripts"
        ],
        "post-update-cmd": [
            "@auto-scripts"
        ]
    },
    "extra": {
        "symfony": {
            "allow-contrib": true,
            "require": "6.4.*"
        }
    }
}
```

## WordPress Lifecycle
```json
{
    "scripts": {
        "post-install-cmd": [
            "php -r \"copy('wp-config-sample.php', 'wp-config.php');\"",
            "@generate-salts"
        ],
        "generate-salts": "App\\Scripts\\GenerateWordPressSalts::execute",
        "post-update-cmd": [
            "@php artisan cache:clear"
        ]
    }
}
```

***
# Common Use Cases

## Cache Management
```json
{
    "scripts": {
        "clear-cache": [
            "rm -rf var/cache/*",
            "rm -rf var/log/*",
            "echo 'Cache cleared'"
        ],
        "post-install-cmd": [
            "@clear-cache"
        ],
        "post-update-cmd": [
            "@clear-cache"
        ]
    }
}
```

## Asset Compilation
```json
{
    "scripts": {
        "build-assets": [
            "npm install",
            "npm run production"
        ],
        "watch-assets": [
            "npm run watch"
        ],
        "post-install-cmd": [
            "@build-assets"
        ]
    }
}
```

## Database Migration
```json
{
    "scripts": {
        "migrate": "php artisan migrate",
        "migrate-fresh": "php artisan migrate:fresh --seed",
        "post-update-cmd": [
            "@migrate"
        ]
    }
}
```

## Code Quality Checks
```json
{
    "scripts": {
        "lint": "phpcs --standard=PSR12 src/",
        "fix": "phpcbf --standard=PSR12 src/",
        "test": "phpunit",
        "analyse": "phpstan analyse src/ --level=max",
        "quality": [
            "@lint",
            "@analyse",
            "@test"
        ],
        "pre-commit": [
            "@quality"
        ]
    }
}
```

## File Permissions
```json
{
    "scripts": {
        "set-permissions": [
            "chmod -R 755 storage/",
            "chmod -R 755 bootstrap/cache/",
            "chmod -R 755 public/uploads/"
        ],
        "post-install-cmd": [
            "@set-permissions"
        ]
    }
}
```

***
# CI/CD Integration

## GitHub Actions
```json
{
    "scripts": {
        "ci-install": [
            "composer install --no-dev --optimize-autoloader --no-interaction"
        ],
        "ci-test": [
            "vendor/bin/phpunit --coverage-clover coverage.xml"
        ],
        "ci-deploy": [
            "@ci-install",
            "@build-assets",
            "php artisan config:cache",
            "php artisan route:cache",
            "php artisan view:cache"
        ]
    }
}
```

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup PHP
        uses: shivammathur/setup-php@v2
        with:
          php-version: 8.2

      - name: Install dependencies
        run: composer ci-install

      - name: Run tests
        run: composer ci-test

      - name: Deploy
        run: composer ci-deploy
```

## GitLab CI
```json
{
    "scripts": {
        "gitlab-test": [
            "composer install",
            "vendor/bin/phpunit"
        ],
        "gitlab-deploy": [
            "composer install --no-dev -o",
            "php artisan migrate --force",
            "php artisan config:cache"
        ]
    }
}
```

```yaml
# .gitlab-ci.yml
stages:
  - test
  - deploy

test:
  stage: test
  script:
    - composer gitlab-test

deploy:
  stage: deploy
  script:
    - composer gitlab-deploy
  only:
    - main
```

***
# Advanced Patterns

## Conditional Execution
```php
<?php

namespace App\Scripts;

use Composer\Script\Event;

class ConditionalScript
{
    public static function execute(Event $event): void
    {
        $io = $event->getIO();
        $devMode = $event->isDevMode();

        if ($devMode) {
            $io->write('Running in development mode');
            self::developmentSetup($io);
        } else {
            $io->write('Running in production mode');
            self::productionSetup($io);
        }
    }

    private static function developmentSetup($io): void
    {
        exec('npm run dev');
        $io->write('Development assets compiled');
    }

    private static function productionSetup($io): void
    {
        exec('npm run production');
        exec('php artisan optimize');
        $io->write('Production optimization complete');
    }
}
```

## Environment-Based Scripts
```php
<?php

namespace App\Scripts;

use Composer\Script\Event;

class EnvironmentScript
{
    public static function execute(Event $event): void
    {
        $io = $event->getIO();

        // Load .env file
        if (file_exists(__DIR__ . '/../../.env')) {
            $env = parse_ini_file(__DIR__ . '/../../.env');
            $environment = $env['APP_ENV'] ?? 'production';
        } else {
            $environment = getenv('APP_ENV') ?: 'production';
        }

        $io->write("Environment: {$environment}");

        switch ($environment) {
            case 'local':
                self::localSetup($io);
                break;
            case 'staging':
                self::stagingSetup($io);
                break;
            case 'production':
                self::productionSetup($io);
                break;
        }
    }

    private static function localSetup($io): void
    {
        exec('php artisan migrate:fresh --seed');
        $io->write('Database seeded for local development');
    }

    private static function stagingSetup($io): void
    {
        exec('php artisan migrate --force');
        $io->write('Database migrated for staging');
    }

    private static function productionSetup($io): void
    {
        exec('php artisan migrate --force');
        exec('php artisan config:cache');
        exec('php artisan route:cache');
        exec('php artisan view:cache');
        $io->write('Production deployment complete');
    }
}
```

## Parallel Execution
```json
{
    "scripts": {
        "parallel-tasks": [
            "composer run-script task1 &",
            "composer run-script task2 &",
            "composer run-script task3 &",
            "wait"
        ],
        "task1": "echo 'Task 1 running'",
        "task2": "echo 'Task 2 running'",
        "task3": "echo 'Task 3 running'"
    }
}
```

***
# Error Handling

## Exit Codes
```php
<?php

namespace App\Scripts;

use Composer\Script\Event;

class ScriptWithErrorHandling
{
    public static function execute(Event $event): void
    {
        $io = $event->getIO();

        try {
            self::criticalTask($io);
        } catch (\Exception $e) {
            $io->writeError('<error>Error: ' . $e->getMessage() . '</error>');
            exit(1); // Non-zero exit code stops Composer
        }
    }

    private static function criticalTask($io): void
    {
        if (!file_exists('.env')) {
            throw new \RuntimeException('.env file not found');
        }

        $io->write('<info>Critical task completed</info>');
    }
}
```

## Continue on Failure
```json
{
    "scripts": {
        "test": "phpunit || true",
        "lint": "phpcs || true",
        "post-install-cmd": [
            "@test",
            "@lint",
            "echo 'Setup complete, check errors above'"
        ]
    }
}
```

***
# Performance Optimization

## Skip Scripts in CI
```bash
# Skip all scripts
composer install --no-scripts

# Skip specific events
composer install --no-autoloader

# Production install (skips dev dependencies and scripts)
composer install --no-dev --no-scripts
```

## Timeout Configuration
```json
{
    "config": {
        "process-timeout": 300
    },
    "scripts": {
        "long-running-task": {
            "timeout": 600,
            "script": "php artisan heavy:task"
        }
    }
}
```

## Script Descriptions
```json
{
    "scripts-descriptions": {
        "test": "Run PHPUnit tests",
        "lint": "Check code style with PHP_CodeSniffer",
        "fix": "Auto-fix code style issues",
        "deploy": "Deploy application to production"
    }
}
```

```bash
# List available scripts with descriptions
composer list
```

***
# Security Considerations

## Plugin Security
```json
{
    "config": {
        "allow-plugins": {
            "composer/installers": true,
            "phpstan/extension-installer": true,
            "pestphp/pest-plugin": true
        }
    }
}
```

## Prevent Dangerous Commands
```php
<?php

namespace App\Scripts;

use Composer\Script\Event;

class SafeScript
{
    private static array $dangerousCommands = [
        'rm -rf /',
        'format',
        'del /f /s /q'
    ];

    public static function execute(Event $event): void
    {
        $io = $event->getIO();
        $command = $event->getArguments()[0] ?? '';

        foreach (self::$dangerousCommands as $dangerous) {
            if (stripos($command, $dangerous) !== false) {
                $io->writeError('<error>Dangerous command blocked</error>');
                exit(1);
            }
        }

        exec($command);
    }
}
```

***
# Debugging

## Verbose Output
```bash
# Verbose mode
composer install -v

# Very verbose
composer install -vv

# Debug mode
composer install -vvv
```

## Script Debugging
```json
{
    "scripts": {
        "debug": [
            "echo '=== Environment Info ==='",
            "php -v",
            "composer --version",
            "echo '=== Running script ==='",
            "@actual-script",
            "echo '=== Script completed ==='"
        ],
        "actual-script": "php artisan custom:command"
    }
}
```

```php
<?php

namespace App\Scripts;

use Composer\Script\Event;

class DebugScript
{
    public static function execute(Event $event): void
    {
        $io = $event->getIO();

        $io->write('=== Debug Info ===');
        $io->write('PHP Version: ' . PHP_VERSION);
        $io->write('Dev Mode: ' . ($event->isDevMode() ? 'Yes' : 'No'));
        $io->write('Arguments: ' . json_encode($event->getArguments()));
        $io->write('Working Dir: ' . getcwd());
        $io->write('==================');
    }
}
```

***
# Best Practices

## Script Organization
```
project/
├── composer.json
└── scripts/
    ├── PostInstall.php
    ├── PostUpdate.php
    ├── BuildAssets.php
    └── SetPermissions.php
```

```json
{
    "autoload": {
        "psr-4": {
            "App\\Scripts\\": "scripts/"
        }
    },
    "scripts": {
        "post-install-cmd": "App\\Scripts\\PostInstall::execute",
        "post-update-cmd": "App\\Scripts\\PostUpdate::execute"
    }
}
```

## Idempotent Scripts
```php
<?php
// Scripts should be safe to run multiple times

namespace App\Scripts;

use Composer\Script\Event;

class IdempotentScript
{
    public static function execute(Event $event): void
    {
        $io = $event->getIO();

        // Check before creating
        if (!file_exists('.env')) {
            copy('.env.example', '.env');
            $io->write('.env created');
        } else {
            $io->write('.env already exists, skipping');
        }

        // Safe to run multiple times
        exec('chmod -R 755 storage/');
        $io->write('Permissions set');
    }
}
```

## Documentation
```json
{
    "scripts": {
        "post-install-cmd": "App\\Scripts\\PostInstall::execute"
    },
    "scripts-descriptions": {
        "post-install-cmd": "Runs after composer install: clears cache, builds assets, sets permissions"
    }
}
```

***
# References
1. https://getcomposer.org/doc/articles/scripts.md for official scripts documentation
2. https://getcomposer.org/doc/04-schema.md#scripts for composer.json schema
3. https://getcomposer.org/doc/03-cli.md for CLI command reference
4. https://blog.madewithlove.com/post/composer-scripts-are-not-meant-for-everyone/ for script best practices
5.
