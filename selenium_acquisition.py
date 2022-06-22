from selenium import webdriver
import time
import os
import sys

usnStack =[str(n.strip()) for n in open('reg_ids').readlines()]
infoStack = []

driver = webdriver.Firefox()

for x in range(0,len(usnStack)):

	driver.get("http://results.vtu.ac.in/")
	
	inputElement = driver.find_element_by_name("rid")

	inputElement.send_keys(usnStack[x])

	buttonElement = driver.find_element_by_name("submit")

	buttonElement.click()
	
	time.sleep(2)

	data = driver.find_element_by_xpath(xpath='/html/body/table/tbody/tr[3]/td[2]/table/tbody/tr[3]/td/table/tbody/tr[2]/td/table[2]/tbody/tr/td/table/tbody/tr[2]/td/table[2]')

	infoStack.append(data.text)

	time.sleep(3)

driver.quit()


result = open('case','a')


#print infoStack

result.writelines( "%s\n\n\n" % item for item in infoStack )

result.close()



