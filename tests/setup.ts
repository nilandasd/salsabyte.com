import db from '../src/db';

const setup = async function() {
  await db.connect();
}

export default setup;
