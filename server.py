import flask
import get_ranks
import openai_req

app = flask.Flask(__name__)
# app.config["DEBUG"] = True

base_api_route = "/api/v1"

@app.route('/', methods=['GET'])
def home():
    return "Hello world!"

@app.route(f'{base_api_route}/get_all_countries', methods=['GET'])
def get_country():
    return flask.jsonify(get_ranks.get_all_ranks())

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
    return openai_req.getBestActivityDomains()

app.run()