const { Pool } = require('pg');

const pool = new Pool({
	host: process.env.DB_HOST,
	database: process.env.DB_NAME,
	user: process.env.DB_USER
});

module.exports = pool;
	
