# -*- coding: utf-8 -*-
"""
Created on Tue Feb 19 20:59:13 2019

@author: sudar
"""

class url_feeder(object):   
    def __init__(self, section):
        """initialize the feeder"""
        self.section = section
        
    def feeder(self):
        """We going to get the URL through each section
        over-view
        company information
        analysis
        company management
        financial
        Set a Flag to check what section is the user input
        The flag will check and trigger the specific section
        Pseudocode
        Set flag
            if the flag equal section company overview
            Then Scrape the data
                if not then keep going
                if the flag equal section analysis
        .........
        """
        ##############################################################
        """
        Build the URL for specific company section
        """
        try:       
            flag = self.section
            base_url = 'https://www.reuters.com'
            base_url1 = 'https://csimarket.com'
            path_1 = '/finance'
            path_2 = '/stocks/'
            section_list = ['overview', 'company-officers', 'financial-highlights', 'analyst', 'industry', 'segment']
            company_list = ['/MSFT.OQ', '/MET.N', '/MS.N', '/FNMA.PK', '/GM', '/PROC.NS', '/APO.N', '/BA.N', '/BRKa.N']
            company_list1 = ['MSFT', 'MET','MS', 'FNMA', 'GM', 'PG', 'APO', 'BA', 'BRKA']
            url_list = []
            if self.section.lower:    
                for company in company_list:
                    if flag == section_list[0]:
                        url = base_url + path_1 + path_2 + flag + company
                        url_list.append(url)
                    elif flag == section_list[1]:
                        url = base_url + path_1 + path_2 + flag + company
                        url_list.append(url)
                    elif flag == section_list[2]:
                        url = base_url + path_1 + path_2 + flag + company
                        url_list.append(url)
                    elif flag == section_list[3]:
                        url = base_url + path_1 + path_2 + flag + company
                        url_list.append(url)
                
            
                for company in company_list1:
                    if flag == section_list[4]:
                        url = base_url1 + '/stocks/competition.php?code=' + company
                        url_list.append(url)
                    elif flag == section_list[5]:
                        url = base_url1 + '/stocks/segments.php?code=' + company
                        url_list.append(url)
                return url_list
        except:
            return ("error")
#############Uncomment to test####################    
#test = url_feeder("company-officers")
#print(test.feeder())
            
            
        
        
        
