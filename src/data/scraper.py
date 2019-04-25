from bs4 import Tag, BeautifulSoup
import requests
import csv
import numpy as np
import pandas as pd
import re


url = "https://www.basketball-reference.com/players/d/duranke01.html"
response = requests.get(url, headers={'User-Agent': 'Chrome/60.0.3112.113'})
soup = BeautifulSoup(response.content, 'html.parser')

# use findALL() to get the column headers
soup.findAll('tr', limit=2)
# use getText()to extract the text we need into a list
headers = [th.getText() for th in soup.findAll('tr', limit=2)[0].findAll('th')]
# avoid the first header row
data_rows = soup.findAll('tr')
player_stats = [[td.getText() for td in data_rows[i].findAll(['td','th'])] for i in range(len(data_rows))]

stats = pd.DataFrame(player_stats, columns = headers)
stats.head(10)
stats.to_csv('../../data/raw/durant-data.csv')