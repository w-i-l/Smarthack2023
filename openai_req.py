from openai import OpenAI
client = OpenAI()

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

getActivityDomains("El Salvador")


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

# getSustScore()