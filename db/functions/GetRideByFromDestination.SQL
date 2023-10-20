CREATE OR REPLACE FUNCTION GetRideByFromDestination(in_from_destination VARCHAR)
RETURNS SETOF RideDetailsType AS $$
BEGIN
    RETURN QUERY
    SELECT
        r.pk_ride_id,
        r.fk_user_id,
        CONCAT(up.first_name,' ',up.last_name),
        up.email,
        up.mobile,
        r.from_destination,
        r.to_destination,
        r.ride_time_by_customer,
        r.ride_status,
        r.created_by,
        r.created_on
    FROM
        Ride r LEFT JOIN USERPROFILE up ON up.pk_user_id = r.fk_user_id
    WHERE
        r.from_destination = in_from_destination AND r.ride_status=0;
END;
$$ LANGUAGE plpgsql;
