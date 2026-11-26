-- 1) Conectarse a PostgreSQL desde la terminal de Codespaces:
--    psql --username=freecodecamp --dbname=postgres

CREATE DATABASE universe;
\c universe

-- 2) Tablas (5 tablas; las 4 principales con 5+ columnas)
CREATE TABLE galaxy (
  galaxy_id      SERIAL PRIMARY KEY,
  name           VARCHAR(60) NOT NULL UNIQUE,
  galaxy_type    VARCHAR(40) NOT NULL,
  distance_mly   NUMERIC(10,2),          -- distancia en millones de años luz
  diameter_kly   INT,                    -- diámetro en miles de años luz
  has_black_hole BOOLEAN NOT NULL,
  description    TEXT
);

CREATE TABLE star (
  star_id            SERIAL PRIMARY KEY,
  name               VARCHAR(60) NOT NULL UNIQUE,
  galaxy_id          INT NOT NULL REFERENCES galaxy(galaxy_id),
  spectral_type      VARCHAR(10),
  mass_solar         NUMERIC(8,3),
  age_million_years  INT,
  is_visible_naked_eye BOOLEAN NOT NULL
);

CREATE TABLE planet (
  planet_id       SERIAL PRIMARY KEY,
  name            VARCHAR(60) NOT NULL UNIQUE,
  star_id         INT NOT NULL REFERENCES star(star_id),
  planet_type     VARCHAR(40) NOT NULL,
  number_of_moons INT,
  distance_au     NUMERIC(10,3),
  has_life        BOOLEAN NOT NULL,
  has_rings       BOOLEAN NOT NULL
);

CREATE TABLE moon (
  moon_id             SERIAL PRIMARY KEY,
  name                VARCHAR(60) NOT NULL UNIQUE,
  planet_id           INT NOT NULL REFERENCES planet(planet_id),
  diameter_km         INT,
  orbital_period_days NUMERIC(10,2),
  is_spherical        BOOLEAN NOT NULL,
  description         TEXT
);

CREATE TABLE comet (
  comet_id             SERIAL PRIMARY KEY,
  name                 VARCHAR(60) NOT NULL UNIQUE,
  orbital_period_years NUMERIC(10,2),
  is_periodic          BOOLEAN NOT NULL
);

-- 3) Datos (los id se generan en el orden de inserción: 1, 2, 3...)
INSERT INTO galaxy (name, galaxy_type, distance_mly, diameter_kly, has_black_hole, description) VALUES
('Milky Way',  'Barred spiral', 0.00,    100, TRUE, 'Our home galaxy'),
('Andromeda',  'Spiral',        2.54,    220, TRUE, 'Closest large galaxy to the Milky Way'),
('Triangulum', 'Spiral',        2.73,     60, FALSE,'Third largest galaxy in the Local Group'),
('Messier 87', 'Elliptical',    53.50,   120, TRUE, 'First black hole ever photographed'),
('Sombrero',   'Spiral',        29.30,    50, TRUE, 'Bright nucleus and large central bulge'),
('Whirlpool',  'Spiral',        23.00,    76, TRUE, 'Interacting grand-design spiral galaxy');

INSERT INTO star (name, galaxy_id, spectral_type, mass_solar, age_million_years, is_visible_naked_eye) VALUES
('Sun',              1, 'G2V',   1.000,  4600, TRUE),
('Proxima Centauri', 1, 'M5.5Ve',0.122,  4850, FALSE),
('Alpha Centauri A', 1, 'G2V',   1.100,  5300, TRUE),
('Sirius',           1, 'A1V',   2.063,   242, TRUE),
('Betelgeuse',       1, 'M1Ia',  16.500,   10, TRUE),
('AE Andromedae',    2, 'LBV',   50.000,    5, FALSE);

INSERT INTO planet (name, star_id, planet_type, number_of_moons, distance_au, has_life, has_rings) VALUES
('Mercury',          1, 'Terrestrial', 0,  0.387, FALSE, FALSE),
('Venus',            1, 'Terrestrial', 0,  0.723, FALSE, FALSE),
('Earth',            1, 'Terrestrial', 1,  1.000, TRUE,  FALSE),
('Mars',             1, 'Terrestrial', 2,  1.524, FALSE, FALSE),
('Jupiter',          1, 'Gas giant',  95,  5.203, FALSE, TRUE),
('Saturn',           1, 'Gas giant', 146,  9.537, FALSE, TRUE),
('Uranus',           1, 'Ice giant',  28, 19.191, FALSE, TRUE),
('Neptune',          1, 'Ice giant',  16, 30.069, FALSE, TRUE),
('Proxima b',        2, 'Terrestrial', 0,  0.049, FALSE, FALSE),
('Proxima c',        2, 'Super-Earth', 0,  1.489, FALSE, FALSE),
('Proxima d',        2, 'Terrestrial', 0,  0.029, FALSE, FALSE),
('Alpha Centauri Ab',3, 'Gas giant',   0,  2.000, FALSE, FALSE);

INSERT INTO moon (name, planet_id, diameter_km, orbital_period_days, is_spherical, description) VALUES
('Moon',      3, 3474, 27.32,  TRUE,  'Earth''s only natural satellite'),
('Phobos',    4,   22,  0.32,  FALSE, 'Larger moon of Mars'),
('Deimos',    4,   12,  1.26,  FALSE, 'Smaller moon of Mars'),
('Io',        5, 3643,  1.77,  TRUE,  'Most volcanically active body'),
('Europa',    5, 3122,  3.55,  TRUE,  'Ice-covered ocean moon'),
('Ganymede',  5, 5268,  7.15,  TRUE,  'Largest moon in the Solar System'),
('Callisto',  5, 4821, 16.69,  TRUE,  'Heavily cratered surface'),
('Amalthea',  5,  167,  0.50,  FALSE, 'Irregular inner moon of Jupiter'),
('Titan',     6, 5150, 15.95,  TRUE,  'Thick nitrogen atmosphere'),
('Enceladus', 6,  504,  1.37,  TRUE,  'Water geysers at the south pole'),
('Mimas',     6,  396,  0.94,  TRUE,  'Giant Herschel crater'),
('Rhea',      6, 1527,  4.52,  TRUE,  'Second largest moon of Saturn'),
('Iapetus',   6, 1469, 79.32,  TRUE,  'Two-tone coloration'),
('Dione',     6, 1123,  2.74,  TRUE,  'Icy cliffs'),
('Miranda',   7,  472,  1.41,  TRUE,  'Extreme and varied terrain'),
('Ariel',     7, 1158,  2.52,  TRUE,  'Brightest moon of Uranus'),
('Umbriel',   7, 1169,  4.14,  TRUE,  'Darkest moon of Uranus'),
('Titania',   7, 1577,  8.71,  TRUE,  'Largest moon of Uranus'),
('Oberon',    7, 1523, 13.46,  TRUE,  'Outermost major moon of Uranus'),
('Triton',    8, 2707,  5.88,  TRUE,  'Retrograde orbit around Neptune');

INSERT INTO comet (name, orbital_period_years, is_periodic) VALUES
('Halley',         75.32, TRUE),
('Hale-Bopp',    2533.00, TRUE),
('Encke',           3.30, TRUE);

-- 4) Al pasar todas las pruebas, salir de psql (\q) y guardar el volcado:
--    pg_dump -cC --inserts -U freecodecamp universe > universe.sql
