# Protocol

## Information

Docker file to install and configure the environment for sequence alignment softwares.
Following softwares are installed by the Dockerfile. zip files must be stored in the softwares folder. 

 * bowtie version 2.2.9
 * tophat2 version 2.1.1
 * samtools version 1.6
 * contextmap version 2.7.9
 * sratoolkit version 2.8.2
 * hisat2 2.1.0
 * cufflinks 2.2.1
 * SOAPsplice v1.10 
 * stringtie v1.3.3b

### Dockerfile
#### Build

`
sudo docker build --rmi -t balodhi/myimage:1.0 .
`


### Run

```
sudo docker run -ti --rm -v /Volumes/External/Downloads/protocol/inputdata/:/root/home/inputdata balodhiku/myimage:1.0
```

#### Run programs
paths are already set so program will run by just rnning their executible irrespective of the path.
ContextMap will run as:

`
java -jar $MYJAR
`

### Working directory
cd $WORKINGDIR

# Script
### Run Script
Script is located in /usr/local/bin folder which is already in envrinment. Just type `control` in any directory and it will run. It will look for the inputdata directory in the same folder where you run it.
### Edit script

type 

`vim control`





