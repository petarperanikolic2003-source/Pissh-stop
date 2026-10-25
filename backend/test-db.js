const pool = require("./db");

async function testConnection() {
    try {
        const result = await pool.query(
            "SELECT current_database() AS database, COUNT(*) AS total FROM locations"
        );

        console.log("Uspešno povezivanje sa PostgreSQL bazom!");
        console.log("Baza:", result.rows[0].database);
        console.log("Broj toaleta:", result.rows[0].total);
    } catch (error) {
        console.error("Greška pri povezivanju sa bazom:", error.message);
    } finally {
        await pool.end();
    }
}

testConnection();