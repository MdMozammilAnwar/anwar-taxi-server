CREATE OR REPLACE FUNCTION RideRequest(
    fk_user_id INTEGER,
    from_destination VARCHAR,
    to_destination VARCHAR,
    ride_time_by_customer TIMESTAMP WITHOUT TIME ZONE
)
RETURNS INTEGER AS $$
DECLARE
    ride_id INTEGER;
BEGIN
    -- Insert a new ride request
    INSERT INTO public.Ride (
        fk_user_id,
        from_destination,
        to_destination,
        ride_time_by_customer,
        ride_status,
        created_by,
        created_on
    )
    VALUES (
        fk_user_id,
        from_destination,
        to_destination,
        ride_time_by_customer,
        0, -- ride_status:[0-Request State, 1- Accepted, 2-Completed]
        fk_user_id,
        NOW() -- created_on with the current timestamp
    )
    RETURNING pk_ride_id INTO ride_id;

    -- Return the pk_ride_id of the newly created ride
    RETURN ride_id;
END;
$$ LANGUAGE plpgsql;
