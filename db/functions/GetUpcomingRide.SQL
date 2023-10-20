CREATE OR REPLACE FUNCTION GetUpcomingRide(in_user_id INTEGER)
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
    ride_status INTEGER
) AS $$
BEGIN
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
        r.ride_status
    FROM
        public.Ride r LEFT JOIN UserProfile up on up.pk_user_id=r.fk_user_id
    WHERE
        r.fk_user_id = in_user_id
        AND r.ride_status = 1
        AND r.fk_driver_id IS NOT NULL
        AND r.ride_time_by_driver > NOW();
END;
$$ LANGUAGE plpgsql;
