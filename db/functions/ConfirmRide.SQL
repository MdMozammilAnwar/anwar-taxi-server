CREATE OR REPLACE FUNCTION ConfirmRide(in_user_id INTEGER, in_ride_id INTEGER, in_payment_mode VARCHAR)
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
DECLARE
    
BEGIN
    -- Check if in_user_id or in_ride_id is less than 0
    IF in_user_id < 0 OR in_ride_id < 0 THEN
        RETURN QUERY SELECT NULL;
    END IF;

    -- Update the Ride table
    UPDATE public.Ride r
    SET
        ride_status = 2,
        payment_mode = in_payment_mode,
        modified_by = in_user_id,
        modified_on = NOW()
    WHERE
        r.pk_ride_id = in_ride_id;
        
    -- Returning the data
    RETURN QUERY
    SELECT
        r.pk_ride_id,
        r.fk_driver_id,
        CONCAT(up.first_name,' ',up.last_name) AS driver_name,
        up.email AS driver_email,
        up.mobile AS driver_mobile,
        r.from_destination::VARCHAR(255),
        r.to_destination,
        r.ride_time_by_driver,
        r.ride_fare,
        r.ride_status
    FROM
        public.Ride r
        LEFT JOIN UserProfile up ON up.pk_user_id = r.fk_user_id
    WHERE
        r.fk_user_id = in_user_id
        AND r.ride_status = 2
        AND r.fk_driver_id IS NOT NULL
        AND r.ride_time_by_driver > NOW();
END;
$$ LANGUAGE plpgsql;
