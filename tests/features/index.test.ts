import driver from './webDriverHandle';
import server from '../../src/server';

beforeEach(async () => {
  await server.start();
}, 10_000);

afterEach(async () => {
  await server.stop();
}, 10_000);

describe("Index Page", () => {
  it('renders the page', async () => {
    const header = await driver.querySelector('.header')
    const actual = await header.getText()
    const expected = 'Index Page'
    expect(actual).toEqual(expected)
  }, 30_000);
});
