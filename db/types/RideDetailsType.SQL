CREATE TYPE RideDetailsType AS (
    pk_ride_id INTEGER,
    fk_user_id INTEGER,
    rider_name TEXT,
    rider_email VARCHAR,
    rider_mobile VARCHAR,
    from_destination VARCHAR,
    to_destination VARCHAR,
    ride_time_by_customer TIMESTAMP WITHOUT TIME ZONE,
    ride_status INTEGER,
    created_by INTEGER,
    created_on TIMESTAMP WITHOUT TIME ZONE
);
