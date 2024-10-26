-- Keep a log of any SQL queries you execute as you solve the mystery.

-- crime report
SELECT * FROM crime_scene_reports WHERE street = 'Humphrey Street' AND id = 295;

-- 10:15am

-- all interviews of the crime
SELECT * FROM interviews
WHERE interviews.year = 2023
	AND interviews.month = 7
	AND interviews.day = 28
	AND interviews.transcript LIKE '%bakery%';

-- lead from interview id 161
SELECT * FROM bakery_security_logs
WHERE bakery_security_logs.year = 2023
	AND bakery_security_logs.month = 7
	AND bakery_security_logs.day = 28
	AND bakery_security_logs.hour = 10
	AND bakery_security_logs.minute >= 15
	AND bakery_security_logs.minute < 25
	AND activity = 'exit';

-- lead from interview id 162
SELECT * FROM atm_transactions
WHERE atm_transactions.year = 2023
	AND atm_transactions.month = 7
	AND atm_transactions.day = 28
	AND atm_transactions.atm_location = 'Leggett Street'
	AND atm_transactions.transaction_type = 'withdraw';

-- lead from interview id 163
SELECT * FROM phone_calls
WHERE phone_calls.year = 2023
	AND phone_calls.month = 7
	AND phone_calls.day = 28
	AND phone_calls.duration < 60;

-- lead from interview id 163 - flight the thief has taken
SELECT flights.* FROM flights
INNER JOIN airports ON flights.origin_airport_id = airports.id
WHERE airports.city = 'Fiftyville'
	AND flights.year = 2023
	AND flights.month = 7
	AND flights.day = 29
ORDER BY flights.hour ASC, flights.minute ASC
LIMIT 1;

-- airport where the thief landed
SELECT * FROM airports WHERE id = 4;

-- passengers of the flight the thief was
SELECT * FROM passengers WHERE flight_id = 36;

-- merge beteween leads
SELECT people.* FROM people
INNER JOIN passengers ON people.passport_number = passengers.passport_number
INNER JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
INNER JOIN phone_calls AS caller_calls ON people.phone_number = caller_calls.caller
INNER JOIN bank_accounts ON people.id = bank_accounts.person_id
INNER JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number
WHERE passengers.flight_id = 36
	AND (bakery_security_logs.year = 2023
	AND bakery_security_logs.month = 7
	AND bakery_security_logs.day = 28
	AND bakery_security_logs.hour = 10
	AND bakery_security_logs.minute >= 15
	AND bakery_security_logs.minute < 25
	AND bakery_security_logs.activity = 'exit')
	AND (caller_calls.year = 2023
	AND caller_calls.month = 7
	AND caller_calls.day = 28
	AND caller_calls.duration < 60)
	AND (atm_transactions.year = 2023
	AND atm_transactions.month = 7
	AND atm_transactions.day = 28
	AND atm_transactions.atm_location = 'Leggett Street'
	AND atm_transactions.transaction_type = 'withdraw');

-- call made by the thief to the accomplice to buy the flights
SELECT * FROM phone_calls
WHERE phone_calls.year = 2023
	AND phone_calls.month = 7
	AND phone_calls.day = 28
	AND phone_calls.duration < 60
	AND phone_calls.caller = '(367) 555-5533';

-- who was called by the thief to buy the flights
SELECT people.* FROM people
INNER JOIN phone_calls AS receiver_calls ON people.phone_number = receiver_calls.receiver
WHERE receiver_calls.year = 2023
	AND receiver_calls.month = 7
	AND receiver_calls.day = 28
	AND receiver_calls.duration < 60
	AND receiver_calls.caller = '(367) 555-5533';
