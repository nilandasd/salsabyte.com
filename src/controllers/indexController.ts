import { Request, Response, NextFunction } from 'express';

class IndexController {
    show(req: Request, res: Response, next: NextFunction) {
      // tslint:disable-next-line:no-debugger
      debugger;
      res.render("index");
    }
}

export default new IndexController();
