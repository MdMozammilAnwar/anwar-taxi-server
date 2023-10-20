CREATE OR REPLACE FUNCTION GetUserDetail(user_id_arg INTEGER)
RETURNS SETOF GetUserDetailsType AS $BODY$
DECLARE 
BEGIN
    RETURN QUERY
    SELECT
        u.pk_user_id,
        u.fk_role_id,
        u.first_name,
        u.last_name,
        u.email,
        u.password_hash,
        u.mobile,
        u.address,
        u.created_on,
        u.created_by,
        u.modified_on,
        u.modified_by,
        u.status
    FROM
        public.UserProfile u
    WHERE
        u.pk_user_id = user_id_arg;
END;
$BODY$
LANGUAGE plpgsql;
