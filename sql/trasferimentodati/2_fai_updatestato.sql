update membri_gerarchica
set cod_dis= 'MEM' where cod_dis= 'ATT';

update membri_gerarchica
set flag_npa= '1' where cod_dis <> 'MEM' OR flag_er= 'N';

update membri_gerarchica
set flag_npa= '0' where flag_npa <> '1';

update membri_gerarchica
set cod_dis= 'MEM' where cod_dis= 'NRC';

update membri_gerarchica
set flag_dis= 'N' where cod_dis= 'MEM' and flag_er= 'S' ;

update membri_gerarchica
set flag_dis= 'S' where cod_dis= 'MEM' and flag_er= 'N' ;

update membri_gerarchica
set flag_dis= 'S' where cod_dis= 'DEC' ;

update membri_gerarchica
set flag_dis= 'S' where cod_dis= 'DIM' ;

update membri_gerarchica
set flag_dis= 'S' where cod_dis= 'TAI' ;

update membri_gerarchica
set flag_dis= 'S' where cod_dis= 'TFE' ;



update membri_gerarchica set cod_prof= '000' where cod_prof is null or cod_prof= "";