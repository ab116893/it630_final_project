from bs4 import Tag, BeautifulSoup
import requests
import csv
import numpy as np
import pandas as pd
import re

def data():
    try:
        letter = input("First letter of nba player last name: ")
        name = input("Name of nba player, first five letter in last name and first two letter of their first (EX:curryst,duranke) : ")
        
        url = "https://www.basketball-reference.com/players/{}/{}01.html".format(letter,name)
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
        stats.to_csv('../../data/raw/{}.csv'.format(name))
        print("--------------done scraping---------------")

    except:
        print("Invalid input or error on the scraper")
data()