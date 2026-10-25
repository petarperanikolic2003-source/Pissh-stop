
const request = require("supertest");
const app = require("./server");

describe("Pissh Stop API", () => {
    test("GET / vraća poruku da backend radi", async () => {
        const response = await request(app).get("/");

        expect(response.status).toBe(200);
        expect(response.body.message).toBe("Pissh Stop backend radi!");
    });

    test("GET /api/toilets vraća listu toaleta", async () => {
        const response = await request(app).get("/api/toilets");

        expect(response.status).toBe(200);
        expect(Array.isArray(response.body)).toBe(true);
    });

    test("GET /api/toilets/abc vraća grešku 400", async () => {
        const response = await request(app).get("/api/toilets/abc");

        expect(response.status).toBe(400);
        expect(response.body.error).toBeDefined();
    });

    test("GET /api/toilets/99999 vraća grešku 404", async () => {
        const response = await request(app).get("/api/toilets/99999");

        expect(response.status).toBe(404);
        expect(response.body.error).toBeDefined();
    });

    test("POST /api/toilets odbija prazan naziv i adresu", async () => {
        const response = await request(app)
            .post("/api/toilets")
            .send({ name: "", address: "" });

        expect(response.status).toBe(400);
        expect(response.body.error).toBeDefined();
    });
});
