import urllib.request
import re
from datetime import datetime
from bs4 import BeautifulSoup

url = "https://www.checkfuelprice.com/petrol/price/historical-data/hpcl-iocl/bangalore-india-karnataka/255"
with urllib.request.urlopen(url) as response:
   html = response.read()
   soup = BeautifulSoup(html)
   #print(list(soup.table.tbody.find_all('tr')))
   for tr in soup.table.tbody('tr'):
      td = tr('td')
      # GET DATE
      text = td[1].get_text()
      date_string = re.search(r'[0-9]{2}-[A-Za-z]{3}-[0-9]{4}', text).group()
      date = datetime.strptime(date_string, '%d-%b-%Y').date()
      # GET PRICE
      text = td[2].get_text()
      price = re.search(r'^\d*[\.\d*]*', text).group()
      print([date,price])