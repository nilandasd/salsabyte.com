import mongoose, { Mongoose } from "mongoose";

class DB {
  uri: string;
  connection: Mongoose;
  connected: boolean;
  constructor() {
    this.uri = `mongodb://${process.env.MONGO_USERNAME}:${process.env.MONGO_PASSWORD}@mongodb:27017/test?authSource=admin`;
  }

  async connect() {
    if (process.env.NO_DB || this.connected) return;

    try {
      this.connection = await mongoose.connect(this.uri);
      // tslint:disable-next-line:no-console
      console.error("Connected to database");
    } catch (err: any) {
      // tslint:disable-next-line:no-console
      console.error(err);
    }
  }

  async disconnect() {
    await this.connection.disconnect();
  }

  async teardown() {
    await this.destroy();
    await this.disconnect();
  }

  async destroy() {
    await this.connection.connection.db.dropDatabase();
  }
}

export default new DB;
export type { DB };
