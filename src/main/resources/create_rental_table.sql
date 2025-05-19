CREATE TABLE rental (
                        id VARCHAR(20) PRIMARY KEY,
                        status VARCHAR(20) NOT NULL,
                        area FLOAT NOT NULL CHECK (area > 20),
                        floor INT NOT NULL CHECK (floor BETWEEN 1 AND 15),
                        type VARCHAR(50) NOT NULL,
                        price BIGINT NOT NULL CHECK (price > 1000000),
                        start_date DATE NOT NULL,
                        end_date DATE NOT NULL
);
