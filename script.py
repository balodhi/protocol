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

print ("Standard Deviation of execuation:", stdev)
print ("Mean of execuation:", meanT)