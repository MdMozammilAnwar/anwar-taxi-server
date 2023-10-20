CREATE TYPE GetUserDetailsType AS (
    user_id INTEGER,
    fk_role_id INTEGER,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    password_hash VARCHAR(60),
    mobile VARCHAR(15),
    address TEXT,
    created_on TIMESTAMP WITHOUT TIME ZONE,
    created_by INTEGER,
    modified_on TIMESTAMP WITHOUT TIME ZONE,
    modified_by INTEGER,
    status INTEGER
);
