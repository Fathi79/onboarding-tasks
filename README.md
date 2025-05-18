# PetStore API Testing Project

## Overview
This project is an API testing suite for the PetStore API (`https://petstore.swagger.io/v2/pet`) as part of the Siemens onboarding tasks. It uses Python with `pytest` and `unittest` to test CRUD operations (Create, Read, Update, Delete) on pet resources. The tests are implemented in `test_pet_api.py`, with helper utilities in `utils/utils.py`.

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
  - `test_case_verify_pet_deleted`: Verifies deletion with a GET (expects 404).
- **utils/utils.py**: Defines:
  - `PET_ENDPOINT`: The API base URL (`https://petstore.swagger.io/v2/pet`).
  - `NEW_PET`: A global dictionary to store pet data.
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
   git clone <repository-url>
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
   python -c "from utils.utils import PET_ENDPOINT; print(PET_ENDPOINT)"
   ```
   Output: `https://petstore.swagger.io/v2/pet`

## Running the Tests
1. **Navigate to the Project Directory**:
   ```bash
   cd Siemens_OnBoardingTasks\api_testing_onboarding\python
   ```

2. **Run Tests with pytest**:
   ```bash
   pytest tests\test_pet_api.py -v
   ```
   The `-v` flag provides verbose output, including test names and statuses.

3. **Run Tests with unittest** (alternative):
   ```bash
   python tests\test_pet_api.py
   ```

## Known Issues
- **API Persistence**: The PetStore API may not reliably persist pets created via `POST`, leading to 404 errors in `test_case_get_pet`.
- **DELETE Operation**: The `DELETE` request often fails to remove the pet, causing `test_case_verify_pet_deleted` to return 200 instead of 404.
- **Response Structure**: The API responses lack a top-level `'name'` field, despite the request payload including it. Tests have been adjusted to avoid `KeyError` by checking other fields (e.g., `id`, `status`).
- **Workarounds**:
  - Use a random `pet_id` to avoid conflicts (not implemented in the current code).
  - Add retries for `GET` and `DELETE` requests to handle API delays.
  - Mock the API using the `responses` library if reliability issues persist.

