"""
This File will Contain Helper Functions For all Test Cases
ALong with the GLOBAL_VARIABLES
"""

BASE_URL = "https://petstore.swagger.io/v2"
NEW_PET={}
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