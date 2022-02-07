import sys, time, speedtest, math, random, os

speed = speedtest.Speedtest()
down =  float("{:.2f}".format((speed.download() / 10e5) / 8))
print("cmd enter: ")
a = input()
b = a.split()
d = b[-1]
e = random.uniform(1024, 10240)
f = float("{:.4f}".format(e))
dtime = f / down
extracttime = dtime/8.32
validtime = dtime/20.88
installtime = dtime/4.21

print("You are downloading the script", d,"(",f,"MBs at",down," MB/s)\nPress Y or N to confirm: ")

c = input()

if c == 'Y' or c == 'y':
    print("Initiating download", end = "", flush=True)
    time.sleep(1)
    for i in range(3): 
        print(".", end = "", flush=True)
        time.sleep(1) 
elif c == 'N' or c == 'n':
    print("Command cancelled", end = "", flush=True)
    time.sleep(1)
    for i in range(3): 
        print(".", end = "", flush=True)
        time.sleep(1) 
else:
    raise Exception("~~--> user input: "+ c +" \n~~-->error.InvalidKeystroke() raise: [Errno 1923]")
    exit()

#animation = ["10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%"]
animation = ["[■□□□□□□□□□]","[■■□□□□□□□□]", "[■■■□□□□□□□]", "[■■■■□□□□□□]", "[■■■■■□□□□□]", "[■■■■■■□□□□]", "[■■■■■■■□□□]", "[■■■■■■■■□□]", "[■■■■■■■■■□]", "[■■■■■■■■■■]"]

for i in range(len(animation)):
    time.sleep(float(extracttime/10))
    sys.stdout.write("\rExtracting packages: " + animation[i % len(animation)])
    sys.stdout.flush()
print()
for i in range(len(animation)):
    time.sleep(float(validtime/10))
    sys.stdout.write("\rValidating package tokens: " + animation[i % len(animation)])
    sys.stdout.flush()
print()
for i in range(len(animation)):
    time.sleep(float(dtime/10))
    sys.stdout.write("\rDownloading: " + animation[i % len(animation)])
    sys.stdout.flush()
print()
for i in range(len(animation)):
    time.sleep(float(installtime/10))
    sys.stdout.write("\rFinalizing installation: " + animation[i % len(animation)])
    sys.stdout.flush()
    
print("\nInstallation of script " + d +" complete.")