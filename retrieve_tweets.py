import os
import json
import gzip

def box_check(lon, lat):
	lon_left_top = -119.2
	lat_left_top = 35.0
	lon_right_bottom = -117.1
	lat_right_bottom = 32.5
	lon = float(lon)
	lat = float(lat)
	if lon < lon_right_bottom and lon > lon_left_top and \
		lat < lat_left_top and lat > lat_right_bottom:
		return True
	else:
		return False

def get_filenames(mydir):
	filenames = []
	for f in os.listdir(mydir):
		if f[:4] == 'dist':
			filenames.append(f)
	return filenames

mydir = 'L:\\USTweets'
filenames = get_filenames('L:\\USTweets')
cnt = 0
with open('LA_boundingbox_tw.csv','w') as fw:
	fw.write('twid,create_time,userid,lon,lat\n')
	for fn in filenames:
		path = mydir + '\\' + fn
		print(path)
		with gzip.open(path, 'rt', encoding='utf-8') as fr:
			for line in fr:
				if line[0] == '{':
					#print(line)
					try:
						tw = json.loads(line)
						tid = tw['id_str']
						crtime = tw['created_at']
						uid = tw['user']['id_str']
						try:
							lon = str(tw['coordinates']['coordinates'][0])
							lat = str(tw['coordinates']['coordinates'][1])
							#print(lat + ' ' + lon)
							if box_check(lon, lat) == True:
								#print('Yes')
								nl = tid + ',' + crtime + ',' + uid + ',' + lon + ',' + lat + '\n'
								fw.write(nl)
								cnt += 1
								if cnt % 1000 == 0:
									print(cnt)
						except:
							continue
					except:
						print(line)
				
	        	
