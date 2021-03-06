% Programa que recibe como entrada un archivo de texto, el cual contiene expresiones aritméticas y comentarios, el cual regresara una tabla con cada uno de los tokens que fueron hallados, indicando el orden en el que fueron encontrados y tipo son.
% Yusdivia Molina Román A01653120
% Lidia Paola Díaz Ramírez A01369117
% Fecha de modificacion: 06/04/2021

-module(lex).
-export([dfa/5, search/2, ws/0, num/0, numDec/0, numExp/0, eq/0, plus/0, minus/0, star/0, comm/0, slash/0, gor/0, id/0, lp/0, rp/0, eo/0, start/0, evaluate/3, print/3, everything/3, lee/2, lexerAritmetico/1]).

% Creación de mapas de mapas y estados finales de aceptación, conforme los diagramas y tablas de transición
ws() ->
  M_0 = maps:new(),
  M_0_BLANK = maps:put(32,1,M_0),
  M_0_BB = maps:put(10,1,M_0_BLANK),
  M_0_LF = maps:put($\n,1,M_0_BB),

  M_1_BLANK = maps:put(32,1,M_0),
  M_1_LF = maps:put($\n,1,M_1_BLANK),
  M_1_BB = maps:put(10,1,M_1_LF),
  M_1a = maps:put($a,2,M_1_BB),
  M_1b = maps:put($b,2,M_1a),
  M_1c = maps:put($c,2,M_1b),
  M_1d = maps:put($d,2,M_1c),
  M_1e = maps:put($e,2,M_1d),
  M_1_0 = maps:put($0,2,M_1e),
  M_1_1 = maps:put($1,2,M_1_0),
  M_1_2 = maps:put($2,2,M_1_1),
  M_1_3 = maps:put($3,2,M_1_2),
  M_1_4 = maps:put($4,2,M_1_3),
  M_1_5 = maps:put($5,2,M_1_4),
  M_1_6 = maps:put($6,2,M_1_5),
  M_1_7 = maps:put($7,2,M_1_6),
  M_1_8 = maps:put($8,2,M_1_7),
  M_1_9 = maps:put($9,2,M_1_8),
  M_1_EQ = maps:put($=,2,M_1_9),
  M_1_PLUS = maps:put($+,2,M_1_EQ),
  M_1_MINUS = maps:put($-,2,M_1_PLUS),
  M_1_STAR = maps:put($*,2,M_1_MINUS),
  M_1_SLASH = maps:put($/,2,M_1_STAR),
  M_1_DOT = maps:put($.,2,M_1_SLASH),
  M_1_GOR = maps:put($^,2,M_1_DOT),
  M_1_LP = maps:put($(,2,M_1_GOR),
  M_1_RP = maps:put($),2,M_1_LP),
  M_1_SL = maps:put($\ ,2,M_1_RP),
  M_1_DOL = maps:put($$,2,M_1_SL),
  {maps:put(1, M_1_DOL, maps:put(0,M_0_LF, M_0)), [{2, $*, "Blanco"}]}.

