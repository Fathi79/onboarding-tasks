from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.wait import WebDriverWait

from selenium.common.exceptions import NoSuchElementException

import time

class DemoblazePage:
    def __init__(self, driver):
        self.driver = driver
        self.url = "https://www.demoblaze.com/index.html"
        self.locators = {
            "cat_icon": (By.ID, "cat"),
            "item_cards": (By.XPATH, "//div[@class='col-lg-4 col-md-6 mb-4']"),
            "next_button": (By.ID, "next2"),
            "phone_tab": (By.XPATH, "//a[contains(text(), 'Phones')]"),
            "item_description": (By.XPATH, "//div[@id='more-information']/p"),
            "item_price": (By.CSS_SELECTOR, "h3.price-container"),
        }

    def open(self):
        self.driver.get(self.url)
        WebDriverWait(self.driver, 10).until(expected_conditions.presence_of_element_located(self.locators["cat_icon"]))

    def go_to_phone_section(self):
        WebDriverWait(self.driver, 10).until(expected_conditions.presence_of_element_located(self.locators["phone_tab"]))
        phone_tab = self.driver.find_element(*self.locators["phone_tab"])
        phone_tab.click()
        time.sleep(3)

    def count_all_items(self):
        total_items = []
        while True:
            items = self.driver.find_elements(*self.locators["item_cards"])
            total_items.extend(items)
            try:
                next_btn = self.driver.find_element(*self.locators["next_button"])
                if not next_btn.is_displayed():
                    break
                next_btn.click()
                time.sleep(2)
            except NoSuchElementException:
                break
        return len(total_items)

    def click_item_by_name(self, item_name):
        normalized = item_name.lower().strip()
        found = False
        while not found:
            items = self.driver.find_elements(*self.locators["item_cards"])
            for index, item in enumerate(items, 1):
                title_xpath = f"(//div[@class='col-lg-4 col-md-6 mb-4'])[{index}]//h4/a"
                title = self.driver.find_element(By.XPATH, title_xpath).text.strip().lower()
                if normalized in title:
                    self.driver.find_element(By.XPATH, title_xpath).click()
                    found = True
                    break
            if not found:
                try:
                    next_btn = self.driver.find_element(*self.locators["next_button"])
                    if next_btn.is_displayed():
                        next_btn.click()
                        time.sleep(2)
                    else:
                        raise Exception(f"Item '{item_name}' not found.")
                except NoSuchElementException:
                    raise Exception(f"Item '{item_name}' not found.")

    def get_item_details(self):
        WebDriverWait(self.driver,10).until(expected_conditions.presence_of_element_located(self.locators["item_description"]))
        desc_elem = self.driver.find_element(*self.locators["item_description"])
        WebDriverWait(self.driver,10).until(expected_conditions.presence_of_element_located(self.locators["item_price"]))
        price_elem = self.driver.find_element(*self.locators["item_price"])
        return desc_elem.text.strip(), price_elem.text.strip().split(" ")[0]
