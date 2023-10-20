CREATE TYPE UserRegistrationType AS (
    fk_role_id INTEGER,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    password_hash VARCHAR(60),
    mobile VARCHAR(15),
    address TEXT
);
