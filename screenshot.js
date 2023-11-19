// adding Puppeteer library
const pt = require('puppeteer')
pt.launch({ headless: false }).then(async browser => {
  // browser new page
  const p = await browser.newPage()
  // set viewpoint of browser page
  await p.setViewport({ width: 1620, height: 1080 })
  // launch URL
  await p.goto('https://github.com/robinmordasiewicz')
  // capture screenshot
  await p.screenshot({
    path: 'github-profile.png'
  })
  // browser close
  await browser.close()
})
