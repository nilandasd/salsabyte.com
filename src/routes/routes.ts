import { Router } from 'express';
import indexRoutes from './index';
import registerRoutes from './register';
import loginRoutes from './login';

const router = Router();

router.use('/', indexRoutes);
router.use('/register', registerRoutes);
router.use('/login', loginRoutes);

export default router;
