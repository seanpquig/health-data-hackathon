# 2010 Chronic Conditions PUFs
rm -r download-data/chronic-conditions-PUFs
mkdir download-data/chronic-conditions-PUFs
cd download-data/chronic-conditions-PUFs

wget https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/BSAPUFS/Downloads/PUF_Disclaimer.pdf
wget https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/BSAPUFS/Downloads/2010_ChronicConditions_PUF.zip
wget https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/BSAPUFS/Downloads/2010_ChronicConditions_DataDictionary.pdf
wget https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/BSAPUFS/Downloads/2010_ChronicConditions_GenDoc.pdf
wget https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/BSAPUFS/Downloads/2010_ChronicConditions_DUG.zip
wget https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/BSAPUFS/Downloads/2008_Chronic_Conditions_PUF.zip
wget https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/BSAPUFS/Downloads/2008_Chronic_Conditions_PUF_Data_Dictionary.pdf
wget https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/BSAPUFS/Downloads/2008_Chronic_Conditions_PUF_GenDoc.pdf
wget https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/BSAPUFS/Downloads/2008_Chronic_Conditions_PUF_DUG.zip
wget https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/BSAPUFS/Downloads/2008_Enrollment_and_User_Rates.pdf

unzip 2008_Chronic_Conditions_PUF.zip
unzip 2008_Chronic_Conditions_PUF_DUG.zip
unzip 2010_ChronicConditions_DUG.zip
unzip 2010_ChronicConditions_PUF.zip

rm 2008_Chronic_Conditions_PUF.zip
rm 2008_Chronic_Conditions_PUF_DUG.zip
rm 2010_ChronicConditions_DUG.zip
rm 2010_ChronicConditions_PUF.zip

aws s3 cp ../chronic-conditions-PUFs/ s3://health-datasets/chronic-conditions-PUFs --recursive
cd ../..

# NPDB Malpractice claims
rm -r download-data/NPDB-malpractice-claims
mkdir download-data/NPDB-malpractice-claims
cd download-data/NPDB-malpractice-claims

wget http://www.npdb.hrsa.gov/resources/NpdbPublicUseDataAscii.zip
wget http://www.npdb.hrsa.gov/resources/NpdbPublicUseDataSpss.zip

unzip NpdbPublicUseDataAscii.zip
unzip NpdbPublicUseDataSpss.zip
 
rm NpdbPublicUseDataAscii.zip
rm NpdbPublicUseDataSpss.zip
 
aws s3 cp ../NPDB-malpractice-claims/ s3://health-datasets/NPDB-malpractice-claims --recursive
cd ../..

# SPARCS
rm -r download-data/SPARCS
mkdir download-data/SPARCS
cd download-data/SPARCS

wget https://health.data.ny.gov/api/views/ivw2-k53g/rows.csv?accessType=DOWNLOAD
wget https://health.data.ny.gov/api/views/q6hk-esrj/rows.csv?accessType=DOWNLOAD
wget https://health.data.ny.gov/api/views/mtfm-rxf4/rows.csv?accessType=DOWNLOAD
wget https://health.data.ny.gov/api/views/pyhr-5eas/rows.csv?accessType=DOWNLOAD
wget https://health.data.ny.gov/api/views/u4ud-w55t/rows.csv?accessType=DOWNLOAD
wget https://health.data.ny.gov/api/views/npsr-cm47/rows.csv?accessType=DOWNLOAD

aws s3 cp ../SPARCS/ s3://health-datasets/SPARCS --recursive
cd ../..

