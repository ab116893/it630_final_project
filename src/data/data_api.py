# -*- coding: utf-8 -*-
"""
Created on Thu Apr 25 11:25:58 2019

@author: sudar
"""
import goldsberry
import pandas as pd

players2010 = goldsberry.PlayerList(Season='2010-11')
players2010 = pd.DataFrame(players2010.players())
players2010.head()
print(players2010)

#games = goldsberry.GameIDs()
#games = pd.DataFrame(games.game_list())
#games.head()
