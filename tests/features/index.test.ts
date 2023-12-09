import driver from './webDriverHandle';
import server from '../../src/server';

beforeEach(async () => {
  await server.start();
  await driver.init();
}, 10_000);

afterEach(async () => {
  await server.stop();
  await driver.quit();
}, 10_000);

describe("Index Page", () => {
  it('renders the page', async () => {
    const header = await driver.querySelector('.title')
    const actual = await header.getText()
    const expected = 'SalsaByte'
    expect(actual).toEqual(expected)
  }, 30_000);
});
