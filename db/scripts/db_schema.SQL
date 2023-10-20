-- CREATE ROLE TABLE
CREATE TABLE public.Role (
    pk_role_id serial PRIMARY KEY,
    role_name VARCHAR(255) NOT NULL
);

-- Insert Data into Role Table
INSERT INTO public.Role (role_name) VALUES ('customer'), ('driver');

-- CREATE USERPROFILE SEQUENCE
CREATE SEQUENCE public.UserProfile_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

-- CREATE USERPROFILE TABLE, WHERE WE WILL KEEP ALL USER INFORMATION
CREATE TABLE public.UserProfile (
    pk_user_id INTEGER DEFAULT nextval('public.userprofile_id_seq') PRIMARY KEY,
    fk_role_id INTEGER NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(60) NOT NULL,  -- Store the hashed password
    mobile VARCHAR(15),
    address TEXT,
    created_on timestamp without time zone DEFAULT NOW(),
    created_by INTEGER,
    modified_on timestamp without time zone,
    modified_by INTEGER,
    status INTEGER DEFAULT 1
);

-- ADD FOREIGN KEY CONSTRAINT
ALTER TABLE public.UserProfile
ADD CONSTRAINT fk_userprofile_role
FOREIGN KEY (fk_role_id)
REFERENCES Role (pk_role_id);

-- Create Ride Table
CREATE TABLE public.Ride (
    pk_ride_id SERIAL PRIMARY KEY,
    fk_user_id INTEGER,
    fk_driver_id INTEGER,
    from_destination VARCHAR(255) ,
    to_destination VARCHAR(255) ,
    ride_time_by_customer TIMESTAMP WITHOUT TIME ZONE ,
    ride_time_by_driver TIMESTAMP WITHOUT TIME ZONE ,
    ride_start_time TIMESTAMP WITHOUT TIME ZONE,
    ride_fare DECIMAL(10, 2) , -- Using DECIMAL for precise currency values
    ride_status INTEGER ,      -- You can use an ENUM for status
    created_by INTEGER ,
    created_on TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    modified_by INTEGER,
    modified_on TIMESTAMP WITHOUT TIME ZONE,
    payment_mode VARCHAR
);

-- Add Foreign Key Constraint for User
ALTER TABLE public.Ride
ADD CONSTRAINT fk_ride_user
FOREIGN KEY (fk_user_id)
REFERENCES public.UserProfile (pk_user_id);

-- Add Foreign Key Constraint for Driver
ALTER TABLE public.Ride
ADD CONSTRAINT fk_ride_driver
FOREIGN KEY (fk_driver_id)
REFERENCES public.UserProfile (pk_user_id);