num() ->
  M_0 = maps:new(),
  M_0_MINUS = maps:put($-,1,M_0),
  M_0_0 = maps:put($0,1,M_0_MINUS),
  M_0_1 = maps:put($1,1,M_0_0),
  M_0_2 = maps:put($2,1,M_0_1),
  M_0_3 = maps:put($3,1,M_0_2),
  M_0_4 = maps:put($4,1,M_0_3),
  M_0_5 = maps:put($5,1,M_0_4),
  M_0_6 = maps:put($6,1,M_0_5),
  M_0_7 = maps:put($7,1,M_0_6),
  M_0_8 = maps:put($8,1,M_0_7),
  M_0_9 = maps:put($9,1,M_0_8),

  M_1a = maps:put($a,2,M_0),
  M_1b = maps:put($b,2,M_1a),
  M_1c = maps:put($c,2,M_1b),
  M_1d = maps:put($d,2,M_1c),
  M_1e = maps:put($e,2,M_1d),
  M_1_0 = maps:put($0,1,M_1e),
  M_1_1 = maps:put($1,1,M_1_0),
  M_1_2 = maps:put($2,1,M_1_1),
  M_1_3 = maps:put($3,1,M_1_2),
  M_1_4 = maps:put($4,1,M_1_3),
  M_1_5 = maps:put($5,1,M_1_4),
  M_1_6 = maps:put($6,1,M_1_5),
  M_1_7 = maps:put($7,1,M_1_6),
  M_1_8 = maps:put($8,1,M_1_7),
  M_1_9 = maps:put($9,1,M_1_8),
  M_1_EQ = maps:put($=,2,M_1_9),
  M_1_PLUS = maps:put($+,2,M_1_EQ),
  M_1_MINUS = maps:put($-,2,M_1_PLUS),
  M_1_STAR = maps:put($*,2,M_1_MINUS),
  M_1_SLASH = maps:put($/,2,M_1_STAR),
  M_1_DOT = maps:put($.,2,M_1_SLASH),
  M_1_GOR = maps:put($^,2,M_1_DOT),
  M_1_LP = maps:put($(,2,M_1_GOR),
  M_1_RP = maps:put($),2,M_1_LP),
  M_1_SL = maps:put($\n ,2,M_1_RP),
  M_1_DOL = maps:put($$,2,M_1_SL),
  M_1_BLANK = maps:put(32,2,M_1_DOL),
  M_1_BB = maps:put(10,2,M_1_BLANK),
  M_1_LF = maps:put($\ ,2,M_1_BB),

  {maps:put(1, M_1_LF, maps:put(0,M_0_9, M_0)), [{2, $*, "Numero entero"}]}.

numDec() ->
  M_0 = maps:new(),
  M_0_MINUS = maps:put($-,1,M_0),
  M_0_0 = maps:put($0,1,M_0_MINUS),
  M_0_1 = maps:put($1,1,M_0_0),
  M_0_2 = maps:put($2,1,M_0_1),
  M_0_3 = maps:put($3,1,M_0_2),
  M_0_4 = maps:put($4,1,M_0_3),
  M_0_5 = maps:put($5,1,M_0_4),
  M_0_6 = maps:put($6,1,M_0_5),
  M_0_7 = maps:put($7,1,M_0_6),
  M_0_8 = maps:put($8,1,M_0_7),
  M_0_9 = maps:put($9,1,M_0_8),
  M_0_DOT = maps:put($.,2,M_0_9),

  M_1_0 = maps:put($0,1,M_0),
  M_1_1 = maps:put($1,1,M_1_0),
  M_1_2 = maps:put($2,1,M_1_1),
  M_1_3 = maps:put($3,1,M_1_2),
  M_1_4 = maps:put($4,1,M_1_3),
  M_1_5 = maps:put($5,1,M_1_4),
  M_1_6 = maps:put($6,1,M_1_5),
  M_1_7 = maps:put($7,1,M_1_6),
  M_1_8 = maps:put($8,1,M_1_7),
  M_1_9 = maps:put($9,1,M_1_8),
  M_1_DOT = maps:put($.,2,M_1_9),

  M_2_0 = maps:put($0,3,M_0),
  M_2_1 = maps:put($1,3,M_2_0),
  M_2_2 = maps:put($2,3,M_2_1),
  M_2_3 = maps:put($3,3,M_2_2),
  M_2_4 = maps:put($4,3,M_2_3),
  M_2_5 = maps:put($5,3,M_2_4),
  M_2_6 = maps:put($6,3,M_2_5),
  M_2_7 = maps:put($7,3,M_2_6),
  M_2_8 = maps:put($8,3,M_2_7),
  M_2_9 = maps:put($9,3,M_2_8),

  M_3a = maps:put($a,4,M_0),
  M_3b = maps:put($b,4,M_3a),
  M_3c = maps:put($c,4,M_3b),
  M_3d = maps:put($d,4,M_3c),
  M_3e = maps:put($e,4,M_3d),
  M_3_0 = maps:put($0,3,M_3e),
  M_3_1 = maps:put($1,3,M_3_0),
  M_3_2 = maps:put($2,3,M_3_1),
  M_3_3 = maps:put($3,3,M_3_2),
  M_3_4 = maps:put($4,3,M_3_3),
  M_3_5 = maps:put($5,3,M_3_4),
  M_3_6 = maps:put($6,3,M_3_5),
  M_3_7 = maps:put($7,3,M_3_6),
  M_3_8 = maps:put($8,3,M_3_7),
  M_3_9 = maps:put($9,3,M_3_8),
  M_3_EQ = maps:put($=,4,M_3_9),
  M_3_PLUS = maps:put($+,4,M_3_EQ),
  M_3_MINUS = maps:put($-,4,M_3_PLUS),
  M_3_STAR = maps:put($*,4,M_3_MINUS),
  M_3_SLASH = maps:put($/,4,M_3_STAR),
  M_3_DOT = maps:put($.,4,M_3_SLASH),
  M_3_GOR = maps:put($^,4,M_3_DOT),
  M_3_LP = maps:put($(,4,M_3_GOR),
  M_3_RP = maps:put($),4,M_3_LP),
  M_3_DOL = maps:put($$,4,M_3_RP),
  M_3_SL = maps:put($\n ,4,M_3_DOL),
  M_3_BLANK = maps:put(32,4,M_3_SL),
  M_3_BB = maps:put(10,4,M_3_BLANK),
  M_3_LF = maps:put($\ ,4,M_3_BB),

  {maps:put(3, M_3_LF, maps:put(2, M_2_9, maps:put(1,M_1_DOT, maps:put(0, M_0_DOT, M_0)))), [{4, $*, "Numero decimal"}]}.

