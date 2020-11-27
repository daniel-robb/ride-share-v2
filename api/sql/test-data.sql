INSERT INTO public."User" (id, "firstName", "lastName", email, password, phone, "isAdmin") VALUES (1, 'Raniel', 'Dobb', 'raniel_dobb@nottaylor.edu', 'dontHUGmeIMscared132', 7779999, true);
INSERT INTO public."User" (id, "firstName", "lastName", email, password, phone, "isAdmin") VALUES (2, 'Goey', 'Jorski', 'goey_jorski@nottaylor.edu', 'help1111', 7276454, false);
INSERT INTO public."User" (id, "firstName", "lastName", email, password, phone, "isAdmin") VALUES (3, 'Jesley', 'Wones', 'jesley_wones@nottaylor.edu', 'notit#11111', 2221115, false);

INSERT INTO public."State" (abbreviation, name) VALUES ('CA', 'california');
INSERT INTO public."State" (abbreviation, name) VALUES ('IN', 'indiana');
INSERT INTO public."State" (abbreviation, name) VALUES ('PA', 'pennsylvania');

INSERT INTO public."Driver" (id, "userId", "licenseNumber", "licenseState") VALUES (2, 1, '9876-5432-1098-765', 'CA');
INSERT INTO public."Driver" (id, "userId", "licenseNumber", "licenseState") VALUES (3, 2, '9876-5432-1098-111', 'IN');
INSERT INTO public."Driver" (id, "userId", "licenseNumber", "licenseState") VALUES (4, 3, '1111-5432-1098-765', 'PA');

INSERT INTO public."Location" (id, name, address, city, state, "zipCode", "fuelPrice") VALUES (1, 'Hoth', '1234 SW street', 'Dagobah', 'CA', '33763', 2.54);
INSERT INTO public."Location" (id, name, address, city, state, "zipCode", "fuelPrice") VALUES (2, 'HomeOne', '324 Past-The-Stars Ave', 'Coruscant', 'PA', '22222', 3.01);
INSERT INTO public."Location" (id, name, address, city, state, "zipCode", "fuelPrice") VALUES (3, 'Tyre', '765 Doctor Blvd', 'City A', 'IN', '12312', 2.15);

INSERT INTO public."Vehicle_Type" (id, type) VALUES (1, 'van');
INSERT INTO public."Vehicle_Type" (id, type) VALUES (2, 'minivan');
INSERT INTO public."Vehicle_Type" (id, type) VALUES (3, 'pickup');
INSERT INTO public."Vehicle_Type" (id, type) VALUES (4, 'coupe');

INSERT INTO public."Vehicle" (id, make, model, color, "vehicleTypeId", capacity, "licenseState", "licensePlate") VALUES (1, 'Toyota', 'Camry', 'Red', 1, 5, 'CA', 'G3N515');
INSERT INTO public."Vehicle" (id, make, model, color, "vehicleTypeId", capacity, "licenseState", "licensePlate") VALUES (2, 'Mazda', 'CX-5', 'White', 3, 2, 'PA', 'fishdud');
INSERT INTO public."Vehicle" (id, make, model, color, "vehicleTypeId", capacity, "licenseState", "licensePlate") VALUES (3, 'Ford', 'Excursion', 'White', 2, 8, 'CA', 'null');

INSERT INTO public."Ride" (id, date, time, distance, fee, "vehicleId", "fromLocationId", "toLocationId") VALUES (1, '2020-09-30', '12:45:00', 10.1, 0, 1, 1, 2);
INSERT INTO public."Ride" (id, date, time, distance, fee, "vehicleId", "fromLocationId", "toLocationId") VALUES (2, '2020-10-01', '12:00:00', 11.2, 10.54, 3, 3, 2);
INSERT INTO public."Ride" (id, date, time, distance, fee, "vehicleId", "fromLocationId", "toLocationId") VALUES (3, '1970-01-01', '00:00:00', 120, 50.32, 2, 2, 1);

INSERT INTO public."Passenger" ("passengerId", "rideId") VALUES (1, 1);
INSERT INTO public."Passenger" ("passengerId", "rideId") VALUES (2, 1);
INSERT INTO public."Passenger" ("passengerId", "rideId") VALUES (3, 2);
INSERT INTO public."Passenger" ("passengerId", "rideId") VALUES (3, 3);

INSERT INTO public."Drivers" ("driverId", "rideId") VALUES (2, 1);
INSERT INTO public."Drivers" ("driverId", "rideId") VALUES (3, 2);
INSERT INTO public."Drivers" ("driverId", "rideId") VALUES (4, 3);

INSERT INTO public."Authorization" ("driverId", "vehicleId") VALUES (3, 3);
INSERT INTO public."Authorization" ("driverId", "vehicleId") VALUES (2, 1);
INSERT INTO public."Authorization" ("driverId", "vehicleId") VALUES (3, 2);
INSERT INTO public."Authorization" ("driverId", "vehicleId") VALUES (4, 2);