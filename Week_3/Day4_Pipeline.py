# -*- coding: utf-8 -*-
"""
Created on Thu Jan 23 15:14:54 2020

@author: eldiy
"""

import pandas as pd
import os
import matplotlib.pyplot as plt
import seaborn as sns

year=int(input('Input the Year: '))

def acquire():
    os.chdir('C:\\Users\\eldiy\\Documents\\Ironhack\\Slides\\vehicles\\vehicles')
    df=pd.read_csv('vehicles.csv')
    return df

def wrangle(df,year=year):
    filtered=df[df['Year']==year]
    return filtered

def analyze(filtered):
    grouped=filtered.groupby('Make')['Combined MPG'].agg('mean')
    results=grouped.sort_values(ascending=False).head(10).reset_index()
    return results

def report(results,year=year):
    title = 'Top 10 Manufacturers by Fuel Efficiency '+str(year)
    fig, ax =plt.subplots(figsize=(15,8))
    barchart=sns.barplot(data=results, x='Make',y='Combined MPG')
    plt.title(title, fontsize=16)
    fig=barchart.get_figure()
    fig.savefig(title+'.png')

if __name__=='__main__':
    data=acquire()
    filtered=wrangle(data)
    results=analyze(filtered)
    report(results)
    