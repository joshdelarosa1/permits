# Install
install.packages("dplyr")
# Load
library("dplyr")


# read in DOB Lic
# data dictionary https://data.cityofnewyork.us/api/views/t8hj-ruu2/files/d1dff06b-3761-4ab8-936c-2e4654d7e409?download=true&filename=DOB%20Licensee%20Data%20Dictionary.xlsx
DOB_License_Info= read.csv("https://data.cityofnewyork.us/api/views/t8hj-ruu2/rows.csv?accessType=DOWNLOAD")  

head(DOB_License_Info) 

#keep active licenses
DOB_License_ACTIVE<-DOB_License_Info[!(DOB_License_Info$License.Status!="ACTIVE"),]

str(DOB_License_ACTIVE) 

# read in DOB Job Applications
# data dictionary https://data.cityofnewyork.us/api/views/ic3t-wcy2/files/893bfaed-d4a8-4c77-8af4-e2db94078d8e?download=true&filename=DD_DOB%20Job%20Application%20Filings_2017-10-16.xlsx
#sub set using website for now. this limits size of file. future subset can be down in API call.

DOB_Job_Apps= read.csv("https://data.cityofnewyork.us/api/views/5t7k-fgnu/rows.csv?accessType=DOWNLOAD")  

head (DOB_Job_Apps)
duped_jobs<-distinct(DOB_Job_Apps, Job..,.keep_all = TRUE)
str (duped_jobs)


# read in DOB Work Permits
# data dictionary https://data.cityofnewyork.us/api/views/jdzm-pvmm/files/87608d5b-1986-4a21-a8a5-7a38e65f9993?download=true&filename=DD_DOB_Permit_Issuance_2018-03-07.xlsx
#sub set using website for now. this limits size of file. future subset can be down in API call.

DOB_Permits_Apps= read.csv("https://data.cityofnewyork.us/api/views/jdzm-pvmm/rows.csv?accessType=DOWNLOAD")  

head (DOB_Permits_Apps)
duped_permits<-distinct(DOB_Permits_Apps, Job..,.keep_all = TRUE)
str (duped_permits)


job_work_merge<-merge(x = duped_jobs, y = duped_permits, by = "Job..",all = TRUE)

str(job_work_merge)
write.csv(job_work_merge, "/Users/josuedelarosa/dev/NYC_permits/merged_work_jobs.csv")

# to do- merge lic to perm data to pick up contact info. need to clean lic file as it is messy.
