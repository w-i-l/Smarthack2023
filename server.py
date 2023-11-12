import flask
import get_ranks
import openai_req
import get_company
# import get_ai_worth

app = flask.Flask(__name__)
# app.config["DEBUG"] = True

base_api_route = "/api/v1"

@app.route('/', methods=['GET'])
def home():
    return "Hello world!"

@app.route(f'{base_api_route}/get_worth_investing', methods=['GET'])
def get_worth():
    params = flask.request.args.to_dict()
    if "country" not in params:
        return "No country specified!"
    if "industries" not in params:
        return "No industry specified!"
    country = params["country"]
    industries = params["industries"]
    return get_ai_worth.getAiWorth(country, industries)

@app.route(f'{base_api_route}/get_all_countries', methods=['GET'])
def get_country():
    return {"countries": [list(get_ranks.get_all_ranks().keys())]}

@app.route(f'{base_api_route}/get_countries_with_ranks', methods=['GET'])
def get_countries_with_ranks():
    params = flask.request.args.to_dict()
    sorting_order = True if "sorting_order" in params and params["sorting_order"] == "ascending" else False
    if "count" not in params:
        return get_ranks.get_all_ranks(sorting_order)
    else:
        count = int(params["count"])
        return get_ranks.get_fist_n_ranks(count, sorting_order)
    
@app.route(f'{base_api_route}/get_activity_domains', methods=['GET'])
def get_activity_domains():
    params = flask.request.args.to_dict()
    if "country" not in params:
        return "No country specified!"
    country = params["country"]
    return openai_req.getActivityDomains(country)

@app.route(f'{base_api_route}/get_sustainability_score', methods=['GET'])
def get_sustainability_score():
    params = flask.request.args.to_dict()
    if "company" not in params:
        return "No company specified!"
    company = params["company"]
    return openai_req.getSustScore(company)

@app.route(f'{base_api_route}/get_best_activity_domains', methods=['GET'])
def get_best_activity_domains():
    return openai_req.getActivityDomains()

@app.route(f'{base_api_route}/get_best_sustenability_score', methods=['Get'])
def get_best_sustainability_score():
    params = flask.request.args.to_dict()
    if "activity_domain" not in params:
        return "No activity_domain specified!"
    if "location" not in params:
        return "No location specified!"
    activity_domain = params["activity_domain"]
    location = params["location"]
    print(activity_domain, location)
    return openai_req.get_sust_score_filtered(location, activity_domain)

@app.route(f'{base_api_route}/temp_get_companies', methods=['Get'])
def get_temp_companies():
    params = flask.request.args.to_dict(flat=True)
    if "activity_domain" not in params:
        return "No activity_domain specified!"
    if "location" not in params:
        return "No location specified!"
    activity_domain = params["activity_domain"].split(",")
    location = params["location"]
    print(activity_domain, location)
    print(type(activity_domain), type(location))
    return openai_req.get_sust_score_filtered(location, activity_domain)

@app.route(f'{base_api_route}/get_company_details', methods=['GET'])
def get_company_details():
    params = flask.request.args.to_dict()
    if "company" not in params:
        return "No company specified!"
    if "location" not in params:
        return "No location specified!"
    company = params["company"]
    location = params["location"]
    return get_company.get_company_details(company, location)

app.run(port=8000)