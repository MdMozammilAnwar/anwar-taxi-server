CREATE TYPE UpcomingRide AS (
    pk_ride_id INTEGER,
    fk_driver_id INTEGER,
    from_destination VARCHAR(255) ,
    to_destination VARCHAR(255),
    ride_time_by_driver TIMESTAMP WITHOUT TIME ZONE,
    ride_fare DECIMAL(10, 2),
    ride_status INTEGER
);
