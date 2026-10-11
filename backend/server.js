
const express = require("express");

const app = express();
const PORT = 3000;

app.use(express.json());

// Probni podaci za javne toalete
let toilets = [
    {
        id: 1,
        name: "Javni toalet - Centar",
        address: "Trg Republike, Beograd",
        accessible: true
    },
    {
        id: 2,
        name: "Javni toalet - Park",
        address: "Tašmajdan, Beograd",
        accessible: false
    }
];

// Pocetna ruta
app.get("/", (req, res) => {
    res.json({
        message: "Pissh Stop backend radi!"
    });
});

// Prikaz svih toaleta
app.get("/api/toilets", (req, res) => {
    res.json(toilets);
});

// Prikaz jednog toaleta po ID-ju
app.get("/api/toilets/:id", (req, res) => {
    const id = Number(req.params.id);
    const toilet = toilets.find(t => t.id === id);

    if (!toilet) {
        return res.status(404).json({
            error: "Toalet nije pronadjen."
        });
    }

    res.json(toilet);
});

// Dodavanje novog toaleta
app.post("/api/toilets", (req, res) => {
    const { name, address, accessible } = req.body;

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

    const newToilet = {
        id: toilets.length
            ? Math.max(...toilets.map(t => t.id)) + 1
            : 1,
        name: name.trim(),
        address: address.trim(),
        accessible: accessible === true
    };

    toilets.push(newToilet);

    res.status(201).json({
        message: "Toalet je uspesno dodat.",
        toilet: newToilet
    });
});

// Pokretanje servera
app.listen(PORT, () => {
    console.log(
        `Pissh Stop backend je pokrenut na http://localhost:${PORT}`
    );
});
