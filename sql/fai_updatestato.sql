update membri_gerarchica
set cod_dis= 'MEM' where cod_dis= 'ATT';

update membri_gerarchica
set flag_npa= 'S' where cod_dis <> 'MEM'OR flag_er= 'N';

update membri_gerarchica
set cod_dis= 'MEM' where cod_dis= 'NRC';

update membri_gerarchica
set flag_npa= 'N' where flag_npa <> 'S';

update membri_gerarchica set cod_prof= '000' where cod_prof is null or cod_prof= "";