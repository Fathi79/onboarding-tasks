import sys
import os

# Add the root project folder to sys.path for absolute imports to work
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import pytest
import requests
import random

from helper.utils import PET_ENDPOINT, NEW_PET, create_pet_payload, create_pet


@pytest.fixture
def unique_pet():
    """Returns a new pet payload with a unique ID."""
    pet_data = NEW_PET.copy()
    pet_data["id"] = random.randint(1, 10000)
    return pet_data


def test_case_add_pet(unique_pet):
    """
    Test creating a new pet and verifying the response matches the request.
    """
    response = create_pet(unique_pet)
    assert response.status_code == 200, f"Expected 200 OK, got {response.status_code}: {response.text}"
    assert response.json() == unique_pet, f"Expected pet data {unique_pet}, got {response.json()}"


def test_case_get_pet(unique_pet):
    """
    Test retrieving a pet after creation and verifying data consistency.
    """
    create_response = create_pet(unique_pet)
    assert create_response.status_code == 200, f"Create failed: {create_response.status_code} - {create_response.text}"

    get_response = requests.get(f"{PET_ENDPOINT}/{unique_pet['id']}")
    assert get_response.status_code == 200, f"Get failed: {get_response.status_code} - {get_response.text}"
    assert get_response.json() == unique_pet, f"Expected pet {unique_pet}, got {get_response.json()}"


def test_case_update_pet(unique_pet):
    """
    Test updating an existing pet and verifying the updated fields.
    """
    create_response = create_pet(unique_pet)
    assert create_response.status_code == 200, f"Create failed: {create_response.status_code} - {create_response.text}"

    updated_pet = create_pet_payload(
        pet_id=unique_pet['id'],
        category_id=0,
        category_name="dogs",
        pet_name="bero_updated",
        photo_url="https://example.com/photo.jpg",
        tag_id=1,
        tag_name="dog1",
        status="sold"
    )

    update_response = requests.put(PET_ENDPOINT, json=updated_pet)
    assert update_response.status_code == 200, f"Update failed: {update_response.status_code} - {update_response.text}"
    assert update_response.json() == updated_pet, f"Expected updated pet {updated_pet}, got {update_response.json()}"


def test_case_delete_pet(unique_pet):
    """
    Test deleting a pet and confirming it no longer exists.
    """
    create_response = create_pet(unique_pet)
    assert create_response.status_code == 200, f"Create failed: {create_response.status_code} - {create_response.text}"

    delete_response = requests.delete(f"{PET_ENDPOINT}/{unique_pet['id']}")
    assert delete_response.status_code == 200, f"Delete failed: {delete_response.status_code} - {delete_response.text}"

    verify_response = requests.get(f"{PET_ENDPOINT}/{unique_pet['id']}")
    assert verify_response.status_code == 404, f"Expected 404 for deleted pet, got {verify_response.status_code}"
    assert verify_response.json().get("message") == "Pet not found", \
        f"Expected 'Pet not found' message, got {verify_response.json()}"
