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
   git clone <repository-url>
   cd Siemens_OnBoardingTasks/demoblaze-ui-tests/python
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

### PyCharm
1. Open `Siemens_OnBoardingTasks/demoblaze-ui-tests/python/` in PyCharm.
2. Configure the Python interpreter:
   - Go to `File > Settings > Project: python > Python Interpreter`.
   - Add an existing virtual environment: `venv\Scripts\python.exe` (Windows) or `venv/bin/python` (macOS/Linux).
3. Mark as Sources Root:
   - Right-click `demoblaze-ui-tests/python/` in Project view > `Mark Directory as > Sources Root`.
4. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
   Or use PyCharm’s interpreter settings to install `selenium`, `pytest`, and `webdriver-manager`.

## Running Tests
- **Terminal**:
  ```bash
  pytest tests/test_demoblaze.py -v
  ```
- **PyCharm**:
  Right-click `tests/test_demoblaze.py` > `Run 'pytest in test_demoblaze.py'`.