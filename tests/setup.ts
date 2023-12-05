import db from '../src/db';
import driver from './features/webDriverHandle';

const setup = async function() {
  await driver.init();
}

export default setup;
