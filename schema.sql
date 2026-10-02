
--Drop existing tables to ensure a clean initialization
DROP TABLE IF EXISTS workout_sets CASCADE;
DROP TABLE IF EXISTS workout_sessions CASCADE;
DROP TABLE IF EXISTS exercises CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Create core tables
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    body_weight_kg DECIMAL(5,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE exercises (
    exercise_id SERIAL PRIMARY KEY,
    exercise_name VARCHAR(100) UNIQUE NOT NULL,
    target_muscle VARCHAR(50) NOT NULL
);

CREATE TABLE workout_sessions (
    session_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id) ON DELETE CASCADE,
    session_date DATE NOT NULL DEFAULT CURRENT_DATE,
    session_type VARCHAR(50),
    notes TEXT
);

CREATE TABLE workout_sets (
    set_id SERIAL PRIMARY KEY,
    session_id INTEGER REFERENCES workout_sessions(session_id) ON DELETE CASCADE,
    exercise_id INTEGER REFERENCES exercises(exercise_id) ON DELETE CASCADE,
    set_number INTEGER NOT NULL,
    reps INTEGER NOT NULL,
    weight_kg DECIMAL(5,2) NOT NULL
);

-- Insert Sample Data
INSERT INTO users (username, body_weight_kg) VALUES ('akash_fitness', 75.5);

INSERT INTO exercises (exercise_name, target_muscle) VALUES 
    ('Barbell Bench Press', 'Chest'),
    ('Squat', 'Legs'),
    ('Deadlift', 'Back'),
    ('Overhead Press', 'Shoulders');

INSERT INTO workout_sessions (user_id, session_date, session_type, notes) VALUES 
    (1, '2026-10-02', 'Push Day', 'Felt strong, focused on chest and shoulders.');

INSERT INTO workout_sets (session_id, exercise_id, set_number, reps, weight_kg) VALUES 
    (1, 1, 1, 10, 60.0),
    (1, 1, 2, 8, 65.0),
    (1, 1, 3, 5, 70.0),
    (1, 4, 1, 10, 40.0),
    (1, 4, 2, 8, 45.0);