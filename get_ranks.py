import json

def load_weights():
    with open("economical_weights.json", "r") as f:
        data = json.load(f)
    return data

def load_data():
    with open("all_countries_parsed.json", "r") as f:
        data = json.load(f)
    return data

def convert_string_data_to_float(data):

    if data == "N/A" or data == "":
        return 0

    data = data.strip()
    data = data.replace(",", "")
    data = data.replace("(", "")
    data = data.replace(")", "")

    try:
        data = float(data)
    except ValueError:
        data = 0
    return data

def get_ranks_for_country():

    output = {}

    countries_data = load_data()
    weights = load_weights()

    for country in countries_data:
        print(f"Getting ranks for {country}...")
        country_data = countries_data[country]

        if country_data == {}:
            print("No data for this country!")
            continue

        rank = 0

        for key in country_data:

            # Calculate average
            # weights[key] = 1
            average = 0
            for year in country_data[key]:
                
                average += convert_string_data_to_float(country_data[key][year])
            
            if average != 0:
                average /= len(country_data[key])

            if key in weights:
                value = 0 if country_data == "N/A" else average
                rank += value * weights[key]

        if rank != 0:
            output[country] = rank
    
    json.dump(output, open("ranks.json", "w+"))
    return output

if __name__ == "__main__":
    result = get_ranks_for_country()
    print(result)