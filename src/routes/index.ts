import express from "express";
import controller from "../controllers/indexController";

const router = express.Router();

router.get('/', controller.show);

export default router;