numExp() ->
  M_0 = maps:new(),
  M_0_MINUS = maps:put($-,1,M_0),
  M_0_0 = maps:put($0,1,M_0_MINUS),
  M_0_1 = maps:put($1,1,M_0_0),
  M_0_2 = maps:put($2,1,M_0_1),
  M_0_3 = maps:put($3,1,M_0_2),
  M_0_4 = maps:put($4,1,M_0_3),
  M_0_5 = maps:put($5,1,M_0_4),
  M_0_6 = maps:put($6,1,M_0_5),
  M_0_7 = maps:put($7,1,M_0_6),
  M_0_8 = maps:put($8,1,M_0_7),
  M_0_9 = maps:put($9,1,M_0_8),
  M_0_DOT = maps:put($.,2,M_0_9),

  M_1_0 = maps:put($0,1,M_0),
  M_1_1 = maps:put($1,1,M_1_0),
  M_1_2 = maps:put($2,1,M_1_1),
  M_1_3 = maps:put($3,1,M_1_2),
  M_1_4 = maps:put($4,1,M_1_3),
  M_1_5 = maps:put($5,1,M_1_4),
  M_1_6 = maps:put($6,1,M_1_5),
  M_1_7 = maps:put($7,1,M_1_6),
  M_1_8 = maps:put($8,1,M_1_7),
  M_1_9 = maps:put($9,1,M_1_8),
  M_1_DOT = maps:put($.,2,M_1_9),
  M_1_e = maps:put($e,4,M_1_DOT),

  M_2_0 = maps:put($0,3,M_0),
  M_2_1 = maps:put($1,3,M_2_0),
  M_2_2 = maps:put($2,3,M_2_1),
  M_2_3 = maps:put($3,3,M_2_2),
  M_2_4 = maps:put($4,3,M_2_3),
  M_2_5 = maps:put($5,3,M_2_4),
  M_2_6 = maps:put($6,3,M_2_5),
  M_2_7 = maps:put($7,3,M_2_6),
  M_2_8 = maps:put($8,3,M_2_7),
  M_2_9 = maps:put($9,3,M_2_8),

  M_3_0 = maps:put($0,3,M_0),
  M_3_1 = maps:put($1,3,M_3_0),
  M_3_2 = maps:put($2,3,M_3_1),
  M_3_3 = maps:put($3,3,M_3_2),
  M_3_4 = maps:put($4,3,M_3_3),
  M_3_5 = maps:put($5,3,M_3_4),
  M_3_6 = maps:put($6,3,M_3_5),
  M_3_7 = maps:put($7,3,M_3_6),
  M_3_8 = maps:put($8,3,M_3_7),
  M_3_9 = maps:put($9,3,M_3_8),
  M_3_e = maps:put($e,4,M_3_9),

  M_4_0 = maps:put($0,6,M_0),
  M_4_1 = maps:put($1,6,M_4_0),
  M_4_2 = maps:put($2,6,M_4_1),
  M_4_3 = maps:put($3,6,M_4_2),
  M_4_4 = maps:put($4,6,M_4_3),
  M_4_5 = maps:put($5,6,M_4_4),
  M_4_6 = maps:put($6,6,M_4_5),
  M_4_7 = maps:put($7,6,M_4_6),
  M_4_8 = maps:put($8,6,M_4_7),
  M_4_9 = maps:put($9,6,M_4_8),
  M_4_PLUS = maps:put($+,5,M_4_9),
  M_4_MINUS = maps:put($-,5,M_4_PLUS),

  M_5_0 = maps:put($0,6,M_0),
  M_5_1 = maps:put($1,6,M_5_0),
  M_5_2 = maps:put($2,6,M_5_1),
  M_5_3 = maps:put($3,6,M_5_2),
  M_5_4 = maps:put($4,6,M_5_3),
  M_5_5 = maps:put($5,6,M_5_4),
  M_5_6 = maps:put($6,6,M_5_5),
  M_5_7 = maps:put($7,6,M_5_6),
  M_5_8 = maps:put($8,6,M_5_7),
  M_5_9 = maps:put($9,6,M_5_8),

  M_6a = maps:put($a,7,M_0),
  M_6b = maps:put($b,7,M_6a),
  M_6c = maps:put($c,7,M_6b),
  M_6d = maps:put($d,7,M_6c),
  M_6e = maps:put($e,7,M_6d),
  M_6_0 = maps:put($0,6,M_6e),
  M_6_1 = maps:put($1,6,M_6_0),
  M_6_2 = maps:put($2,6,M_6_1),
  M_6_3 = maps:put($3,6,M_6_2),
  M_6_4 = maps:put($4,6,M_6_3),
  M_6_5 = maps:put($5,6,M_6_4),
  M_6_6 = maps:put($6,6,M_6_5),
  M_6_7 = maps:put($7,6,M_6_6),
  M_6_8 = maps:put($8,6,M_6_7),
  M_6_9 = maps:put($9,6,M_6_8),
  M_6_EQ = maps:put($=,7,M_6_9),
  M_6_PLUS = maps:put($+,7,M_6_EQ),
  M_6_MINUS = maps:put($-,7,M_6_PLUS),
  M_6_STAR = maps:put($*,7,M_6_MINUS),
  M_6_SLASH = maps:put($/,7,M_6_STAR),
  M_6_DOT = maps:put($.,7,M_6_SLASH),
  M_6_GOR = maps:put($^,7,M_6_DOT),
  M_6_LP = maps:put($(,7,M_6_GOR),
  M_6_RP = maps:put($),7,M_6_LP),
  M_6_DOL = maps:put($$,7,M_6_RP),
  M_6_SL = maps:put($\n ,7,M_6_DOL),
  M_6_BLANK = maps:put(32,7,M_6_SL),
  M_6_BB = maps:put(10,7,M_6_BLANK),
  M_6_LF = maps:put($\ ,7,M_6_BB),

  {maps:put(6, M_6_LF, maps:put(5, M_5_9, maps:put(4,M_4_MINUS, maps:put(3, M_3_e, maps:put( 2,M_2_9, maps:put( 1, M_1_e, maps:put(0,M_0_DOT ,M_0))))))), [{7, $*, "Numero notacion cientifica"}]}.

