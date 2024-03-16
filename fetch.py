import time
from playwright.sync_api import sync_playwright
from playwright_stealth import stealth_sync
from my_fake_useragent import UserAgent
from random import random,randint


class Bot:
    def __init__(self):
        ua = UserAgent(family="chrome")
        user_agent = ua.random()
        self.proxy = "socks5://127.0.0.1:9050"
        self.url = "https://www.wpgdadatong.com/solution/detail/73994"
        self.refer = (
            "https://www.wpgdadatong.com/campus-channel/YOSUN-CampusHack?type=article"
        )
        self.playwright = sync_playwright().start()
        self.browser = self.playwright.chromium.launch(
            chromium_sandbox=False,
            headless=True,
            proxy={"server": self.proxy},
            args=[
                f"--user-agent={user_agent}",
                "--disable-dev-shm-usage",
                "--window-size=1920,1080",
            ],
        )
        self.page = self.browser.new_page()
        stealth_sync(self.page)

    def visit(self):
        self.page.goto(self.url)
        for i in range(15):
            self.page.mouse.wheel(0, 500 * random())
            time.sleep(random())
        self.page.mouse.wheel(0, 2000)
        time.sleep(1)
        if share_btn := self.page.query_selector("#share-btn"):
            share_btn.click()
            if copy_btn := self.page.query_selector("#url-copy-link-button"):
                copy_btn.click()
        time.sleep(1)
        self.page.context.clear_cookies()


if __name__ == "__main__":
    bot = Bot()
    for i in range(randint(1,5)):
        bot.visit()
    bot.browser.close()
