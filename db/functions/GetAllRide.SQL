CREATE OR REPLACE FUNCTION GetAllRide(in_user_id INTEGER)
RETURNS TABLE (
    pk_ride_id INTEGER,
    fk_driver_id INTEGER,
    driver_name TEXT,
    driver_email VARCHAR,
    driver_mobile VARCHAR,
    from_destination VARCHAR(255),
    to_destination VARCHAR(255),
    ride_time_by_driver TIMESTAMP WITHOUT TIME ZONE,
    ride_fare DECIMAL(10, 2),
    ride_status INTEGER,
    fk_role_id INTEGER
) AS $$
BEGIN
    SELECT up.fk_role_id INTO fk_role_id
    FROM UserProfile up
    WHERE up.pk_user_id = in_user_id;

    IF fk_role_id = 1 THEN
        RETURN QUERY
        SELECT
            r.pk_ride_id,
            r.fk_driver_id,
            CONCAT(up.first_name,' ',up.last_name),
            up.email,
            up.mobile,
            r.from_destination::VARCHAR(255),
            r.to_destination,
            r.ride_time_by_driver,
            r.ride_fare,
            r.ride_status,
            up.fk_role_id
        FROM
            public.Ride r
        LEFT JOIN UserProfile up on up.pk_user_id = r.fk_driver_id 
        WHERE
            r.fk_user_id = in_user_id
            AND r.ride_status = 2
            AND r.fk_driver_id IS NOT NULL
            AND r.ride_time_by_driver > NOW()
            AND up.fk_role_id=2
            ;
    ELSIF fk_role_id = 2 THEN
        RETURN QUERY
        SELECT
            r.pk_ride_id,
            r.fk_driver_id,
            CONCAT(dp.first_name,' ',dp.last_name),
            dp.email,
            dp.mobile,
            r.from_destination::VARCHAR(255),
            r.to_destination,
            r.ride_time_by_driver,
            r.ride_fare,
            r.ride_status,
            dp.fk_role_id
        FROM
            public.Ride r
        LEFT JOIN UserProfile dp on dp.pk_user_id = r.fk_user_id
        WHERE
            r.fk_driver_id = in_user_id
            AND r.ride_status = 2
            AND r.ride_time_by_driver > NOW()
            AND dp.fk_role_id=1
            ;
    END IF;
END;
$$ LANGUAGE plpgsql;