eq() ->
  M_0 = maps:new(),
  M_0_EQ = maps:put($=,1,M_0),

  {maps:put(0, M_0_EQ, M_0), [{1, no, "Asignacion" }]}.

plus() ->
  M_0 = maps:new(),
  M_0_PLUS = maps:put($+,1,M_0),

  {maps:put(0, M_0_PLUS, M_0), [{1, no, "Suma" }]}.

minus() ->
  M_0 = maps:new(),
  M_0_MINUS = maps:put($-,1,M_0),

  {maps:put(0, M_0_MINUS, M_0), [{1, no, "Resta" }]}.

star() ->
  M_0 = maps:new(),
  M_0_STAR = maps:put($*,1,M_0),

  {maps:put(0, M_0_STAR, M_0), [{1, no, "Multipliacion" }]}.

comm() ->
  M_0 = maps:new(),
  M_0_SLASH = maps:put($/,1,M_0),

  M_1_SLASH = maps:put($/,2,M_0),

  M_2a = maps:put($a,2,M_0),
  M_2b = maps:put($b,2,M_2a),
  M_2c = maps:put($c,2,M_2b),
  M_2d = maps:put($d,2,M_2c),
  M_2e = maps:put($e,2,M_2d),
  M_2_0 = maps:put($0,2,M_2e),
  M_2_1 = maps:put($1,2,M_2_0),
  M_2_2 = maps:put($2,2,M_2_1),
  M_2_3 = maps:put($3,2,M_2_2),
  M_2_4 = maps:put($4,2,M_2_3),
  M_2_5 = maps:put($5,2,M_2_4),
  M_2_6 = maps:put($6,2,M_2_5),
  M_2_7 = maps:put($7,2,M_2_6),
  M_2_8 = maps:put($8,2,M_2_7),
  M_2_9 = maps:put($9,2,M_2_8),
  M_2_EQ = maps:put($=,2,M_2_9),
  M_2_PLUS = maps:put($+,2,M_2_EQ),
  M_2_MINUS = maps:put($-,2,M_2_PLUS),
  M_2_STAR = maps:put($*,2,M_2_MINUS),
  M_2_SLASH = maps:put($/,2,M_2_STAR),
  M_2_DOT = maps:put($.,2,M_2_SLASH),
  M_2_GOR = maps:put($^,2,M_2_DOT),
  M_2_LP = maps:put($(,2,M_2_GOR),
  M_2_RP = maps:put($),2,M_2_LP),
  M_2_DOL = maps:put($$,2,M_2_RP),
  M_2_SL = maps:put($\n,3,M_2_DOL),
  M_2_BLANK = maps:put(32,2,M_2_SL),
  M_2_BB = maps:put(10,3,M_2_BLANK),
  M_2_LF = maps:put($\ ,2,M_2_BB),

  {maps:put(2, M_2_LF, maps:put(1, M_1_SLASH, maps:put(0,M_0_SLASH, M_0))), [{3, no, "Comentario"}]}.

