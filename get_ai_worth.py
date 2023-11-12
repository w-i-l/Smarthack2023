from keras.models import Sequential
from keras.layers import Dense
from keras.models import load_model
import numpy as np
import requests
from sympy import solve, nroots, I
from sympy.abc import k

# aici puteti sa mai adaugati chestii, dar nu sa stergeti
class Company:
    def __init__(self, companyName, mainCountry, yearFounded, employeeCount, estimatedRevenue, numLocations, companyType):
        self.companyName = companyName
        self.mainCountry = mainCountry
        self.yearFounded = yearFounded
        self.employeeCount = employeeCount
        self.estimatedRevenue = estimatedRevenue
        self.numLocations = numLocations
        self.companyType = companyType
        self.companyTicker = ""
        self.companyPotential = 0

companies = []

def apiCall(nextToken, headers, json):

    response = ""

    if nextToken != "":

        response = requests.post(f"https://data.soleadify.com/search/v2/companies?pagination_token={nextToken}", json=json, headers=headers)
        if response.status_code == 200:
            print("ok")
            for company in response.json()["result"]:
                companies.append(
                    Company(
                        companyName = company["company_name"],
                        mainCountry = company["main_country"],
                        yearFounded = company["year_founded"],
                        employeeCount = company["employee_count"],
                        estimatedRevenue = company["estimated_revenue"],
                        numLocations = company["num_locations"],
                        companyType = company["company_type"]
                    )
                )

    if nextToken == "":

        response = requests.post("https://data.soleadify.com/search/v2/companies", json=json, headers=headers)
        if response.status_code == 200:
            print("ok")
            for company in response.json()["result"]:
                companies.append(
                    Company(
                        companyName = str(company["company_name"]),
                        mainCountry = company["main_country"],
                        yearFounded = company["year_founded"],
                        employeeCount = company["employee_count"],
                        estimatedRevenue = company["estimated_revenue"],
                        numLocations = company["num_locations"],
                        companyType = company["company_type"]
                    )
                )
    if response == 200 and response.json()["pagination"]["next"] != "":
        apiCall(response.json()["pagination"]["next"], headers = headers, json = json)

def getAiWorth(country, industries):

    url = 'https://data.soleadify.com/search/v2/companies'

    headers = {
        'x-api-key': 'pXStedvXkA9pMcNK1tWvx_4DesmTsIZ47qfTa6WkqFxgrCvCqJA0mpALQ53J',
        'Content-Type': 'application/json'
    }

    json = {
        "filters": {
            "and": [
                {
                    "attribute": "company_industry",
                    "relation": "in",
                    "value": industries
                },
                {
                "attribute": "company_location",
                "relation": "equals",
                "value": {
                    "country": country
                    }
                }
            ]
        }
    }

    apiCall("", headers = headers, json = json)

    denseModel = load_model("modelv2.keras")

    worthCompanies = []
    for company in companies:

        try:

            X_data = np.zeros((2, 4))
            X_data[1] = np.array([company.yearFounded / 2000, company.employeeCount / 100000, company.estimatedRevenue / 1000000000000, company.numLocations / 500])

            Y_data = denseModel.predict(X_data[1:])

            roots = nroots(Y_data[0][0]*k**3 + Y_data[0][1]*k**2 - Y_data[0][2]*k**1 + Y_data[0][3]*k**0)

            count = 0
            mean = 0
            for root in roots:
                count +=1
                mean += abs(root)
            mean /= count
            company.companyPotential = mean

            print(company.companyName)
            print(company.companyPotential)

        except:
            continue
        
    return companies # returneaza o lista de companii cu un potential. = 1 nu creste, > 1 creste, < 1 scade
