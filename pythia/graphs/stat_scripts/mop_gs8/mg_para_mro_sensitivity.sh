#!/bin/bash

OUT_FILE="./data/mg_para_mro_sens_mop_gs8.csv"

mg_sens_file="./data/mg_sensitivity_mop_gs8.csv"
para_sens_file="./data/para_sensitivity_mop_gs8.csv"

graphene_spec=`cat ./${mg_sens_file} | grep SPEC | awk '{print $2,"\t",$3,"\t",$4,"\t",$5,"\t",$6,"\t",$7,"\t",$8}'`
graphene_stream=`cat ./${mg_sens_file} | grep STREAM | awk '{print $2,"\t",$3,"\t",$4,"\t",$5,"\t",$6,"\t",$7,"\t",$8}'`
para_spec=`cat ./${para_sens_file} | grep SPEC | awk '{print $2,"\t",$3,"\t",$4,"\t",$5,"\t",$6,"\t",$7,"\t",$8}'`
para_stream=`cat ./${para_sens_file} | grep STREAM | awk '{print $2,"\t",$3,"\t",$4,"\t",$5,"\t",$6,"\t",$7,"\t",$8}'`

echo "SUITE	Config	Mitigation	36ns	66ns	96ns	186ns	336ns	636ns	no_mro" > ${OUT_FILE}
echo "ALL	SPEC	Graphene	${graphene_spec}" >> ${OUT_FILE}
echo "0	0	0	0	0	0	0	0	0	0" >> ${OUT_FILE}
echo "ALL	STREAM	Graphene	${graphene_stream}" >> ${OUT_FILE}
echo "0	0	0	0	0	0	0	0	0	0" >> ${OUT_FILE}
echo "0	0	0	0	0	0	0	0	0	0" >> ${OUT_FILE}
echo "ALL	SPEC	PARA	${para_spec}" >> ${OUT_FILE}
echo "0	0	0	0	0	0	0	0	0	0" >> ${OUT_FILE}
echo "ALL	STREAM	PARA	${para_stream}" >> ${OUT_FILE}
