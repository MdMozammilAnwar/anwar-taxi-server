CREATE OR REPLACE FUNCTION UserLogin(
    in_email VARCHAR,
    in_password VARCHAR
)
RETURNS TABLE (
    pk_user_id INTEGER,
    full_name TEXT,
    role_id INTEGER,
    email VARCHAR,
    mobile VARCHAR,
    address TEXT
) AS $$
DECLARE
    
BEGIN
    -- Check if the provided email and password match a user in the UserProfile table
    SELECT up.pk_user_id, CONCAT(up.first_name, ' ', up.last_name), up.fk_role_id, up.email, up.mobile, up.address
    INTO pk_user_id , full_name, role_id, email, mobile, address
    FROM public.UserProfile up
    WHERE up.email = in_email AND up.password_hash = in_password AND up.status != 0;

    -- If a matching user is found, return their user_id; otherwise, return -1
    RETURN NEXT;
    RETURN;
END;
$$ LANGUAGE plpgsql;
