const puppeteer = require('puppeteer')
const url = process.argv[2]
const destination = process.argv[3]
if (!url) {
  throw new Error('Please provide a URL as the first argument')
}
if (!destination) {
  throw new Error('Please provide a filenamee destination as the second argument')
}
const h = 1080
const w = 1500;

(async () => {
  const browser = await puppeteer.launch({
    args: [
      '--disable-dev-shm-usage',
      '--disable-session-crashed-bubble',
      '--disable-infobars',
      '--disable-setuid-sandbox',
      '--disable-gpu',
      '--disable-font-subpixel-positioning',
      '--enable-automation',
      '--enable-font-antialiasing',
      '--font-render-hinting=none',
      '--force-color-profile=srgb',
      '--hide-scrollbars',
      '--ignore-certificate-errors',
      '--kiosk',
      '--noerrdialogs',
      '--no-default-browser-check',
      '--no-sandbox',
      '--start-fullscreen',
      '--start-maximized',
      '--useAutomationExtension',
      '--user-data-dir=./.chrome',
      '--window-size=1500,1080'
    ],
    ignoreDefaultArgs: ['--enable-automation'],
    headless: 'new'
  })
  const page = await browser.newPage()
  await page.setViewport({ width: w, height: h })
  await page.goto(url, { waitUntil: 'networkidle2' })
  await page.waitForTimeout(5000)
  await page.screenshot({
    path: destination
  })

  await browser.close()
})()
