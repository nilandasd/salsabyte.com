import db from '../src/db';

const teardown = async function() {
  await db.disconnect();
}

export default teardown;
