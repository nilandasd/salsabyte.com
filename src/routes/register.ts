import express from "express";
import controller from "../controllers/registerController";

const router = express.Router();

router.get('/', controller.new);
router.post('/', controller.create);

export default router;
