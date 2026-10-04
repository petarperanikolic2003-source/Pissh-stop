const express = require("express");

const app = express();
const PORT = 3000;

app.get("/", (req, res) => {
    res.json({
        message: "Pissh Stop backend radi!"
    });
});

app.listen(PORT, () => {
    console.log(`Pissh Stop backend je pokrenut na http://localhost:${PORT}`);
});
