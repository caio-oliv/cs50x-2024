CREATE TABLE user_stocks (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	user_id INTEGER NOT NULL REFERENCES users (id),
	symbol TEXT NOT NULL,
	shares INTEGER NOT NULL
);

CREATE UNIQUE INDEX user_stocks_unique_stock ON user_stocks (user_id, symbol);

CREATE TABLE user_transactions (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	user_id INTEGER NOT NULL REFERENCES users (id),
	direction TEXT NOT NULL,
	symbol TEXT NOT NULL,
	price NUMERIC NOT NULL,
	shares INTEGER NOT NULL,
	timestamp INTEGER NOT NULL
);
