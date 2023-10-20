CREATE OR REPLACE FUNCTION UserRegistration(
    fk_role_id INTEGER,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    password_hash VARCHAR,
    mobile VARCHAR,
    address TEXT
)
RETURNS INTEGER AS $BODY$
DECLARE
    new_user_id INTEGER;
BEGIN
    -- Check if fk_role_id is less than or equal to 0
    IF fk_role_id <= 0 THEN
        -- Return -1 and don't save anything
        RETURN -1;
    ELSE
        -- Insert the new record into the UserProfile table
        INSERT INTO public.UserProfile (fk_role_id, first_name, last_name, email, password_hash, mobile, address)
        VALUES (fk_role_id, first_name, last_name, email, password_hash, mobile, address)
        RETURNING pk_user_id INTO new_user_id;

        -- Return the pk_user_id of the newly inserted record
        RETURN new_user_id;
    END IF;
END;
$BODY$ 
LANGUAGE plpgsql;
