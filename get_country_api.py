from googlesearch import search
import requests
from bs4 import BeautifulSoup
from time import sleep
import asyncio
from pyppeteer import launch
from pyppeteer_stealth import stealth as pyppeteer_stealth
import pycountry
import json
from multiprocessing import Pool
from concurrent.futures import ProcessPoolExecutor


def get_url_from_webarchive(url: str) -> str:
    base_url = "https://webcache.googleusercontent.com/search"
    query = f"q=cache:{url}"
    return f"{base_url}?{query}"

def get_SandP_url_for_country(country: str = "Romania") -> str:
    try:
        query = f"s&p global transfer and convertibility risk {country} ratings affirmed outlook stable"
        result = next(search(query.strip(), num_results=1))
        return get_url_from_webarchive(result)
    except StopIteration:
        return "No results found"
    
async def get_page_content(url):
    browser = await launch(headless = True, args=['--no-sandbox', '--disable-setuid-sandbox', '--disable-gpu', '--disable-dev-shm-usage', '--disable-web-security', '--disable-features=IsolateOrigins,site-per-process'])
    page = await browser.newPage()
    await pyppeteer_stealth(page)

    try:
        # Navigate to the URL
        await page.setJavaScriptEnabled(enabled=True)
        await page.setUserAgent('Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/88.0.4324.96 Chrome/88.0.4324.96 Safari/537.36')
        await page.setBypassCSP(True)
        await page.goto(url, waitUntil='networkidle2')
        # Get the HTML content

        html_content = await page.content()
        soup = BeautifulSoup(html_content, 'html.parser')
        print("Parsing HTML...")

        return parse_html(soup)

    finally:
        # Close the browser
        await browser.close()

def parse_html(soup: BeautifulSoup) -> dict:

    table = soup.find('table', {'aria-describedby': 'Article Table'})

    table_formatted = {}

    # Check if the table is found
    if table:
        # Extract data from the table
        rows = table.find_all('tr')
        time_frame = list(map(lambda x: x.text.strip(), rows[1].find_all(['th', 'td'])[1:]))

        for row in rows[2:]:
            columns = row.find_all(['th', 'td'])
            table_formatted[columns[0].text.strip()] = {time_frame: col.text.strip() for col, time_frame in zip(columns[1:], time_frame)}

    else:
        print("Table not found on the page.")
    
    return table_formatted

async def main(url):
    page_content = await get_page_content(url)
    return page_content

def get_links_for_all_countries():
    countries = [country.name for country in pycountry.countries]
    pool = Pool(6)
    print("Getting links for all countries...")
    results = pool.map(get_SandP_url_for_country, countries)
    print("Done!")
    d = {country: url for country, url in zip(countries, results)}
    json.dump(d, open("all_countries.json", "w+"))
    print("Saved to file!")
    pool.close()

def run_async_function(url):
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    result = loop.run_until_complete(main(url))
    loop.close()
    return result

def parse_for_all_links():

    countries_urls = json.load(open("all_countries_links.json", "r"))

    print("Parsing for all links...")

    results = []

    with ProcessPoolExecutor() as executor:
        for country in countries_urls:
            link = countries_urls[country]
            print(f"Running for {country}...")
            future = executor.submit(run_async_function, link)
            results.append((country, future))
    
    print("Done!")

    result_json = {}
    # Wait for all tasks to complete
    for country, future in results:
        print(f"Saving for {country}...")
        result = future.result()
        result_json[country] = result
        print(result)
    
    json.dump(result_json, open("all_countries_parsed.json", "w+"))

# # Example usage
# country = "Spain"
# url = get_SandP_url_for_country(country)
# print(f"URL for querry '{country}'\n is: {url}")
# result = asyncio.get_event_loop().run_until_complete(main(url))
# json.dump(result, open("url.json", "w+"))

if __name__ == '__main__':
    # get_links_for_all_countries()
    # parse_for_all_links()
    details = json.load(open("all_countries_parsed.json", "r"))
    print(details["Russian Federation"].keys())



