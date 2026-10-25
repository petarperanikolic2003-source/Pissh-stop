
const express = require("express");
const pool = require("./db");

const app = express();
const PORT = 3000;

app.use(express.json());

// Pocetna ruta
app.get("/", (req, res) => {
    res.json({
        message: "Pissh Stop backend radi!"
    });
});

// Prikaz svih toaleta iz PostgreSQL baze
app.get("/api/toilets", async (req, res) => {
    try {
        const result = await pool.query(`
            SELECT
                id,
                name,
                address,
                city,
                latitude,
                longitude,
                price_cents,
                is_open
            FROM locations
            ORDER BY id
        `);

        const toilets = result.rows.map(toilet => ({
            ...toilet,
            accessible: null
        }));

        res.json(toilets);
    } catch (error) {
        console.error("Greska pri ucitavanju toaleta:", error.message);
        res.status(500).json({
            error: "Greska pri ucitavanju toaleta."
        });
    }
});

// Prikaz jednog toaleta prema ID-ju
app.get("/api/toilets/:id", async (req, res) => {
    const id = Number(req.params.id);

    if (!Number.isInteger(id) || id < 1) {
        return res.status(400).json({
            error: "ID toaleta mora biti pozitivan ceo broj."
        });
    }

    try {
        const result = await pool.query(
            `SELECT
                id,
                name,
                address,
                city,
                latitude,
                longitude,
                price_cents,
                is_open
             FROM locations
             WHERE id = $1`,
            [id]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({
                error: "Toalet nije pronadjen."
            });
        }

        res.json({
            ...result.rows[0],
            accessible: null
        });
    } catch (error) {
        console.error("Greska pri ucitavanju toaleta:", error.message);
        res.status(500).json({
            error: "Greska pri ucitavanju toaleta."
        });
    }
});

// Dodavanje novog toaleta u PostgreSQL bazu
app.post("/api/toilets", async (req, res) => {
    const { name, address, city, latitude, longitude } = req.body;

    if (
        typeof name !== "string" ||
        !name.trim() ||
        typeof address !== "string" ||
        !address.trim()
    ) {
        return res.status(400).json({
            error: "Naziv i adresa toaleta su obavezni."
        });
    }

    const validCoordinate = (value, min, max) =>
        value === undefined ||
        value === null ||
        (
            typeof value === "number" &&
            Number.isFinite(value) &&
            value >= min &&
            value <= max
        );

    if (
        !validCoordinate(latitude, -90, 90) ||
        !validCoordinate(longitude, -180, 180)
    ) {
        return res.status(400).json({
            error: "Koordinate nisu ispravne."
        });
    }

    if (
        city !== undefined &&
        city !== null &&
        typeof city !== "string"
    ) {
        return res.status(400).json({
            error: "Grad mora biti tekst."
        });
    }

    try {
        const result = await pool.query(
            `INSERT INTO locations
                (name, address, city, latitude, longitude)
             VALUES ($1, $2, $3, $4, $5)
             RETURNING
                id,
                name,
                address,
                city,
                latitude,
                longitude,
                price_cents,
                is_open`,
            [
                name.trim(),
                address.trim(),
                city?.trim() || null,
                latitude ?? null,
                longitude ?? null
            ]
        );

        res.status(201).json({
            message: "Toalet je uspesno dodat.",
            toilet: {
                ...result.rows[0],
                accessible: null
            }
        });
    } catch (error) {
        console.error("Greska pri dodavanju toaleta:", error.message);
        res.status(500).json({
            error: "Greska pri dodavanju toaleta."
        });
    }
});

if (require.main === module) {
    app.listen(PORT, () => {
        console.log(
            `Pissh Stop backend je pokrenut na http://localhost:${PORT}`
        );
    });
}

module.exports = app;