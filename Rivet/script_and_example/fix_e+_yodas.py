import sys

analysisfile = open(sys.argv[1],'r')
new_analysisfile = open("fixed_"+sys.argv[1],'w')
prestring=""
found_histo=False
header=False
wrong_histo=False

print "Start adapting the histogram {0}.".format(sys.argv[1])
for line in analysisfile:
  if line.find('END YODA_HISTO1D') != -1:
    line.strip('\n')
    if not wrong_histo:
      new_analysisfile.write(line)
    found_histo = False
    header = False
    wrong_histo = False
    prestring = ""
    continue
  if line.find('BEGIN YODA_HISTO1D') != -1 and line.find('WpZ_OF') != -1:
    found_histo = True
    header = True
    prestring+=line
    continue
  if (found_histo and line.find('Total') != -1):
    header=False
    line.strip('\n')
    numEvts=line.split()
    if float(numEvts[-1]) >= 1000.:
      prestring.strip('\n')
      new_analysisfile.write(prestring)
    else:
      wrong_histo=True
  if (found_histo and header):
    prestring+=line
    continue
  if (found_histo and wrong_histo):
    continue

  line.strip('\n');
  new_analysisfile.write(line)
 
analysisfile.close()
new_analysisfile.close()
