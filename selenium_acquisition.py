from selenium import webdriver
import time
import re # regular expression : \s \t \n etc ...
import string 
import os 
import sys
import linecache as lc



def cl(rfl,wfl,ar1,ar2):
# cl :	creates a new file with find and replace.
	jy = open(rfl,'r')#rfl : file form which unsorted and parsed data should be read
	cn = jy.read()
	jy.close
	jy1 = open(wfl,'w')#wfl : file to which data should be written	
	cn1 = re.sub(ar1,ar2,cn)# re.sub(pattern, replacement, string, count=0, flags=0)(substitute), # ar1 : search pattren, # ar2: replacement
	jy1.write(cn1)
	jy1.close

def srt8(srfl,sifl,entries): # srfl : source file, sifl : sink file
#srt8 : sorting marks for each student horizontally
	nw = []
	
	for l in range(2,entries*8+2):# 2nd line start because parsed data starts with a blank line for line 1{check case2 file}
		fl = re.sub(r'\n',' ',lc.getline(srfl,l))# linecache is imported as lc and getline gets the strings from given line number
		nw.append(fl)
	
	tp = open(sifl,'w')

	for b in range(0,len(nw),8):
		l8 = ''#empty string declaration {find any elegant methods available}
		for d in range(b,b+8,2):
			
			pa = nw[d]+nw[d+1]
			l8 = l8+pa

		tp.write(l8+'\n')

	tp.close()

#Retriving data from net using selenium
usnStack =[str(n.strip()) for n in open('fetch').readlines()]
infoStack = []

driver = webdriver.Firefox()

for x in range(0,len(usnStack)):

	driver.get("http://results.vtu.ac.in/")
	
	inputElement = driver.find_element_by_name("rid")

	inputElement.send_keys(usnStack[x])

	buttonElement = driver.find_element_by_name("submit")

	buttonElement.click()
	
	time.sleep(0.5)

	data = driver.find_element_by_xpath(xpath='/html/body/table/tbody/tr[3]/td[2]/table/tbody/tr[3]/td/table/tbody/tr[2]/td[1]/table[2]/tbody/tr/td/table/tbody/tr[2]/td/table[2]/tbody')# if clause to be added if the particular is not available. firebug in firefox to retrive the xpath of elements


	result = open('case2','a')#case2 is arbitrarily choosen

	result.writelines( "%s\n\n\n" % data.text )

	result.close()

	time.sleep(0.5)

driver.quit()
#all the retrived data is in case2 file for sorting
ma = [['Subject\sExternal\sInternal\sTotal\sResult'],['Engineering\sMathematics\s-\sII\s\(10MAT21\)\s'],['Engineering\sPhysics\s\(10PHY22\)\s'],['Elements\sof\sCivil\sEngg\.\s&\sEngg\.\sMechanics\s\(10CIV23\)\s'],['Elements\sof\sMechanical\sEngineering\s\(10EME24\)\s'],['Basic\sElectrical\sEngineering\s\(10ELE25\)\s'],['Workshop\sPractice\s\(10WSL26\)\s'],['Engineering\sPhysics\sLab\s\(10PHYL27\)\s'],['Constitution\sof\sIndia\s&\sProfessional\sEthics\s\(10CIP28\)\s'],['\sP'],['\sF'],['\n\n\n']]
# ma list has to be carefully written every time

p = 2 # refer line 65

# find and replace recurssive texts
for k in range(0,len(ma)):

	q = p+1
	i = ma[k]
	cl('case'+str(p),'case'+str(q),i[0],'')
	p += 1
#sorting for horizantally for each student
srt8('case'+str(q),'case'+str(q+1),len(usnStack))



