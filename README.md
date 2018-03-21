# WOWAH

Reference:

Yeng-Ting Lee, Kuan-Ta Chen, Yun-Maw Cheng, and Chin-Laung Lei, "World of Warcraft Avatar History Dataset," In Proceedings of ACM Multimedia Systems 2011, Feb 2011.
url: http://mmnet.iis.sinica.edu.tw/dl/wowah/

##Data Import
Each of the 1000+ text files downloaded in the zipped data set start of like this:
Persistent_Storage = {
	[1] = "0, 10/05/06 00:00:53, 1,20739, , 8, Orc, Warrior, Durotar, , 0",
	[2] = "0, 10/05/06 00:00:58, 2,9948,19, 18, Orc, Shaman, Ragefire Chasm, , 0",
 
To read this in I had R skip to like 2, ignore quotes, and read it as a csv.  There are a few "dummy variable" columns and so I had R drop these columns.
