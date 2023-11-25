import { By, until, Browser, Builder, WebDriver } from 'selenium-webdriver';
import chrome, { Options } from 'selenium-webdriver/chrome';

class WebDriverHandle {
  waitUntilTime = 20000;
  rootUrl = `http://backend:${process.env.SERVER_PORT}`;
  driver: WebDriver;

  async init() {
    this.driver = await new Builder()
      .forBrowser(Browser.CHROME)
      .setChromeOptions(this.options())
      .build();

    await this.driver.get(this.rootUrl);
  }

  async quit() {
    await this.driver.quit();
  }

  async querySelector(selector: string) {
    const el = await this.driver.wait(
      until.elementLocated(By.css(selector)),
      this.waitUntilTime
    );
    return await this.driver.wait(until.elementIsVisible(el), this.waitUntilTime)
  }

  async getElementById(id: string) {
    const el = await this.driver.wait(
      until.elementLocated(By.id(id)),
      this.waitUntilTime
    );
    return await this.driver.wait(until.elementIsVisible(el), this.waitUntilTime);
  }

  async getElementByXPath(xpath: string) {
    const el = await this.driver.wait(
      until.elementLocated(By.xpath(xpath)),
      this.waitUntilTime
    );
    return await this.driver.wait(until.elementIsVisible(el), this.waitUntilTime);
  }

  private options(): Options {
    let options = new chrome.Options();
    options.headless();

    return options;
  }
}

export default new WebDriverHandle();
