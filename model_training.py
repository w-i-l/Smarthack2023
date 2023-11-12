#
# Aici n aveti treaba
#

import requests
import yfinance as yf
import numpy as np
import statsmodels.api as sm
import itertools
from keras.models import Sequential
from keras.layers import Dense
from keras.optimizers import Adam
from sklearn.preprocessing import MinMaxScaler

class Company:
    def __init__(self, companyName, mainCountry, yearFounded, employeeCount, estimatedRevenue, numLocations, companyType):
        self.companyName = companyName
        self.mainCountry = mainCountry
        self.yearFounded = yearFounded
        self.employeeCount = employeeCount
        self.estimatedRevenue = estimatedRevenue
        self.numLocations = numLocations
        self.companyType = companyType
        self.rank = 0
        self.companyTicker = ""

companies = []

locations = [""]
categories = ["Finance", "IT"]

url = 'https://data.soleadify.com/search/v2/companies'

headers = {
    'x-api-key': 'pXStedvXkA9pMcNK1tWvx_4DesmTsIZ47qfTa6WkqFxgrCvCqJA0mpALQ53J',
    'Content-Type': 'application/json'
}

json = {
    "filters": {
        "and": [
            # {
            #     "attribute": "company_industry",
            #     "relation": "in",
            #     "value": []
            # }
            {
                "attribute": "company_employee_count",
                "relation": "greater_than_or_equal",
                "value": 0
            }
        ]
    }
}

def apiCall(nextToken, i):
    
    print(i)

    if i == 10:
        return

    response = ""

    if nextToken != "":

        response = requests.post(f"https://data.soleadify.com/search/v2/companies?pagination_token={nextToken}", json=json, headers=headers)
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
    if response.json()["pagination"]["next"] != "":
        i += 1
        apiCall(response.json()["pagination"]["next"], i)

apiCall("", i = 0)

for company in companies:
    try:
        yfinance = "https://query2.finance.yahoo.com/v1/finance/search"
        user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36'
        params = {"q": company.companyName, "quotes_count": 1, "country": "United States"}

        res = requests.get(url=yfinance, params=params, headers={'User-Agent': user_agent})
        data = res.json()

        try:
            company_code = data['quotes'][0]['symbol']
            company.companyTicker = company_code
        except:
            continue
    except:
        continue

for company in companies:
    try: 
        print(company.companyName)
    except:
        continue
    print(company.mainCountry)
    print(company.yearFounded)
    print(company.employeeCount)
    print(company.estimatedRevenue)
    print(company.numLocations)
    print(company.companyType)
    if company.companyTicker != "":
        print(company.companyTicker)
    print(" - - - ")

X_train = np.zeros((2, 4))
X_last = np.zeros((2, 4))

Y_train = np.zeros((2, 4))
Y_last = np.zeros((2, 4))

denseModel = Sequential()

denseModel.add(Dense(units = 32, input_dim = 4, activation = 'sigmoid'))
denseModel.add(Dense(units = 16, activation = 'sigmoid'))
denseModel.add(Dense(units = 8, activation = 'sigmoid'))
denseModel.add(Dense(units = 4, activation = 'linear'))

customOptimizer = Adam(lr = 1)
denseModel.compile(optimizer = customOptimizer, loss = 'mean_squared_error', metrics = ['accuracy'])

dataSize = 0

for company in companies:

    if company.companyTicker != "":

        data = yf.download(company.companyTicker, period = "1y", interval = "1mo")

        data = data.drop("Open", axis = 1)
        data = data.drop("High", axis = 1)
        data = data.drop("Low", axis = 1)
        data = data.drop("Adj Close", axis = 1)
        data = data.drop("Volume", axis = 1)

        np.random.seed(42)
        y = np.random.rand(100)
        best_aic = np.inf
        best_order = None

        if len(data.values) > 10:

            armaModel = sm.tsa.ARIMA(data.values, order = (1, 0, 1)).fit()

            X_last[1] = X_train[1]
            Y_last[1] = Y_train[1]

            X_train[1] = np.array([company.yearFounded / 2000, company.employeeCount / 100000, company.estimatedRevenue / 1000000000000, company.numLocations / 500])
            Y_train[1] = armaModel.params

            denseModel.fit(
                X_train,
                Y_train,
                epochs = 1000
            )

            denseModel.save("model2.keras")

print(denseModel.predict(X_last[1:]))
print(Y_last[1:])

