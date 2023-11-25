import driver from './webDriverHandle';
import server from '../../src/server';

beforeAll(async () => {
  await server.start();
  await driver.init();
}, 10_000);

afterAll(async () => {
  await server.stop();
  await driver.quit();
}, 10_000);

describe("Index Page", () => {
  it('renders the page', async () => {
    const header = await driver.querySelector('.header')
    const actual = await header.getText()
    const expected = 'Index Page'
    expect(actual).toEqual(expected)
  }, 30_000)
});
