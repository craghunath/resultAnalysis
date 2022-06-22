import re
import os
import string
import operator as op
import itertools as itl
rawFl = open('samp','r')
rawData = rawFl.read()
rawFl.close

mat = re.findall(r"(?<=\nRegister No\.)(.*?)(?=\n[-]+)", rawData, re.DOTALL)
mat1 = []
for mks in mat:
	mks1 = re.sub(r"A\n",r"1000\n",mks)
	mks1 = re.sub(r"\n\*\n",r"\n2000\n",mks1)
	mks1 = re.sub(r"^ 16BGS",r"\n16BGS",mks1)
	exm = re.search(r"Total Marks: (\d+(\n\d+)+)",mks1,flags=re.MULTILINE)
	iam = re.search(r"I\.A\.Marks : (\d+(\n\d+)+)",mks1,flags=re.MULTILINE)
	sub = re.search(r"Paper Code :\n([\w ]+)",mks1)
	reg = re.search(r"(\n[\w]+) Name",mks1)#(\n)
	nam = re.search(r" Name\n:([\w ]+)",mks1)
	
	exm1 = re.split("\n",exm.group(1))
	exm2 = exm1[:2] + ['0'] + exm1[2:]
	subj = re.split(" ",sub.group(1))
	
	ex = exm2[3:]#map(int, exm2[3:])
	ia = re.split("\n",iam.group(1))[3:]#map(int, re.split("\n",iam.group(1))[3:])
	tot = map(str, map(op.add, map(int, ex), map(int, ia ) )  )
	mat1.append([reg.group(1),nam.group(1)] + ex + ia + tot + subj)#"".join([reg.group(1),reg.group(2)])



resan = list(itl.chain.from_iterable( mat1 ))
bb = ",".join(resan)
bb = re.sub(r"([\w]+ )1000",r"\1A",bb)
bb = re.sub(r",\n",r"\n",bb)
bb = "\n".join(["Register No,Name,Sub1ex,Sub2ex,Sub3ex,Sub4ex,Sub5ex,Sub6ex,Sub7ex,Sub1ia,Sub2ia,Sub3ia,Sub4ia,Sub5ia,Sub6ia,Sub7ia,Sub1tot,Sub2tot,Sub3tot,Sub4tot,Sub5tot,Sub6tot,Sub7tot,Sub1,Sub2,Sub3,Sub4,Sub5,Sub6,Sub7",bb])

dataFl = open('resany.csv','w')
dataFl.write(bb)
dataFl.close


