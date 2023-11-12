from openai import OpenAI
<<<<<<< HEAD
client = OpenAI(api_key="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")
=======
client = OpenAI()
>>>>>>> 758bd7170bb6bc55ce98562267dcd9430f417bb0

def getActivityDomains(country = "Romania"):
    user_prompt = "Based on this country name: " + country + "what are the most profitable activity domains of local businesses to invest in? Give me only the name for the top 5 results in alphabetical order."
    response = client.chat.completions.create(
        model="gpt-4-1106-preview",
        response_format={ "type": "json_object" },
        messages=[
            {"role": "system", "content": "You are a smart business analyst making a recommendation to a beginner invester, you will get a country name and you have to answer as JSON. The answer shall be placed in a property called 'activity_domains' and it shall be an array of strings."},
            {"role": "user", "content": user_prompt}
        ]
    )
    print(response.choices[0].message.content)
    return response.choices[0].message.content

# getActivityDomains("Romania")


def getSustScore(companyName = "Microsoft"): 
    user_prompt = "Based on this company name: " + companyName + "how sustainable is this company? Score it from 0 to 100, where 0 is not sustainable at all and 100 is very sustainable."
    response = client.chat.completions.create(
        model="gpt-4-1106-preview",
        response_format={ "type": "json_object" },
        messages=[
            {"role": "system", "content": "You are a smart business analyst making a recommendation to a beginner invester, you will get a company name. Answer in JSON format. The answer shall be placed in a property called 'sustainability_score'."},
            {"role": "user", "content": "Based on this company name: Microsoft, how sustainable is this company? Score it from 0 to 100, where 0 is not sustainable at all and 100 is very sustainable."}
        ]
    )
    print(response.choices[0].message.content)
    return response.choices[0].message.content

# getSustScore("China Communications Services")

import requests
import json

from multiprocessing import Pool
from concurrent.futures import ProcessPoolExecutor

def get_sust_score_filtered(location, activity_domain):
    url = "https://data.soleadify.com/search/v2/companies?page_size=100"

    payload = json.dumps({
    "filters": {
        "and": [
        {
            "attribute": "company_location",
            "relation": "equals",
            "value": {
            "country": location
            }
        },
        {
            "attribute": "company_category",
            "relation": "in",
            "value": activity_domain
        }
        ]
    }
    })
    headers = {
    'x-api-key': 'pXStedvXkA9pMcNK1tWvx_4DesmTsIZ47qfTa6WkqFxgrCvCqJA0mpALQ53J',
    'Content-type': 'application/json'
    }

    response = requests.request("POST", url, headers=headers, data=payload)

    json_response = json.loads(response.text)

    companies = json_response["result"]
    pool = Pool(6)
    results = pool.map(getSustScore, [company["company_name"] for company in companies if company["company_type"] == "Public"])
    pool.close()

    return results
