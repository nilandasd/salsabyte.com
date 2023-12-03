import connectToMongo from './config/mongo';
import { Mongoose } from 'mongoose';
import app from './app';
import { Application } from 'express';
import http, { Server as HttpServer } from 'http';

class Server {
  app: Application;
  server: HttpServer;
  port: number;
  db: Mongoose;

  constructor(app: Application) {
    this.app = app;
    this.port = parseInt(process.env.SERVER_PORT);
    this.server = null;
  }

  async start() {
    // this.db = await connectToMongo;
    // tslint:disable-next-line:no-console
    // console.log('connected to mongo');

    return new Promise((resolve, reject) => {
        try {
          this.server = http.createServer(app);

          this.server.listen(this.port, () => {
              // tslint:disable-next-line:no-console
              console.log( `server started at http://localhost:${ this.port }` );
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
    if (this.db != undefined) await this.db.disconnect();
    this.server.close();
  }
}

export default new Server(app);
