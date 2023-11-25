import { Request, Response, NextFunction } from 'express';

class LoginController {
    new(req: Request, res: Response, next: NextFunction) {
      res.render("index");
    }
    create(req: Request, res: Response, next: NextFunction) {
      res.render("index");
    }
    delete(req: Request, res: Response, next: NextFunction) {
      res.render("index");
    }
}

export default new LoginController();
