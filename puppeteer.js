const puppeteer = require('puppeteer')
const url = process.argv[2]
if (!url) {
  throw new Error('Please provide a URL as the first argument')
}

(async () => {
  const browser = await puppeteer.launch({
    args: ['--disable-dev-shm-usage', '--user-data-dir=./.chrome', '--start-fullscreen', '--kiosk', '--disable-session-crashed-bubble', '--noerrdialogs', '--no-default-browser-check', '--useAutomationExtension', '--disable-infobars', '--ignore-certificate-errors', '--start-maximized', '--enable-automation', '--no-sandbox', '--disabled-setupid-sandbox', '--enable-font-antialiasing', '--font-render-hinting=none', '--disable-gpu', '--force-color-profile=srgb', '--window-size=1664,936', '--hide-scrollbars', '--disable-font-subpixel-positioning'],
    ignoreDefaultArgs: ['--enable-automation'],
    headless: 'new'
  })
  const page = await browser.newPage()
  await page.setViewport({ width: 1500, height: 1080 })
  await page.goto(url)
  await page.screenshot({
    path: './docs/img/github-profile.png'
  })

  await browser.close()
})()
