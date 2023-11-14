<h1>WealthWave</h1>
<h2>Our product for Smarthack2023 x Veridion</h2>
<img width="976" alt="Screenshot 2023-11-14 at 14 28 19-min" src="https://github.com/w-i-l/WealthWave/assets/65015373/547d9e52-27df-4a5f-88c2-ad6046e7fe80">


<br>
<hr>
<h2>About it</h2>
<p>This product was made for the Veridion challenge hosted in the Smarthack 2023 edition - ASMI's 24h hackathon.</p>
<p>The main request for this project was to use the base Veridion APIs:</p>
<ul>
    <li><a href="https://veridion.com/match-enrich-api/">Match and Enrich API</a></li>
    <li><a href="https://veridion.com/complex-search-api/">Complex Search API</a></li>
</ul>
<p>And build on top of them an app that utilises the big data resources received.</p>

<p>Our team decided to build a product that helps people manage their finances and make better decisions regarding their money, by presenting the best companies to invest in, based on economic, geographic and stock history data.</p>

<p>The final product is an <code>IOS</code> app that uses the <code>Veridion APIs</code>, got from a <code>Flask RestAPI server</code>, to get the data and a custom layered algorithm to process it and present it in a user-friendly way.</p>

<p>The roles distribution will be presented in the <a href=#Roles>Roles</a> section of this document.</p>
<h4>Team members:</h4>
<ul>
    <li><a href="https://github.com/bogdan-g-toma">Bodgan Toma</a></li>
    <li><a href="https://github.com/anavarban">Ana-Maria Varban</a></li>
    <li><a href="https://github.com/allee15">Alexia Aldea</a></li>
    <li><a href="https://github.com/w-i-l">Ocnaru Mihai</a></li>
</ul>

<br>
<hr>
<h2>How to use it</h2>
<blockquote>Note! The API keys for OpenAI and Veridion are not provided in this bundle.</blockquote>
<br>

<p>The code has 3 major parts:</p>
<ul>
    <li><a href="https://github.com/w-i-l/WealthWave/tree/main/Xcode_project">IOS app</a></li>
    <li><a href="https://github.com/w-i-l/WealthWave/tree/main/server">RestAPI server</a></li>
    <li><a href="https://github.com/w-i-l/WealthWave/tree/main/trained_model">ARMA model</a></li>
</ul>
<p>For each one you must check for some requirements before running the code.</p>

<h3>IOS app</h3>
<p>For the IOS app you must have <code>Xcode</code> installed on your machine and a minium <code>IOS 16.4</code>. All  other dependencies are provided with <code>Swift Package Manager</code>.</p>

<h3>RestAPI server</h3>
<p>For the RestAPI server you must have <code>Python 3.9</code> installed on your machine and the following dependencies:</p>

<ul>
    <li><code>Flask</code></li>
    <li><code>Flask-Cors</code></li>
    <li><code>requests</code></li>
    <li><code>bs4</code></li>
    <li><code>pyppeteer</code></li>
    <li><code>pyppeteer_stealth</code></li>
    <li><code>pycountry</code></li>
    <li><code>json</code></li>
    <li><code>multiprocessing</code></li>
    <li><code>concurrent.futures</code></li>
    <li><code>openAI</code></li>
    <li><code>googlesearch</code></li>
</ul>

<p>For simplicity just run the following command in your terminal:</p>
<code>pip3 install Flask Flask-Cors requests beautifulsoup4 pyppeteer pyppeteer_stealth pycountry openai googlesearch-python
</code>

<h3>ARMA model</h3>
<p>Just like above you need  at least <code>Python 3.9</code> version and the following dependencies:</p>
<ul>
    <li><code>keras</code></li>
    <li><code>numpy</code></li>
    <li><code>requests</code></li>
    <li><code>sympy</code></li>
    <li><code>yfinance</code></li>
    <li><code>statsmodels</code></li>
    <li><code>scikit-learn</code></li>
</ul>

<p>The following command will install all the dependencies:</p>
<code>pip3 install keras numpy requests sympy yfinance statsmodels scikit-learn</code>

<br>
<p>After installing all the dependencies, just start the server and then the app. All should work just fine. Just note that the app is configured so you can use it from the simulator, as long as the server is run from the same pc. To change this you will need to modify the URL from the API files from <a href="https://github.com/w-i-l/WealthWave/tree/main/Xcode_project/OffWhite-SmartHack/API">here</a>.</p>

<br>
<hr>
<h2>How it works</h2>

<ol>
    <li>Classifying the countries</li>
    <p>Using the <code>pycountry</code> module we get all the countries around the world. Then we search for the economic indicators for each one founded on <a href="https://www.spglobal.com/ratings/en/index">S&P</a> website. We multiply the indicators with custom weights and rank each one. A lower number means an unstable market, while a big rank represents a steady one.</p>
    <li>Choosing an activity domain</li>
    <p>Calling the <code>OpenAI</code> API with a chosen country will return the top 5 activity domain, best suited for investment.</p>
    <li>Showing companies</li>
    <p>For those companies that are publicly listed on the stock market, we get a sustainability score that ranks them and help us filter the best one.</p>
</ol>

<br>
<hr>
<h2>Tech specs</h2>

<p>For the country selection we chose to save the crawled data, for faster response. Also because of the time limit we couldn't parse the reactive context of the S&P website, so we chose to go for the cached version from the <a href="https://www.spglobal.com/ratings/en/index">CachedView</a>.</p>

<p>We tried to optimize the server processing by using a multiprocessing technique, but couldn't integrate with the Flask environment in time. </p>

<p>The simplified scheme for data flow is better illustrated below:</p>
<img width="970" alt="Screenshot 2023-11-14 at 14 55 54-min" src="https://github.com/w-i-l/WealthWave/assets/65015373/390e7b08-abc1-472e-82df-0f6eb8af7155">


<br>
<hr>
<h2 id="Roles">Roles</h2>

<ul>
    <li><a href="https://github.com/bogdan-g-toma">Bodgan Toma</a></li>
    <p>Built and trained the <code>ARMA</code> model for predicting the behavior of a public company</p>
    <li><a href="https://github.com/anavarban">Ana-Maria Varban</a></li>
    <p>Designed the UI in <code>Figma</code>, <code>OpenAI</code> API calls and integration with <code>Veridion</code> APIs</p>
    <li><a href="https://github.com/allee15">Alexia Aldea</a></li>
    <p>Development of the <code>IOS</code> application, using <code>MVVM</code> architecture</p>
    <li><a href="https://github.com/w-i-l">Ocnaru Mihai</a></li>
    <p>Coded a custom web scrapper, a <code>Flask</code> server and integrated it with the <code>IOS</code> app.</p>
</ul>