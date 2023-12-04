import mongoose, { Mongoose } from "mongoose";
import { MongoMemoryServer} from 'mongodb-memory-server';

class DB {
  uri: string;
  conn: Mongoose;
  mongoServer: MongoMemoryServer;

  async setUri() {
    switch (process.env.ENV) {
      case "PROD": this.uri = `mongodb://${process.env.MONGO_USERNAME}:${process.env.MONGO_PASSWORD}@mongodb:27017/test?authSource=admin`;
      case "TEST": {
        this.mongoServer = await MongoMemoryServer.create();
        this.uri = this.mongoServer.getUri();
      }
    }
  }

  async connect() {
    if (this.uri == null) await this.setUri();

    try {
      this.conn = await mongoose.connect(this.uri);
      // tslint:disable-next-line:no-console
      console.log("Connected to database");
    } catch (err: any) {
      // tslint:disable-next-line:no-console
      console.error(err);
    }
  }

  async disconnect() {
    await this.conn.disconnect();
    if (process.env.ENV == "TEST") await this.mongoServer.stop();
  }
}

export default new DB;
export type { DB };
