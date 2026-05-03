
    CREATE TABLE IF NOT EXISTS users (
        user_id TEXT PRIMARY KEY, full_name TEXT, email TEXT UNIQUE, phone TEXT,
        password_hash TEXT, password_salt TEXT, role TEXT, kyc_status TEXT
    );
    CREATE TABLE IF NOT EXISTS accounts (
        account_id TEXT PRIMARY KEY, user_id TEXT, account_number TEXT UNIQUE,
        account_type TEXT, balance DECIMAL(15,2), status TEXT
    );
    