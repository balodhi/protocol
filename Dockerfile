FROM ubuntu
LABEL maintainer="blodhi@korea.ac.kr" description="learning the docker environment"
USER root

## --install packages --##
RUN apt-get update && apt-get install -y \
wget \
git \
build-essential\
libncurses5-dev\
zlib1g-dev\
libbz2-dev\
liblzma-dev\
bzip2\
libboost-thread1.58.0\
python\
unzip


ENV WORKPATH="/usr/local/bin"\
BOWTIE2VERSION="2.3.3.1"\
TOPHAT2VERSION="2.1.1"\
SAMVERSION="1.6"\
WORKPATHHOME="/root/home/"\
MYJAR="/usr/local/bin/contextmap/ContextMap_v2.7.9.jar"

#WORKDIR $WORKPATH

##install latest bowtie2###
#ENV BOWTIE2VERSION 2.3.3.1
RUN cd $WORKPATH && \
wget -nv --output-document bowtie2-${BOWTIE2VERSION}.zip https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.3.1/bowtie2-${BOWTIE2VERSION}-linux-x86_64.zip/download && \
unzip bowtie2-${BOWTIE2VERSION}.zip && \
##install latest tophat2
#ENV TOPHAT2VERSION 2.1.1
wget -nv --output-document tophat-${TOPHAT2VERSION}.tar.gz http://ccb.jhu.edu/software/tophat/downloads/tophat-${TOPHAT2VERSION}.Linux_x86_64.tar.gz && \
tar -vxzf tophat-${TOPHAT2VERSION}.tar.gz && \
## Install SRA Toolkit from http
wget -nv --output-document sratoolkit.tar.gz http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz && \
tar -vxzf sratoolkit.tar.gz && \
## add toolkit path to path variable

#ENV PATH $WORKPATH/sratoolkit.2.8.2-1-ubuntu64/bin:$PATH



# hisat
wget -nv ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.1.0-Linux_x86_64.zip && \
unzip hisat2-2.1.0-Linux_x86_64.zip && \
#ENV PATH $WORKPATH/hisat2-2.1.0:$PATH

# cufflinks (links merge diff compare) binaries
wget -nv --output-document cufflinks-2.2.1.Linux_x86_64 http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz && \
tar -vxzf cufflinks-2.2.1.Linux_x86_64 && \
#ENV PATH $WORKPATH/cufflinks-2.2.1.Linux_x86_64:$PATH

## Samtools 1.6##
#ENV SAMVERSION 1.6
wget -nv https://github.com/samtools/samtools/releases/download/1.6/samtools-${SAMVERSION}.tar.bz2 && \
bzip2 -d  samtools-${SAMVERSION}.tar.bz2 && \
tar -xvf samtools-${SAMVERSION}.tar && \
cd samtools-${SAMVERSION} && \
apt-get install -y libcurl4-openssl-dev && \
./configure && \
make install


##ContextMap installation (Java)## 
#ENV WORKPATHHOME /root/home/
#WORKDIR $WORKPATHHOME
RUN cd  $WORKPATHHOME&& \
apt-get update && apt-get install -y \
default-jre && wget https://www.bio.ifi.lmu.de/software/contextmap/contextmap_v2_7_9.zip && unzip contextmap_v2_7_9 && \
mkdir /usr/local/bin/contextmap && \
cp -a /root/home/ContextMap_v2.7.9/. /usr/local/bin/contextmap/ && \
#ENV MYJAR /usr/local/bin/contextmap/ContextMap_v2.7.9.jar 
##Soapsplice##
wget -nv http://soap.genomics.org.cn/down/SOAPsplice-v1.10.tar.gz && \
tar -vxzf SOAPsplice-v1.10.tar.gz && \
mkdir  /usr/local/bin/soapsplice && \
cp SOAPsplice-v1.10/bin/* /usr/local/bin/soapsplice/ && \
#ENV PATH $WORKPATH/soapsplice:$PATH

#Install STAR
#WORKDIR $WORKPATH
cd $WORKPATH && \
git clone https://github.com/alexdobin/STAR.git && \
cd /usr/local/bin/STAR/ && \
git checkout 2.5.3a && \
cd /usr/local/bin/STAR/source && \
make STAR && \
#ENV PATH /usr/local/bin/STAR/source:$PATH
apt-get install -y python\
libboost-thread1.58.0
##set all of the paths##
ENV PATH $WORKPATH/bowtie2-${BOWTIE2VERSION}-linux-x86_64:\
$WORKPATH/tophat-${TOPHAT2VERSION}.Linux_x86_64:\
$WORKPATH/sratoolkit.2.8.2-1-ubuntu64/bin:\
$WORKPATH/hisat2-2.1.0:\
$WORKPATH/cufflinks-2.2.1.Linux_x86_64:\
$WORKPATH/soapsplice:/usr/local/bin/STAR/source:$PATH

##cleanup the image
RUN rm -rf $WORKPATH/bowtie2-${BOWTIE2VERSION}.zip && \
rm -rf $WORKPATH/tophat-${TOPHAT2VERSION}.tar.gz && \
rm -rf $WORKPATH/sratoolkit.tar.gz && \
rm -rf $WORKPATH/hisat2-2.1.0-Linux_x86_64.zip && \
rm -rf $WORKPATH/cufflinks-2.2.1.Linux_x86_64.tar.gz && \
rm -rf $WORKPATH/samtools-${SAMVERSION}.tar && \
rm -rf $WORKPATHHOME/contextmap_v2_7_9.zip && \
rm -rf $WORKPATHHOME/SOAPsplice-v1.10.tar.gz&& \
apt-get clean



#ENV SHELL /bin/bash



# create an app user
#ENV HOME /home/user
#RUN useradd --create-home --home-dir $HOME user \
#    && chmod -R u+rwx $HOME \
#    && chown -R user:user $HOME

#WORKDIR $HOME
#USER user