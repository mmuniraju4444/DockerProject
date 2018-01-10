#import time
import urllib.request
import re
import json
from datetime import datetime
from bs4 import BeautifulSoup
#import redis
from flask import Flask
#import pyorient


app = Flask(__name__)
#cache = redis.Redis(host='redis', port=6379)


# def get_hit_count():
#     retries = 5
#     while True:
#         try:
#             return cache.incr('hits')
#         except redis.exceptions.ConnectionError as exc:
#             if retries == 0:
#                 raise exc
#             retries -= 1
#             time.sleep(0.5)
def petrol():
    data_list = []
    url = "https://www.checkfuelprice.com/petrol/price/historical-data/hpcl-iocl/bangalore-india-karnataka/255"
    with urllib.request.urlopen(url) as response:
        html = response.read()
        soup = BeautifulSoup(html)
        for tr in soup.table.tbody('tr'):
            td = tr('td')
            # GET DATE
            text = td[1].get_text()
            date_string = re.search(r'[0-9]{2}-[A-Za-z]{3}-[0-9]{4}', text).group()
            price_date = datetime.strptime(date_string, '%d-%b-%Y').date().__str__()
            # GET PRICE
            text = td[2].get_text()
            price = re.search(r'^\d*[\.\d*]*', text).group()
            data_list.append([price_date, price])
        #return 'Hello World! I have been seen {} times.\n'.format(count)
    return json.dumps(data_list)

def diesel():
    data_list = []
    url = "https://www.checkfuelprice.com/diesel/price/historical-data/hpcl-iocl/bangalore-india-karnataka/255"
    with urllib.request.urlopen(url) as response:
        html = response.read()
        soup = BeautifulSoup(html)
        for tr in soup.table.tbody('tr'):
            td = tr('td')
            # GET DATE
            text = td[1].get_text()
            date_string = re.search(r'[0-9]{2}-[A-Za-z]{3}-[0-9]{4}', text).group()
            price_date = datetime.strptime(date_string, '%d-%b-%Y').date().__str__()
            # GET PRICE
            text = td[2].get_text()
            price = re.search(r'^\d*[\.\d*]*', text).group()
            data_list.append([price_date, price])
        #return 'Hello World! I have been seen {} times.\n'.format(count)
    return json.dumps(data_list)


@app.route('/')
def fuel():
    # count = get_hit_count()
    petrol_json = petrol()
    diesel_json = diesel()

    return [petrol_json,diesel_json].__str__()

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)