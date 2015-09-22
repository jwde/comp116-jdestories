import fileinput
import re

lines = []

for line in fileinput.input():
	lines.append(line)

for i in range(len(lines)):
	if not i == 0:
		match = re.search('.* (\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*', lines[i])
		if match:
			ip = match.group(1)
			print "\t".join([ip, lines[i - 1][18:]])
			
