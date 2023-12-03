import db from '../src/db';

const teardown = async function() {
  await db.teardown();
}

export default teardown;
