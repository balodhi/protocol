import os as sys
import time as time
import numpy as np


command = "ls"
timeDiff = []
for i in range(3):
	start_time = time.time()
	sys.system(command)
	end_time = time.time()
	elapsed_time.append(end_time-start_time)
	print("Time Elapsed for the command:",elapsed_time[i])

timed=np.array(timeDiff)
stdev = np.std(timeD)
meanT = np.mean(timeD)

commands = ["ls", \
			"time"]
elapsed_time = []
numOfRepeatition = 3

fid = open('time.log','w') 

for j in range(0,len(commands)):
	print("Start command number:",j)
	for i in range(numOfRepeatition):
		
		print(" "*10,"command (",j ,") and repeatition (",i,")"," "*10)
		print("*"*30)
		start_time = time.time()
		sys.system(commands[j])
		end_time = time.time()
		elapsed_time.append(end_time-start_time)
		
		print("Time Elapsed for the command:",elapsed_time[i])
		print("*"*30)
	print("*"*30)
	stdev = np.std(elapsed_time)
	meanT = np.mean(elapsed_time)
	print ("Standard Deviation of execuation:", stdev)
	print ("Mean of execuation:", meanT)
	print("*"*30)
	elapsed_time = []


	fid.write("*"*30+"\n")
	fid.write(commands[j]+"\n")
	fid.write(np.array_str(stdev)+"\n")
	fid.write(np.array_str(meanT)+"\n")
	fid.write("*"*30+"\n")
fid.close()

#timed=np.array(timeDiff)
