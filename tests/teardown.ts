import mongoose from "mongoose";

const teardown = async function() {
  await mongoose.connection.db.dropDatabase();
  await mongoose.connection.close();
}

export default teardown;
