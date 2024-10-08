CREATE TABLE staging_car_Data (
    id BIGINT PRIMARY KEY,
    make VARCHAR(100),
    model VARCHAR(100),
    year INT,
    trim VARCHAR(100),
    trim_description TEXT,
    base_msrp Text,
    base_invoice VARCHAR(50),
    colors_exterior TEXT,
    colors_interior TEXT,
    body_type VARCHAR(50),
    doors INT,
    total_seating INT,
    length_in DECIMAL,
    width_in DECIMAL,
    height_in DECIMAL,
    wheelbase_in DECIMAL,
    front_track_in DECIMAL,
    rear_track_in DECIMAL,
    ground_clearance_in DECIMAL,
    angle_of_approach_degrees DECIMAL,
    angle_of_departure_degrees DECIMAL,
    turning_circle_ft DECIMAL,
    drag_coefficient DECIMAL,
    epa_interior_volume_cu_ft DECIMAL,
    cargo_capacity_cu_ft DECIMAL,
    max_cargo_capacity_cu_ft DECIMAL,
    curb_weight_lbs DECIMAL,
    gross_weight_lbs DECIMAL,
    max_payload_lbs DECIMAL,
    max_towing_capacity_lbs DECIMAL,
    cylinders VARCHAR(100),
    engine_size_l DECIMAL,
    horsepower_hp DECIMAL,
    horsepower_rpm INT,
    torque_ft_lbs DECIMAL,
    torque_rpm INT,
    valves INT,
    valve_timing VARCHAR(100),
    cam_type VARCHAR(50),
    drive_type VARCHAR(50),
    transmission VARCHAR(100),
    engine_type VARCHAR(100),
    fuel_type Text,
    fuel_tank_capacity_gal DECIMAL,
    epa_combined_mpg DECIMAL,
    epa_city_highway_mpg VARCHAR(50),
    range_miles_city_hwy VARCHAR(50),
    epa_combined_mpge VARCHAR(50),
    epa_city_highway_mpge VARCHAR(50),
    epa_electricity_range_mi VARCHAR(50),
    epa_kwh_100_mi VARCHAR(50),
    epa_charge_time_240v_hr DECIMAL,
    battery_capacity_kwh DECIMAL,
    front_head_room_in DECIMAL,
    front_hip_room_in DECIMAL,
    front_leg_room_in DECIMAL,
    front_shoulder_room_in DECIMAL,
    rear_head_room_in DECIMAL,
    rear_hip_room_in DECIMAL,
    rear_leg_room_in DECIMAL,
    rear_shoulder_room_in DECIMAL,
    basic_warranty TEXT,
    drivetrain_warranty TEXT,
    roadside_assistance_warranty TEXT,
    rust_warranty TEXT,
    source_json TEXT,
    source_url TEXT,
    image_url TEXT,
    review TEXT,
    pros TEXT,
    cons TEXT,
    whats_new TEXT,
    nhtsa_overall_rating VARCHAR(50),
    used_price_range TEXT,
    scorecard_overall VARCHAR(50),
    scorecard_driving DECIMAL,
    scorecard_comfort DECIMAL,
    scorecard_interior DECIMAL,
    scorecard_utility DECIMAL,
    scorecard_technology DECIMAL,
    expert_rating_our_verdict VARCHAR(50),
    expert_rating_performance VARCHAR(50),
    expert_rating_comfort VARCHAR(50),
    expert_rating_interior VARCHAR(50),
    expert_rating_technology VARCHAR(50),
    expert_rating_storage VARCHAR(50),
    expert_rating_fuel_economy VARCHAR(50),
    expert_rating_value VARCHAR(50),
    expert_rating_wildcard VARCHAR(50),
    old_trim TEXT,
    old_description TEXT,
    images_url TEXT,
    suspension TEXT,
    front_seats TEXT,
    rear_seats TEXT,
    power_features TEXT,
    instrumentation TEXT,
    convenience TEXT,
    comfort TEXT,
    memorized_settings TEXT,
    in_car_entertainment TEXT,
    roof_and_glass TEXT,
    body TEXT,
    truck_features TEXT,
    tires_and_wheels TEXT,
    doors_features TEXT,
    towing_and_hauling TEXT,
    safety_features TEXT,
    packages TEXT,
    exterior_options TEXT,
    interior_options TEXT,
    mechanical_options TEXT,
    country_of_origin VARCHAR(50),
    car_classification VARCHAR(50),
    platform_code_generation_number VARCHAR(50)
);

CREATE TABLE car (
    id BIGINT PRIMARY KEY,  -- Unique car ID
    make VARCHAR(100),
    model VARCHAR(100),
    year INT,
    trim VARCHAR(100),
    trim_description TEXT,
    body_type VARCHAR(50),
    doors INT,
    total_seating INT,
    country_of_origin VARCHAR(50),
    car_classification VARCHAR(50),
    platform_code_generation_number VARCHAR(50)
);


