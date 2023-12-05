import mongoose, { Mongoose } from "mongoose";

class DB {
  uri: string;
  conn: Mongoose;

  constructor() {
    this.uri = `mongodb://${process.env.MONGO_USERNAME}:${process.env.MONGO_PASSWORD}@mongodb:27017/test?authSource=admin`;
  }

  async connect() {
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
  }
}

export default new DB();
export type { DB };
