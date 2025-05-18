# Demoblaze UI Tests (Robot Framework)

This project is a UI test suite built with **Robot Framework** and **SeleniumLibrary** to validate the functionality of the [Demoblaze](https://www.demoblaze.com/) website. It includes automated tests for verifying product listings, navigation, and item details such as descriptions and prices.

---

## 🗂 Project Structure

```
demoblaze-ui-tests/
├── reports/                    # Stores generated Robot Framework test reports (log.html, report.html, output.xml)
├── resources/
│   └── resources.robot         # Shared keywords, variables, browser setup and teardown
├── tests/
│   └── test_demoblaze.robot   # Main test suite
├── requirements.txt           # Python dependencies
└── README.md                  # Project documentation (this file)
```

---

## 📋 Prerequisites

- Python 3.8+
- Google Chrome or Microsoft Edge installed
- ChromeDriver or EdgeDriver available in PATH

Install the required Python libraries:

```bash
pip install -r requirements.txt
```

---

## 🚀 Running the Tests

Make sure you're in the `robot` directory (the root of this project):

```bash
cd demoblaze-ui-tests/robot
```

Run the test suite and output reports to the `reports/` directory:

```bash
robot --outputdir reports tests/test_demoblaze.robot
```

Or, if using PyCharm, ensure the Run/Debug Configuration includes:

```
--outputdir reports tests/test_demoblaze.robot
```

---

## 📄 Viewing the Results

After running the tests, open the report files in the `reports/` directory:

- `report.html` — High-level test summary
- `log.html` — Detailed execution log
- `output.xml` — Raw result file (for CI or integrations)

---

## 🧠 What’s Tested?

### ✅ `Verify Total Item Count Across All Pages`
- Navigates through all catalog pages
- Counts total number of item cards
- Asserts that the total equals `15`

### ✅ `Verify Item Description and Price`
- Selects a specific item (`HTC One M9`)
- Verifies the description and price match expected values

---

## 🔧 Customization

### Changing Browser
By default, tests open in **Chrome** using:

```robot
Create Webdriver    Chrome
```

To use headless mode or another browser (e.g. Edge), modify the `resources.robot` file or override keywords like `Open Edge On Landing Page`.

---

## 🤝 Contributing

Feel free to fork and improve the test suite! Add new test cases under `tests/`, and shared logic/keywords in `resources/`.

---

## 📦 Dependencies

- [Robot Framework](https://robotframework.org/)
- [SeleniumLibrary](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)

Install with:

```bash
pip install -r requirements.txt
```

---

## 🧪 Example Variables (in `resources.robot`)

- `${item_name}` — `HTC One M9`
- `${expected_price}` — `$700`
- `${expected_description}` — Full text description

These can be adjusted to validate different products.

---

## 📬 Contact

Created by Fathi for Siemens onboarding tasks.
Feel free to reach out or customize this suite for your own automation practice.