INSERT INTO car (
    id, make, model, year, trim, trim_description, body_type, doors, 
    total_seating, country_of_origin, car_classification, platform_code_generation_number
)
SELECT 
    id, make, model, year, trim, trim_description, body_type, doors, 
    total_seating, country_of_origin, car_classification, platform_code_generation_number
FROM staging_car_data;

CREATE TABLE dimensions (
    id BIGINT PRIMARY KEY REFERENCES car(id),  -- Foreign key to car table
    length_in DECIMAL,
    width_in DECIMAL,
    height_in DECIMAL,
    wheelbase_in DECIMAL,
    front_track_in DECIMAL,
    rear_track_in DECIMAL,
    ground_clearance_in DECIMAL,
    angle_of_approach_degrees DECIMAL,
    angle_of_departure_degrees DECIMAL,
    turning_circle_ft DECIMAL,
    drag_coefficient DECIMAL,
    epa_interior_volume_cu_ft DECIMAL,
    cargo_capacity_cu_ft DECIMAL,
    max_cargo_capacity_cu_ft DECIMAL,
    curb_weight_lbs DECIMAL,
    gross_weight_lbs DECIMAL,
    max_payload_lbs DECIMAL,
    max_towing_capacity_lbs DECIMAL
);

INSERT INTO dimensions (
    id, length_in, width_in, height_in, wheelbase_in, front_track_in, 
    rear_track_in, ground_clearance_in, angle_of_approach_degrees, 
    angle_of_departure_degrees, turning_circle_ft, drag_coefficient, 
    epa_interior_volume_cu_ft, cargo_capacity_cu_ft, max_cargo_capacity_cu_ft, 
    curb_weight_lbs, gross_weight_lbs, max_payload_lbs, max_towing_capacity_lbs
)
SELECT 
    id, length_in, width_in, height_in, wheelbase_in, front_track_in, 
    rear_track_in, ground_clearance_in, angle_of_approach_degrees, 
    angle_of_departure_degrees, turning_circle_ft, drag_coefficient, 
    epa_interior_volume_cu_ft, cargo_capacity_cu_ft, max_cargo_capacity_cu_ft, 
    curb_weight_lbs, gross_weight_lbs, max_payload_lbs, max_towing_capacity_lbs
FROM staging_car_data;

CREATE TABLE engine (
    id BIGINT PRIMARY KEY REFERENCES car(id),  -- Foreign key to car table
    cylinders VARCHAR(100),
    engine_size_l DECIMAL,
    horsepower_hp DECIMAL,
    horsepower_rpm INT,
    torque_ft_lbs DECIMAL,
    torque_rpm INT,
    valves INT,
    valve_timing VARCHAR(100),
    cam_type VARCHAR(50),
    drive_type VARCHAR(50),
    transmission VARCHAR(100),
    engine_type VARCHAR(100),
    fuel_type TEXT,
    fuel_tank_capacity_gal DECIMAL
);

INSERT INTO engine (
    id, cylinders, engine_size_l, horsepower_hp, horsepower_rpm, torque_ft_lbs, 
    torque_rpm, valves, valve_timing, cam_type, drive_type, transmission, 
    engine_type, fuel_type, fuel_tank_capacity_gal
)
SELECT 
    id, cylinders, engine_size_l, horsepower_hp, horsepower_rpm, torque_ft_lbs, 
    torque_rpm, valves, valve_timing, cam_type, drive_type, transmission, 
    engine_type, fuel_type, fuel_tank_capacity_gal
FROM staging_car_data;

CREATE TABLE fuel_efficiency (
    id BIGINT PRIMARY KEY REFERENCES car(id),  -- Foreign key to car table
    epa_combined_mpg DECIMAL,
    epa_city_highway_mpg VARCHAR(50),
    range_miles_city_hwy VARCHAR(50),
    epa_combined_mpge VARCHAR(50),
    epa_city_highway_mpge VARCHAR(50),
    epa_electricity_range_mi VARCHAR(50),
    epa_kwh_100_mi VARCHAR(50),
    epa_charge_time_240v_hr DECIMAL,
    battery_capacity_kwh DECIMAL
);

INSERT INTO fuel_efficiency (
    id, epa_combined_mpg, epa_city_highway_mpg, range_miles_city_hwy, 
    epa_combined_mpge, epa_city_highway_mpge, epa_electricity_range_mi, 
    epa_kwh_100_mi, epa_charge_time_240v_hr, battery_capacity_kwh
)
SELECT 
    id, epa_combined_mpg, epa_city_highway_mpg, range_miles_city_hwy, 
    epa_combined_mpge, epa_city_highway_mpge, epa_electricity_range_mi, 
    epa_kwh_100_mi, epa_charge_time_240v_hr, battery_capacity_kwh
