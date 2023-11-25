import { Request, Response, NextFunction } from 'express';

class RegisterController {
    new(req: Request, res: Response, next: NextFunction) {
      res.render("index");
    }
    create(req: Request, res: Response, next: NextFunction) {
      res.render("index");
    }
}

export default new RegisterController();
