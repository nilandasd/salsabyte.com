import mongoose from "mongoose";

async function connectToMongo() {
  const mongoUri = `mongodb://${process.env.MONGO_USERNAME}:${process.env.MONGO_PASSWORD}@mongodb:27017/test?authSource=admin`;

  // TODO REMOVE ONCE PROD MONGO IS SETUP
  if (process.env.TEST) return;

  try {
    return await mongoose.connect(mongoUri);
  } catch (err: any) {
    // tslint:disable-next-line:no-console
    console.error(err);
  }
}

export default connectToMongo;
