import connectToMongo from './config/mongo';
import app from './app';
import { Application } from 'express';
import http, { Server as HttpServer } from 'http';

const port = process.env.SERVER_PORT;

class Server {
  app: Application;
  server: HttpServer;

  constructor(app: Application) {
    this.app = app;
    this.server = null;
  }

  async start() {
    // await connectToMongo;
    // tslint:disable-next-line:no-console
    console.log('connected to mongo');

    return new Promise((resolve, reject) => {
        try {
          this.server = http.createServer(app);

          this.server.listen(port, () => {
              // tslint:disable-next-line:no-console
              console.log( `server started at http://localhost:${ port }` );
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
  }
}

export default new Server(app);
