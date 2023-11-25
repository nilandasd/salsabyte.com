import connectToMongo from '../src/config/mongo';

const setup = async function() {
  await connectToMongo;
}

export default setup;
