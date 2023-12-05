import db from '../src/db';
import driver from './features/webDriverHandle';

const teardown = async function() {
  await driver.quit();
}

export default teardown;
