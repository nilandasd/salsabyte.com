import request from "supertest";
import app from "../../src/app";

describe("IndexController", () => {
  test("Renders Ok", async () => {
    const res = await request(app).get('/');
    expect(res.status).toEqual(200);
  });
});

