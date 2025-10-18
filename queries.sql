-- Travel Tracker schema for production
-- This sets up only what the app needs.

-- Optional: countries lookup (needed on fresh Neon/Render DBs)
CREATE TABLE IF NOT EXISTS countries (
  country_code CHAR(2) PRIMARY KEY,
  country_name TEXT UNIQUE NOT NULL
);

-- App tables
DROP TABLE IF EXISTS visited_countries;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  color VARCHAR(20)
);

CREATE TABLE visited_countries (
  id SERIAL PRIMARY KEY,
  country_code CHAR(2) NOT NULL,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE (user_id, country_code)
);

-- Seed minimal countries (load a full ISO list separately if desired)
INSERT INTO countries (country_code, country_name) VALUES
  ('FR','France') ON CONFLICT DO NOTHING,
  ('GB','United Kingdom') ON CONFLICT DO NOTHING,
  ('CA','Canada') ON CONFLICT DO NOTHING,
  ('US','United States') ON CONFLICT DO NOTHING,
  ('IN','India') ON CONFLICT DO NOTHING;

-- Demo data
INSERT INTO users (name, color) VALUES
  ('Angela', 'teal'),
  ('Jack', 'powderblue')
ON CONFLICT (name) DO NOTHING;

INSERT INTO visited_countries (country_code, user_id) VALUES
  ('FR', 1),
  ('GB', 1),
  ('CA', 2)
ON CONFLICT DO NOTHING;
