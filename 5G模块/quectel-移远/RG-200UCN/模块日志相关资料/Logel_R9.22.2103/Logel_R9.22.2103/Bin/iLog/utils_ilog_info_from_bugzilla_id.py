from __future__ import print_function
import sys
import re
from utils_ilog  import *


'''
Run the script like this: python utils_ilog_info_from_bugzilla_id.py 424996

Retuen will be in STDOUT in the format
{iLogID} 26877 {logelFile} "\\shextnas1\ilog\Bugzilla\424996\424996-1.rar\2015-04-21-14-31-18\cp_wcn\0-cp_wcn-14-31-18.logel" {parserPath} "\\shnas2\Dept_Folder\PS\iLog\MocorDroid4.4_TShark28_MP_W15.04.1\Parser"
{iLogID} 26876 {logelFile} "\\shextnas1\ilog\Bugzilla\424996\424996-1.rar\2015-04-21-14-31-18\cp_tdd-lte\0-cp_tdd-lte-14-31-18.logel" {parserPath} "\\shnas2\Dept_Folder\PS\iLog\MocorDroid4.4_TShark28_MP_W15.04.1\Parser"
{iLogID} 26875 {logelFile} "\\shextnas1\ilog\Bugzilla\424996\424996.rar\424996\15.36\external_storage\2015-04-12-15-35-41\cp_wcn\0-cp_wcn-15-35-46.logel" {parserPath} "\\shnas2\Dept_Folder\PS\iLog\MocorDroid4.4_TShark28_MP_W15.04.1\Parser"
{iLogID} 26874 {logelFile} "\\shextnas1\ilog\Bugzilla\424996\424996.rar\424996\15.36\external_storage\2015-04-12-15-35-41\cp_tdd-lte\0-cp_tdd-lte-15-35-41.logel" {parserPath} "\\shnas2\Dept_Folder\PS\iLog\MocorDroid4.4_TShark28_MP_W15.04.1\Parser"

The keywords like iLogID will be in {} and the paths are in quotes.

'''


if __name__ == '__main__':
	bugz_ids = []
	for arg in sys.argv[1:] :
		bugz_ids += re.findall('\d+', arg)
	#bugz_ids = re.findall('\d+', sys.argv[1]) #extract all the numbers; these are the bugzilla ids.
	for b_id in bugz_ids :
		#returned filename and parserlib
		log_info = getLogFileInfo( b_id )
		for id, logelfile, parserpath in log_info :
			
			lst_filename = logelfile.replace( '.logel', '.lst')
			if logelfile.endswith('.logel') and os.path.exists( lst_filename ) :
				logelfile = lst_filename #change the logel to lst for easy opening in ArmLogel
				
			pb_lst_path = logelfile.replace( '.logel', '_pb.lst' )
			if logelfile.endswith('.logel') and os.path.exists( pb_lst_path ) :
				logelfile = pb_lst_path #change the logel to lst for easy opening in ArmLogel
			
			print( '{bugzillaID} ', b_id, ' {iLogID} ', str(b_id) + ':' +str(id), 
				' {logelFile} "', logelfile.encode('gbk'), '"',  #we assume all filenames as gbk.
				' {parserPath} "', parserpath.encode('gbk'), '"',
				sep='') #new print funtion in python.
			'''	
			print( '{bugzillaID} ', b_id, ' {iLogID} ', str(b_id) + ':' +str(id), 
				' {logelFile} "', base64.b64encode( logelfile.encode('gbk') ), '"',  #we assume all filenames as gbk.
				' {parserPath} "', parserpath.encode('gbk'), '"',
				sep='') #new print funtion in python.
			'''	
		if not log_info :
			print('Did not get any log files for bugzilla id ', b_id)
		sys.stdout.flush()