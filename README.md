# PetStore API Testing Project

## Overview
This project is an API testing suite for the PetStore API (`https://petstore.swagger.io/v2/pet`) as part of the Siemens onboarding tasks. It uses Python with `pytest`to test CRUD operations (Create, Read, Update, Delete) on pet resources. The tests are implemented in `test_pet_api.py`, with helper utilities in `helper/utils.py`.

## Project Structure
```
api_testing_onboarding/python
│   README.md               # Project documentation
│   requirements.txt        # Python dependencies
├───tests
│   │   test_pet_api.py     # Test suite for PetStore API
│   ├───.pytest_cache       # pytest cache (auto-generated)
│   └───__pycache__         # Python bytecode cache
├───utils
│   │   utils.py            # Helper functions and constants
│   │   __init__.py         # Marks utils as a Python package
│   └───__pycache__         # Python bytecode cache
└───__pycache__             # Python bytecode cache
```

### Key Files
- **tests/test_pet_api.py**: Contains the `PetStoreTestSuite` with five test cases:
  - `test_case_add_pet`: Creates a pet via POST.
  - `test_case_get_pet`: Retrieves the pet via GET.
  - `test_case_update_pet`: Updates the pet via PUT.
  - `test_case_delete_pet`: Deletes the pet via DELETE.
- **helpers/utils.py**: Defines:
  - `PET_ENDPOINT`: The API base URL (`https://petstore.swagger.io/v2/pet`).
  - `NEW_PET`: A global dictionary to store pet data.
  - `create_pet_payload`: A function to generate a pet payload with fields like `id`, `category`, `name`, `photoUrls`, `tags`, and `status`.
  - `create_pet_payload`: A function to generate a pet payload with fields like `id`, `category`, `name`, `photoUrls`, `tags`, and `status`.

- **requirements.txt**: Lists dependencies (e.g., `requests`, `pytest`, `pytest-order`).

## Prerequisites
- Python 3.13.3 or higher
- pip (Python package manager)
- Internet access (to interact with the PetStore API)
- Install the requirements file

## Setup Instructions
1. **Clone the Repository** (if applicable):
   ```bash
   git clone "https://github.com/Fathi79/onboarding-tasks"
   git checkout api-testing-python
   cd api-testing-onboarding/python
   ```

2. **Create a Virtual Environment** (recommended):
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install Dependencies**:
   ```bash
   pip install -r requirements.txt
   ```
   Expected dependencies (based on test output):
   - `requests`
   - `pytest==8.3.5`
   - `pytest-order==1.3.0`
   - `pytest-xdist==3.6.1`

4. **Verify Setup**:
   Ensure the `utils` package is accessible by running:
   ```bash
   python -c "from helper.utils import PET_ENDPOINT; print(PET_ENDPOINT)"
   ```
   Output: `https://petstore.swagger.io/v2/pet`

## Running the Tests
1. **Navigate to the Project Directory**:
   ```bash
   cd onboarding-tasks\api_testing_onboarding\python
   ```

2. **Run Tests with pytest**:
   ```bash
   python -m pytest tests\test_pet_api.py -v
   ```
   The `-v` flag provides verbose output, including test names and statuses.

##  Running using Docker
   * After navigating to python folder run the following commands
   ```bash
      docker build -t petstore-api-tests
      docker run --rm petstore-api-tests
   ```


## Known Issues
- **API Persistence**: The PetStore API may not reliably persist pets created via `POST`, leading to 404 errors in `test_case_get_pet`.
