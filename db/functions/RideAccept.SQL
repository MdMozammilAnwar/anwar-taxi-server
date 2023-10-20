CREATE OR REPLACE FUNCTION RideAccept(
    in_user_id INTEGER,
    in_ride_id INTEGER,
    in_ride_time_by_driver TIMESTAMP WITHOUT TIME ZONE,
    in_ride_fare DECIMAL
) RETURNS INTEGER AS $$
DECLARE
    status INTEGER;
BEGIN
    -- Check if rideId is less than 0
    IF in_ride_id < 0 THEN
        RETURN -1;
    ELSE
        
        -- Insert fare and ride_start_time into the Ride table
        UPDATE public.Ride
        SET
            fk_driver_id = in_user_id,
            ride_time_by_driver = in_ride_time_by_driver,
            ride_fare = in_ride_fare,
            ride_status = 1,
            modified_by = in_user_id,
            modified_on = NOW()
        WHERE
            pk_ride_id = in_ride_id
        RETURNING ride_status INTO status;
        
        RETURN status;
    END IF;
END;
$$ LANGUAGE plpgsql;
