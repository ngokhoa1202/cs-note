#sequelize
# Error Hierarchy in Sequelize

1. `Error` (Native JavaScript error)
    - `BaseError` (Sequelize base error class)
        - `DatabaseError` (Thrown for SQL-related errors)
            - `SequelizeConnectionError` (Issues with database connection)
                - `SequelizeConnectionRefusedError`
                - `SequelizeConnectionTimedOutError`
                - `SequelizeHostNotFoundError`
                - `SequelizeHostNotReachableError`
                - `SequelizeInvalidConnectionError`
            - `SequelizeForeignKeyConstraintError` (Foreign key violations)
            - `SequelizeUniqueConstraintError` (Unique constraint violation)
            - `SequelizeExclusionConstraintError`
            - `SequelizeConstraintError` (General constraint violations)
        - `ValidationError` (Model validation failures)
            - `ValidationErrorItem`
        - `OptimisticLockError` (Occurs in versioned tables)
        - `AccessDeniedError` (When access to the database is denied)
        - `TimeoutError` (Query execution timeout).

# References
1. https://sequelize.org/api/v6/identifiers#errors