FROM staging_car_data;


CREATE TABLE warranty (
    id BIGINT PRIMARY KEY REFERENCES car(id),  -- Foreign key to car table
    basic_warranty TEXT,
    drivetrain_warranty TEXT,
    roadside_assistance_warranty TEXT,
    rust_warranty TEXT
);

INSERT INTO warranty (
    id, basic_warranty, drivetrain_warranty, roadside_assistance_warranty, rust_warranty
)
SELECT 
    id, basic_warranty, drivetrain_warranty, roadside_assistance_warranty, rust_warranty
FROM staging_car_data;


CREATE TABLE pricing (
    id BIGINT PRIMARY KEY REFERENCES car(id),  -- Foreign key to car table
    base_msrp DECIMAL(10, 2),
    base_invoice DECIMAL(10, 2)
);

INSERT INTO pricing (
    id, base_msrp, base_invoice
)
SELECT 
    id, base_msrp::DECIMAL, base_invoice::DECIMAL
FROM staging_car_data;


CREATE TABLE reviews (
    id BIGINT PRIMARY KEY REFERENCES car(id),  -- Foreign key to car table
    review TEXT,
    pros TEXT,
    cons TEXT,
    whats_new TEXT,
    expert_rating_our_verdict DECIMAL,
    expert_rating_performance DECIMAL,
    expert_rating_comfort DECIMAL,
    expert_rating_interior DECIMAL,
    expert_rating_technology DECIMAL,
    expert_rating_storage DECIMAL,
    expert_rating_fuel_economy DECIMAL,
    expert_rating_value DECIMAL,
    expert_rating_wildcard DECIMAL
);

INSERT INTO reviews (
    id, review, pros, cons, whats_new, expert_rating_our_verdict, 
    expert_rating_performance, expert_rating_comfort, expert_rating_interior, 
    expert_rating_technology, expert_rating_storage, expert_rating_fuel_economy, 
    expert_rating_value, expert_rating_wildcard
)
SELECT 
    id, review, pros, cons, whats_new, expert_rating_our_verdict::DECIMAL, 
    expert_rating_performance::DECIMAL, expert_rating_comfort::DECIMAL, expert_rating_interior::DECIMAL, 
    expert_rating_technology::DECIMAL, expert_rating_storage::DECIMAL, expert_rating_fuel_economy::DECIMAL, 
    expert_rating_value::DECIMAL, expert_rating_wildcard::DECIMAL
FROM staging_car_data;


CREATE TABLE safety_ratings (
    id BIGINT PRIMARY KEY REFERENCES car(id),  -- Foreign key to car table
    nhtsa_overall_rating DECIMAL
);

INSERT INTO safety_ratings (
    id, nhtsa_overall_rating
)
SELECT 
    id, nhtsa_overall_rating::DECIMAL
FROM staging_car_data;


CREATE TABLE media (
    id BIGINT PRIMARY KEY REFERENCES car(id),  -- Foreign key to car table
    image_url TEXT,
    images_url TEXT
);

INSERT INTO media (
    id, image_url, images_url
)
SELECT 
    id, image_url, images_url
FROM staging_car_data;


CREATE TABLE features (
    id BIGINT PRIMARY KEY REFERENCES car(id),  -- Foreign key to car table
    front_seats TEXT,
    rear_seats TEXT,
    power_features TEXT,
    instrumentation TEXT,
    convenience TEXT,
    comfort TEXT,
    memorized_settings TEXT,
    in_car_entertainment TEXT,
    roof_and_glass TEXT,
    body TEXT,
    truck_features TEXT,
    tires_and_wheels TEXT,
    doors_features TEXT,
    towing_and_hauling TEXT,
    safety_features TEXT,
    packages TEXT,
    exterior_options TEXT,
    interior_options TEXT,
    mechanical_options TEXT
);

INSERT INTO features (
    id, front_seats, rear_seats, power_features, instrumentation, convenience, 
    comfort, memorized_settings, in_car_entertainment, roof_and_glass, body, 
    truck_features, tires_and_wheels, doors_features, towing_and_hauling, 
    safety_features, packages, exterior_options, interior_options, mechanical_options
)
SELECT 
    id, front_seats, rear_seats, power_features, instrumentation, convenience, 
    comfort, memorized_settings, in_car_entertainment, roof_and_glass, body, 
    truck_features, tires_and_wheels, doors_features, towing_and_hauling, 
    safety_features, packages, exterior_options, interior_options, mechanical_options
FROM staging_car_data;

CREATE TABLE colors (
    id BIGINT PRIMARY KEY REFERENCES car(id),  -- Foreign key to car table
    colors_exterior TEXT,
    colors_interior TEXT
);

INSERT INTO colors (
    id, colors_exterior, colors_interior
)
SELECT 
    id, colors_exterior, colors_interior
FROM staging_car_data;



 