slash() ->
  M_0 = maps:new(),
  M_0_SLASH = maps:put($/,1,M_0),

  {maps:put(0, M_0_SLASH, M_0), [{1, no, "Division" }]}.

gor() ->
  M_0 = maps:new(),
  M_0_GOR = maps:put($^,1,M_0),

  {maps:put(0, M_0_GOR, M_0), [{1, no, "Potencia" }]}.

id() ->
  M_0 = maps:new(),
  M_0a = maps:put($a,1,M_0),
  M_0b = maps:put($b,1,M_0a),
  M_0c = maps:put($c,1,M_0b),
  M_0d = maps:put($d,1,M_0c),
  M_0e = maps:put($e,1,M_0d),

  M_1a = maps:put($a,1,M_0),
  M_1b = maps:put($b,1,M_1a),
  M_1c = maps:put($c,1,M_1b),
  M_1d = maps:put($d,1,M_1c),
  M_1e = maps:put($e,1,M_1d),
  M_1_0 = maps:put($0,1,M_1e),
  M_1_1 = maps:put($1,1,M_1_0),
  M_1_2 = maps:put($2,1,M_1_1),
  M_1_3 = maps:put($3,1,M_1_2),
  M_1_4 = maps:put($4,1,M_1_3),
  M_1_5 = maps:put($5,1,M_1_4),
  M_1_6 = maps:put($6,1,M_1_5),
  M_1_7 = maps:put($7,1,M_1_6),
  M_1_8 = maps:put($8,1,M_1_7),
  M_1_9 = maps:put($9,1,M_1_8),
  M_1_EQ = maps:put($=,2,M_1_9),
  M_1_PLUS = maps:put($+,2,M_1_EQ),
  M_1_MINUS = maps:put($-,2,M_1_PLUS),
  M_1_STAR = maps:put($*,2,M_1_MINUS),
  M_1_SLASH = maps:put($/,2,M_1_STAR),
  M_1_DOT = maps:put($.,2,M_1_SLASH),
  M_1_GOR = maps:put($^,2,M_1_DOT),
  M_1_LP = maps:put($(,2,M_1_GOR),
  M_1_RP = maps:put($),2,M_1_LP),
  M_1_DOL = maps:put($$,2,M_1_RP),
  M_1_SL = maps:put($\n,2,M_1_DOL),
  M_1_BLANK = maps:put(32,2,M_1_SL),
  M_1_BB = maps:put(10,2,M_1_BLANK),
  M_1_LF = maps:put($\ ,2,M_1_BB),

  {maps:put(1, M_1_LF, maps:put(0,M_0e, M_0)), [{2, $*, "Variable"}]}.

