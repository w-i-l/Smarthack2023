
import requests
import json

def get_company_details(name: str, address: str):
    url = 'https://data.veridion.com/match/v4/companies'

    headers = {
        'x-api-key': 'Lk34BnMBMFDj07xGbkQ_aNikeD4_NSKq643WxEEuQUAcjtbrVJStX9FpASw7',
        'Content-type': 'application/json'
    }

    payload = json.dumps({
        "commercial_names": [name],
        "phone_number": "",
        "address_txt": address
    })

    response = requests.post(url, headers=headers, json=payload, data=payload)

    return response.json()

if __name__ == "__main__":
    print(get_company_details("Factset", "USA"))
                