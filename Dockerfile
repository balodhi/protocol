FROM ubuntu
LABEL maintainer="blodhi@korea.ac.kr" description="learning the docker environment"
USER root

RUN apt-get update && apt-get install -y \
	binutils\
	wget\
	git\
	build-essential\
	libncurses5-dev\
	zlib1g-dev\
	libbz2-dev\
	liblzma-dev\
	bzip2\
	libboost-thread1.58.0\
	python\
	default-jre\
	libcurl4-openssl-dev\
	figlet\
	vim\
	moreutils\
	htop\
	python-pip\
	python-dev\
	build-essential\
	unzip 

ENV WORKPATH="/usr/local/bin" BOWTIE2VERSION="2.2.9" TOPHAT2VERSION="2.1.1" SAMVERSION="1.6" WORKPATHHOME="/home/" MYJAR="/usr/local/bin/ContextMap_v2.7.9/ContextMap_v2.7.9.jar" WORKINGDIR="/root/home/" MYSCRIPT="/usr/local/bin/control"
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib
##set all of the paths##
ENV PATH $WORKPATH/bowtie2-${BOWTIE2VERSION}:\
$WORKPATH/tophat-${TOPHAT2VERSION}.Linux_x86_64:\
$WORKPATH/sratoolkit.2.8.2-1-ubuntu64/bin:\
$WORKPATH/hisat2-2.1.0:\
$WORKPATH/hisat-0.1.6-beta:\
$WORKPATH/cufflinks-2.2.1.Linux_x86_64:\
$WORKPATH/SOAPsplice-v1.10:/usr/local/bin/STAR-2.5.3a/source:\
$WORKPATH/subread-1.6.0-Linux-x86_64/bin:\
$WORKPATH/stringtie-1.3.3b.Linux_x86_64/:$PATH

ADD softwares/bowtie2-${BOWTIE2VERSION}-linux-x86_64.zip\
	softwares/tophat-${TOPHAT2VERSION}.tar.gz \
	softwares/sratoolkit.tar.gz \
	softwares/hisat2-2.1.0-Linux_x86_64.zip \
	softwares/hisat-0.1.6-beta-Linux_x86_64.zip\
	softwares/cufflinks-2.2.1.Linux_x86_64.tar.gz \
	softwares/samtools-${SAMVERSION}.tar.bz2 \
	softwares/contextmap_v2_7_9.zip \
	softwares/SOAPsplice-v1.10.tar.gz \
	softwares/STAR-2.5.3a.tar.gz \
	softwares/stringtie-1.3.3b.Linux_x86_64.tar.gz \
	softwares/subread-1.6.0-Linux-x86_64.tar.gz \
	softwares/htslib-1.6.tar.bz2 \
	softwares/crac-2.5.0.tar.gz \
	softwares/gmap-gsnap-2017-11-15.tar.gz \
	control.sh\
	$WORKPATH/ 

## --install packages --##

#WORKDIR $WORKPATH
RUN cd $WORKPATH &&\
	mv control.sh control && \
	chmod +x control && \


##install latest bowtie2###
#ENV BOWTIE2VERSION 2.3.3.1
	#wget -nv --output-document bowtie2-${BOWTIE2VERSION}.zip https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.3.1/bowtie2-${BOWTIE2VERSION}-linux-x86_64.zip/download && \
	unzip bowtie2-${BOWTIE2VERSION}-linux-x86_64.zip && \
#	ADD softwares/bowtie2-${BOWTIE2VERSION}.zip $WORKPATH/ \
##install latest tophat2
#ENV TOPHAT2VERSION 2.1.1
	#wget -nv --output-document tophat-${TOPHAT2VERSION}.tar.gz http://ccb.jhu.edu/software/tophat/downloads/tophat-${TOPHAT2VERSION}.Linux_x86_64.tar.gz && \
	#tar -vxzf tophat-${TOPHAT2VERSION}.tar.gz && \
#	ADD softwares/tophat-${TOPHAT2VERSION}.tar.gz $WORKPATH/ \
## Install SRA Toolkit from http
	#wget -nv --output-document sratoolkit.tar.gz http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz && \
	#tar -vxzf sratoolkit.tar.gz && \
#	ADD softwares/sratoolkit.tar.gz $WORKPATH/ \
## add toolkit path to path variable

#ENV PATH $WORKPATH/sratoolkit.2.8.2-1-ubuntu64/bin:$PATH



# hisat
	#wget -nv ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.1.0-Linux_x86_64.zip && \
	unzip hisat2-2.1.0-Linux_x86_64.zip && \
	unzip hisat-0.1.6-beta-Linux_x86_64.zip && \
