import sys, time, subprocess  
def run(cmd, input, output, limit): 
	timeout = 0 
	start = time.time()  
	with open(input, 'r') as infile, open(output, "w") as outfile:  
		process = subprocess.Popen(cmd, stdin=infile, stdout=outfile)  
		while process.poll() is None:  
			time.sleep(0.001)  
			if int((time.time() - start) * 1000) > limit:  
				process.terminate()  
				try:  
					process.kill()  
				except OSError:  
					pass  
				timeout = 1
				break  
	end = time.time()  
	used = int((end - start) * 1000)  
	code = process.poll()
	print(timeout, used, code)  
limit = int(sys.argv[1]) 
run('code', 'in.txt', 'out.txt', limit)  
