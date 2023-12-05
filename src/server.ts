import db, { DB } from './db';
import app from './app';
import { Application } from 'express';
import http, { Server as HttpServer } from 'http';

class Server {
  app: Application;
  server: HttpServer;
  db: DB;
  port: number;

  constructor(app: Application) {
    this.app = app;
    this.port = parseInt(process.env.SERVER_PORT || "8080", 10);
    this.server = null;
    this.db = db;
  }

  async start() {
    await db.connect(); // TODO: should db just connect on init?

    return new Promise((resolve, reject) => {
        try {
          this.server = http.createServer(app);

          this.server.listen(this.port, () => {
              // tslint:disable-next-line:no-console
              console.log(`server started at http://localhost:${ this.port }`);
              resolve(null);
          });
        } catch(err: any) {
          // tslint:disable-next-line:no-console
          console.error(err);
          reject(err);
        }
    });
  }

  async stop() {
    this.server.close();
    this.db.disconnect();
  }
}

export default new Server(app);