#	ADD softwares/hisat2-2.1.0-Linux_x86_64.zip $WORKPATH/ \
#ENV PATH $WORKPATH/hisat2-2.1.0:$PATH

# cufflinks (links merge diff compare) binaries
	#wget -nv --output-document cufflinks-2.2.1.Linux_x86_64.tar.gz http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz && \
	#tar -vxzf cufflinks-2.2.1.Linux_x86_64.tar.gz && \
#	ADD softwares/cufflinks-2.2.1.Linux_x86_64.tar.gz $WORKPATH/ \
#ENV PATH $WORKPATH/cufflinks-2.2.1.Linux_x86_64:$PATH

## Samtools 1.6##
#ENV SAMVERSION 1.6
	#wget -nv https://github.com/samtools/samtools/releases/download/1.6/samtools-${SAMVERSION}.tar.bz2 && \
#	COPY softwares/samtools-${SAMVERSION}.tar.bz2 $WORKPATH/ \
#	bzip2 -d  samtools-${SAMVERSION}.tar.bz2 && \
#	tar -xvf samtools-${SAMVERSION}.tar && \
	cd samtools-${SAMVERSION} && \
	./configure && \
	make install && \
	cd ../htslib-1.6 && \
	./configure && \
	make && \
	make install && \
	pip install numpy \


##ContextMap installation (Java)## 
#ENV WORKPATHHOME /root/home/
#WORKDIR $WORKPATHHOME
	cd  $WORKPATH && \
	#wget https://www.bio.ifi.lmu.de/software/contextmap/contextmap_v2_7_9.zip && \
	unzip contextmap_v2_7_9.zip && \
	#ADD softwares/contextmap_v2_7_9.zip $WORKPATH/ \
	#mkdir /usr/local/bin/contextmap && \
	#cp -a $WORKPATH/ContextMap_v2.7.9/. /usr/local/bin/contextmap/ && \
#ENV MYJAR /usr/local/bin/contextmap/ContextMap_v2.7.9.jar 
##Soapsplice##
	#wget -nv http://soap.genomics.org.cn/down/SOAPsplice-v1.10.tar.gz && \
	#tar -vxzf SOAPsplice-v1.10.tar.gz && \
	#ADD softwares/SOAPsplice-v1.10.tar.gz $WORKPATH/ \
	#mkdir  /usr/local/bin/soapsplice && \
	#cp SOAPsplice-v1.10/bin/* /usr/local/bin/soapsplice/ && \
#ENV PATH $WORKPATH/soapsplice:$PATH

#Install STAR
#WORKDIR $WORKPATH
	#cd $WORKPATH && \
	#git clone https://github.com/alexdobin/STAR.git && \
	#cd /usr/local/bin/STAR-2.5.3a/ && \
	#git checkout 2.5.3a && \
	cd /usr/local/bin/STAR-2.5.3a/source && \
	make STAR && \
	apt-get install -y bc && \
	cd  $WORKPATH/crac-2.5.0 && \
	./configure && \
	make &&\
	make install &&\
	cd $WORKPATH/gmap-2017-11-15 && \
	./configure &&\
	make &&\
	make install &&\
	
#ENV PATH /usr/local/bin/STAR/source:$PATH

	
##cleanup the image
	rm -rf $WORKPATH/bowtie2-${BOWTIE2VERSION}-linux-x86_64.zip \
		$WORKPATH/tophat-${TOPHAT2VERSION}.tar.gz \
		$WORKPATH/sratoolkit.tar.gz \
		$WORKPATH/hisat2-2.1.0-Linux_x86_64.zip \
		$WORKPATH/hisat-0.1.6-beta-Linux_x86_64.zip\
		$WORKPATH/cufflinks-2.2.1.Linux_x86_64.tar.gz \
		$WORKPATH/samtools-${SAMVERSION}.tar \
		$WORKPATH/contextmap_v2_7_9.zip \
		$WORKPATH/SOAPsplice-v1.10.tar.gz \
		$WORKPATH/crac-2.5.0.tar.gz \
		$WORKPATH/htslib-1.6.tar.bz2 \
		$WORKPATH/gmap-gsnap-2017-11-15.tar.gz \
		$WORKPATH/subread-1.6.0-Linux-x86_64.tar.gz &&\
		apt-get clean

#ENV SHELL /bin/bash



# create an app user
#ENV HOME /home/user
#RUN useradd --create-home --home-dir $HOME user \
#    && chmod -R u+rwx $HOME \
#    && chown -R user:user $HOME

#WORKDIR $HOME
#USER user
