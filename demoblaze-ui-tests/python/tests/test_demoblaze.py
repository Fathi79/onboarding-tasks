import time
from selenium import webdriver
from ..utils.utils import ITEM_NAME, EXPECTED_DESCRIPTION, EXPECTED_PRICE
from ..pages.demoblaze_page import DemoblazePage
from selenium.webdriver.chrome.options import Options

options = Options()
# options.add_argument("--headless")  # if running in headless mode
# options.add_argument("--no-sandbox")
# options.add_argument("--disable-dev-shm-usage")
# options.add_argument("--remote-debugging-port=9222")
# options.add_argument("--user-data-dir=/tmp/chrome-profile")



def test_demoblaze_items():
    driver = webdriver.Chrome(options=options)
    driver.maximize_window()

    try:
        page = DemoblazePage(driver)
        page.open()

        total = page.count_all_items()
        assert total == 15, f"Expected 15 items but got {total}"

        page.open()  # reload home
        page.go_to_phone_section()
        page.click_item_by_name(ITEM_NAME)
        desc, price = page.get_item_details()
        assert desc == EXPECTED_DESCRIPTION, "Description mismatch"
        assert price == EXPECTED_PRICE, "Price mismatch"

    finally:
        time.sleep(2)
        driver.quit()
