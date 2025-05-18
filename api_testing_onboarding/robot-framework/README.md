# 🐾 Pet Store API Testing with Robot Framework

This project demonstrates automated testing of the [Swagger Petstore API](https://petstore.swagger.io/) using **Robot Framework** and the **RequestsLibrary**. It includes test cases to **add**, **retrieve**, **update**, and **delete** a pet.

---

## 📁 Project Structure

```
.
├── README.md                # Project documentation
├── requirements.txt         # Required Python dependencies
├── resources/
│   └── keywords.robot       # Reusable keywords and global variables
├── tests/
│   └── pet_api_tests.robot  # Main API test cases
└── results/                 # Test execution logs and reports
```

---

## 📦 Requirements

Make sure Python is installed. Then install dependencies with:

```bash
pip install -r requirements.txt
```

Required libraries:

- `robotframework`
- `robotframework-requests`
- `robotframework-seleniumlibrary` (if needed for browser automation)

---

## 🚀 How to Run Tests

To execute the tests, run the following command in your terminal from the project root:

```bash
robot tests/
```

Test results will be saved in the `results/` folder, including:
- `report.html`
- `log.html`
- `output.xml`

---

## 💡 Notes

- All reusable keywords and variables are stored in `resources/keywords.robot`.
- Make sure the API endpoint `${BASE_URL}` is accessible before running the tests.