lp() ->
  M_0 = maps:new(),
  M_0_LP = maps:put($(,1,M_0),

  {maps:put(0, M_0_LP, M_0), [{1, no, "Parentesis que abre"}]}.

rp() ->
  M_0 = maps:new(),
  M_0_RP = maps:put($),1,M_0),

  {maps:put(0, M_0_RP, M_0), [{1, no, "Parentesis que cierra"}]}.

eo() ->
  M_0 = maps:new(),
  M_0_EO = maps:put($$,1,M_0),

  {maps:put(0, M_0_EO, M_0), [{1, no, "Fin"}]}.

%Creación de lista con las tuplas de los mapas de mapas y estados finales de aceptación
start() ->   
  [lex:ws(), lex:numExp(),lex:numDec(),lex:num() ,lex:comm(),lex:rp(), lex:lp(),lex:id(),lex:gor(), lex:slash(), lex:star(), lex:minus(), lex:plus(), lex:eq(), lex:eo()].

%Función inicial donde solo recibe el nombre del archivo que va a leer
lexerAritmetico(Archivo) ->
  lee(Archivo, "$").

%Lectura del archivo enviado por la función lexerAritmetico. Se le añade al final el sigo de pesos ("$") para indicar el fin del archivo
lee(Archivo, Terminador) ->
  {ok, Contenido} = file:read_file(Archivo),
  A= binary_to_list(Contenido) ++ Terminador,
  everything(A, "", "").

%Función que recorre todo el string a evaluarse, con ayuda de la función evaluate. Una vez termina de evaluarse todo el archivo, se crea un archivo de salida y se manda a llamar la función para escribir sobre el archivo
everything([], Lex, Tok) -> 
  {ok, Device}=file:open("salida.txt", write),
  io:format(Device, "~-30s", ["Lexema"]),
  io:format(Device,"~s\n", ["Token"]),
  print(Device, Lex, Tok);
everything(Str, Lex, Tok) ->
  case evaluate(Str, lex:start(), "") of 
    {StrR, LexR, TokR} -> 
    everything(StrR, Lex ++ [LexR], Tok ++ [TokR]);
    _ -> error
  end.

%Función que recibe el string a evaluar y la lista de todos los mapas con sus estados de aceptación. Llama a la función dfa para evaluar si el string coincide con algún elemento de la lista. Regresa error o el string a seguir evaluando, el lexema y el token del encontrado. 
evaluate(_, [], _) -> error;
evaluate(Strin, [H1|T1], Lex) ->
  {Move1, Estate1} = H1,
  case dfa(0, Strin, Move1, Estate1, Lex) of
    {rejected, _} ->
      evaluate(Strin, T1, Lex);
    {accepted, String1, Lexema1, Token} -> {String1, Lexema1, Token}
  end.

%Función que hace la evaluación de los mapas de mapas y estados finales de aceptación con el string a ser leído 
dfa(State, String, Move, Accepted, Lexeme) ->
  case search(State, Accepted) of
    {value, {State, Star, Token}} ->
      case Star of
        $* ->
          X1 = lists:last(Lexeme),
          Lexeme1 = lists:droplast(Lexeme),
          {accepted, [X1 | String], Lexeme1, Token};
        _ -> {accepted, String, Lexeme, Token}
      end;
    _          ->
      case maps:get(State, Move,error) of
        error -> {rejected, String};
        Move1 ->
          [X| Xs] = String,
          case maps:get(X, Move1, error) of
            error -> {rejected, String};
            State1 -> dfa(State1, Xs, Move, Accepted, Lexeme ++ [X])
          end
      end
  end.

%Función de apoyo para evaluar si ya se alcanzó un estado final de aceptación para el dfa. 
search(_, []) -> false;
search(State, [H | T]) ->
  case H of
    {State, Star, Token} -> {value, {State, Star, Token}};
    _ -> search(State, T)
  end.

%Función que escribe sobre el documento abierto por everything. Recibe el documento y dos listas con los lexemas y tokens encontrados
print(Device, [],[]) -> file:close(Device);
print(Device, [HL|TL],[HT|TT]) ->
if 
  HT =="Blanco" ->
    print(Device, TL,TT);
  HT =="Fin" ->
    print(Device, TL, TT);
  true ->
    io:format(Device, "~-30s", [HL]),
    io:format(Device, "~s\n", [HT]),
    print(Device, TL, TT)
    end.