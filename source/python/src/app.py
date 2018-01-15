import urllib.request
import re
import json
from datetime import datetime
from bs4 import BeautifulSoup
from flask import Flask
from helper import config
import pymysql.cursors


app = Flask(__name__)

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
    return data_list

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
    return data_list


@app.route('/')
def fuel():
    petrol_data = petrol()
    diesel_data = diesel()
    diesel_data.reverse()
    petrol_data.reverse()
    data = config.read_config("database.mysql")
    # connection = pymysql.connect(host='mariadb', db='fuel', user = 'root', password = 'root', charset = 'utf8mb4',cursorclass = pymysql.cursors.DictCursor)
    connection = pymysql.connect(**data)
    try:
        with connection.cursor() as cursor:
            sql = "INSERT INTO `fuel_prices` (`date`, `price`, `currency_id`, `fuel_type_id`) VALUES (%s, %s, %s, %s)"
            for data in petrol_data:
                cursor.execute(sql, (data[0],data[1],1,1))
            for data in diesel_data:
                cursor.execute(sql, (data[0],data[1],1,2))
        # connection is not autocommit by default. So you must commit to save
        # your changes.
        connection.commit()
    finally:
        connection.close()
    return "Done"
    #return [petrol_json,diesel_json].__str__()

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)