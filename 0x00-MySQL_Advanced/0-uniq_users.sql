-- This SQL script creates a table for storing user data.
-- The table has columns for the user's ID, email, and name.
-- The email column is unique to ensure that each user has a unique email address.
CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255)
);