import express from "express";
import controller from "../controllers/loginController";

const router = express.Router();

router.get('/', controller.new);
router.post('/', controller.create);
router.delete('/', controller.delete);

export default router;
