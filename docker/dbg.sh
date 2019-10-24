#!/bin/bash

# Parameters
KMER=61
THREADS=6
REPLICA=3
SEQIDX=1000G_2504_high_coverage.fastq.index

# Process samples assigned to this pod
IDX=`echo ${HOSTNAME} | sed 's/^.*-//'`
if [ `echo ${IDX} | grep "^[0-9][0-9]*$" | wc -l` -eq 1 ]
then
    for ID in `cat ${SEQIDX} | grep -v "^#" | cut -f 1 | sort | uniq | awk 'NR%'${REPLICA}'=='${IDX}''`
    do
	FQ1=`cat ${SEQIDX} | grep -w "^${ID}" | cut -f 4`
	FQ2=`cat ${SEQIDX} | grep -w "^${ID}" | cut -f 5`
	curl ${FQ1} -OJ
	curl ${FQ2} -OJ
	FQ1=`echo ${FQ1} | sed 's/^.*\///'`
	FQ2=`echo ${FQ2} | sed 's/^.*\///'`
	#mv ${FQ1} ${ID}.1.fq.gz
	#mv ${FQ2} ${ID}.2.fq.gz
	zcat ${FQ1} | head -n 400000 | gzip -c > ${ID}.1.fq.gz
	zcat ${FQ2} | head -n 400000 | gzip -c > ${ID}.2.fq.gz
	if [ -f ${ID}.1.fq.gz ]
	then
	    if [ -f ${ID}.2.fq.gz ]
	    then
		lighter -t ${THREADS} -r ${ID}.1.fq.gz -r ${ID}.2.fq.gz -trim -discard -k 23 3100000000 0.188
		rm ${ID}.1.fq.gz ${ID}.2.fq.gz
		ls -1 ${ID}.*.cor.fq.gz > ${ID}.list_reads
		bcalm -in ${ID}.list_reads -kmer-size ${KMER} -abundance-min 3
		rm ${ID}.*.cor.fq.gz ${ID}.list_reads
		python /opt/bcalm/scripts/convertToGFA.py ${ID}.unitigs.fa ${ID}.gfa ${KMER}
		gzip ${ID}.unitigs.fa
		gzip ${ID}.gfa
	    fi
	fi
	curl -T ${ID}.unitigs.fa.gz ftp://ftp-exchange.embl-heidelberg.de/pub/exchange/rausch/incoming/ --user anonymous:rausch@embl.de
	curl -T ${ID}.gfa.gz ftp://ftp-exchange.embl-heidelberg.de/pub/exchange/rausch/incoming/ --user anonymous:rausch@embl.de
	rm ${ID}*
    done
fi
