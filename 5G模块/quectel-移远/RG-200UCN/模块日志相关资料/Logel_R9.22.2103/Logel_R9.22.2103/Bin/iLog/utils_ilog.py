import os
import json
import codecs
import sys
import re
import socket

def ilog_path() :
	#For EXTERNAL network use this url ( uncomment the below line. )
	#we need the ip to check if it is an internal network or external.
	ip = socket.gethostbyname(socket.gethostname())
	if re.match( '10\.', ip ) : #if start with 10. it is an external network else internal.
		return ur'\\shextnas1\iLog'		
	return ur'\\shrdnas2\iLog'

	
	
#Returnes valid filename and parserlib path if found.
#it opens the bugInfo.json file from iLog and take the details.
# Format of bugInfo.json is as follows
# eg:
#  {
#      "bugzilla_id": 468084, 
#      "base_on_version": "MOCORDROID5.1_SharkL_15C_MP_W15.34.6", 
#      "logel": [
#          {
#              "version": "FM_BASE_15B_VOLTE_W15.34.6", 
#              "file": "\\\\shextnas1\\iLog\\Bugzilla\\468084\\468084_rar\\468084\\slog_2015082695708_sp9830aef_5m_volte_userdebug\\external_storage\\modem_log\\2015-08-26-09-50-14\\cp_5mode\\0-cp_5mode-2015-08-26_09-50-14.logel", 
#              "orgfile": "\\\\shnas2\\Logs\\PDLogs\\PDLogs\\MocorDroid\\2015\\MOCORDROID5.1_SharkL_15C_MP_W15.34.6\\WCN\\468084.rar"
#          }
#      ]
#  }

#After getting the version string the funtion ty to find a proper Parser lib path in iLog.
#this function tries to find a string like TD_BASE_ for the product version string from bugzilla
def version_from_bov( base_on_version ) : 
	match = re.search('\w+_BASE_[\w\.]+', base_on_version ) #Try to pick up the version from base_on_version, for example, from MOCORDROID5.1_SharkL_15C_MP_W15.32.2 [FM_BASE_W15.31_P1], pick up FM_BASE_W15.31_P1
	if match :
		return match.group(0)
	return u''
	
def product_version_from_bov( base_on_version ) : 
	match = re.match('[\w\.]+', base_on_version ) #Try to pick up the version from base_on_version, for example, from MOCORDROID5.1_SharkL_15C_MP_W15.32.2 [FM_BASE_W15.31_P1], pick up FM_BASE_W15.31_P1
	if match :
		return match.group(0)
	return u''

def find_parser( version ) :
	if not version :
		return u''
		
	parserlib_path = os.path.join( ilog_path(), u'ParserLib', version , u'Parser' )
	
	if os.path.exists( parserlib_path ) :
		#return u"Parser" #nothing
		return parserlib_path
	
	return u'' #nothing	

	
def getLogFileInfo( bugzilla_id ) :
	#we need to look into the folder ilog_path \ Bugzilla \ bugzilla_id \ bugInfo.json
	json_file = os.path.join( ilog_path(), 'Bugzilla', str(bugzilla_id), 'bugInfo.json'  )
	if not os.path.exists(json_file) :
		return [] #nothing
		
	with codecs.open( json_file, 'r', 'utf-8' ) as file: #json file is always in utf-8
		bug_info = json.load( file )
	
	log_info = []
	for id, logel in enumerate( bug_info['logel'] ) : 
		filename = logel['file'] 
		#filename = filename.replace(ur'\\shextnas1\iLog', ilog_path()) #in internal change the path.
		if not re.match(r'\\', filename ) : #it is a partial filename
			filename = os.path.join( ilog_path(), ur'Bugzilla', str(bugzilla_id), filename )
		else : #full path; change to internal or external.
			filename = filename.replace(ur'\\shextnas1\iLog', ilog_path()) #in internal change the path.
			
		if os.path.exists( filename ) :
			
			#Need to find the parserlib path.
			#check from version string first; then from a similar sting in based_on_version
			# and finally from the product version.
			parserlib_path = ( find_parser( logel['version'] ) or 
							 find_parser( version_from_bov( bug_info['base_on_version'] ) ) or
							 find_parser( product_version_from_bov( bug_info['base_on_version'] ) ) or
							 u'Parser'  ) #the default one from the ArmLogel folder.
			
			log_info.append( (id, filename, parserlib_path) ) #id is the index of the file 
		
	return log_info 


	
	
	
	

