# Demoblaze UI Tests

Python-based UI tests for the [Demoblaze](https://www.demoblaze.com) website using Selenium WebDriver and pytest.

## Prerequisites
- **Python**: 3.11+ (tested with 3.13.3)
- **Google Chrome**: Latest stable version
- **Git**: For cloning the repository
- **PyCharm**: Optional (Community or Professional edition)
- **Internet Connection**: For accessing https://www.demoblaze.com

## Setup Instructions

### Terminal
1. Clone the repository and navigate to the module:
   ```bash
   git clone "https://github.com/Fathi79/onboarding-tasks"
   git checkout ui-testing-python
   cd demoblaze-ui-tests/python/tests
   ```
2. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   # Windows
   .\venv\Scripts\activate
   # macOS/Linux
   source venv/bin/activate
   ```
3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

## Run Using Docker
* Navigate to python folder, open command line and run this commands

```bash
    docker build -m ui-python-tests .
    docker run --rm ui-python-tests
```


## Running Tests
- **Terminal**:
  ```bash
  python -m pytest tests/test_demoblaze.py 
  ```
