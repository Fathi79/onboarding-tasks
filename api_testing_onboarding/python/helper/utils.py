"""
This File will Contain Helper Functions For all Test Cases
ALong with the GLOBAL_VARIABLES
"""
import requests


BASE_URL = "https://petstore.swagger.io/v2"

PET_ENDPOINT = f"{BASE_URL}/pet"

#Helper Functions
def create_pet_payload(pet_id,category_id,category_name,pet_name,photo_url,tag_id,tag_name,status):
    return {
        "id": pet_id,
        "category":{
            "id": category_id,
            "name": category_name
        },
        "photoUrls": [photo_url],
        "tags":[
            {
                "id": tag_id,
                "name": tag_name
            }
        ],
        "status": status
    }


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


def create_pet(pay_load):
    return requests.post(PET_ENDPOINT, json=pay_load)