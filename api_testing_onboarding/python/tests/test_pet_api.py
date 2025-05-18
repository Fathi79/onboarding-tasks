import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import unittest
import pytest
import requests
from time import sleep
from utils.utils import PET_ENDPOINT, NEW_PET, create_pet_payload

class PetStoreTestSuite(unittest.TestCase):

    @pytest.mark.order(1)
    def test_case_add_pet(self):
        global NEW_PET  # Modify global NEW_PET
        NEW_PET = create_pet_payload(
            pet_id=9996,
            category_id=0,
            category_name="dogs",
            pet_name="bero",
            photo_url="https://example.com/photo.jpg",
            tag_id=1,
            tag_name="dog1",
            status="available"
        )
        response = requests.post(url=PET_ENDPOINT, json=NEW_PET)
        print(f"POST Response: {response.status_code}, {response.json()}")  # Debug response
        self.assertEqual(response.status_code, 200, f"Expected 200, got {response.status_code}: {response.text}")
        self.assertEqual(response.json()['id'], NEW_PET['id'])
        self.assertEqual(response.json()['status'], NEW_PET['status'])
        sleep(2)

    @pytest.mark.order(2)
    def test_case_get_pet(self):
        print(f"NEW_PET: {NEW_PET}")
        response = requests.get(url=f"{PET_ENDPOINT}/{NEW_PET['id']}")
        print(f"GET Response: {response.status_code}, {response.json()}")  # Debug response
        self.assertEqual(response.status_code, 200, f"Expected 200, got {response.status_code}: {response.text}")
        self.assertEqual(response.json()['id'], NEW_PET['id'])

    @pytest.mark.order(3)
    def test_case_update_pet(self):
        updated_pet = create_pet_payload(
            pet_id=NEW_PET['id'],
            category_id=0,
            category_name="dogs",
            pet_name="bero_updated",
            photo_url="https://example.com/photo.jpg",
            tag_id=1,
            tag_name="dog1",
            status="sold"
        )
        response = requests.put(url=PET_ENDPOINT, json=updated_pet)
        print(f"PUT Response: {response.status_code}, {response.json()}")  # Debug response
        self.assertEqual(response.status_code, 200, f"Expected 200, got {response.status_code}: {response.text}")
        self.assertEqual(response.json()['status'], "sold")


    @pytest.mark.order(4)
    def test_case_delete_pet(self):
        response = requests.delete(url=f"{PET_ENDPOINT}/{NEW_PET['id']}")
        print(f"DELETE Response: {response.status_code}, {response.text}")  # Debug response
        self.assertEqual(response.status_code, 200, f"Expected 200, got {response.status_code}: {response.text}")

    @pytest.mark.order(5)
    def test_case_verify_pet_deleted(self):
        response = requests.get(url=f"{PET_ENDPOINT}/{NEW_PET['id']}")
        print(f"VERIFY DELETE Response: {response.status_code}, {response.text}")  # Debug response
        self.assertEqual(response.status_code, 404, f"Expected 404, got {response.status_code}: {response.text}")
        self.assertIn("Pet not found", response.text)

if __name__ == "__main__":
    suite = unittest.TestSuite()
    suite.addTest(PetStoreTestSuite('test_case_add_pet'))
    suite.addTest(PetStoreTestSuite('test_case_get_pet'))
    suite.addTest(PetStoreTestSuite('test_case_update_pet'))
    suite.addTest(PetStoreTestSuite('test_case_delete_pet'))
    suite.addTest(PetStoreTestSuite('test_case_verify_pet_deleted'))

    runner = unittest.TextTestRunner()
    runner.run(suite)