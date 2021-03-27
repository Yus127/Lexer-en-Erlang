
-module(lexer).

%% API
-export([open/1, get_char/1, unget_char/1, lee/1, prueba/0, dfa/4, id/0, ws/0, plus/0, dfa/5, search/2]).

prueba() ->
  M_0 = maps:new(),
  M_0a = maps:put($a,1,M_0),
  M_0b = maps:put($b,0,M_0a),

  M_1a = maps:put($a,1,M_0),
  M_1b = maps:put($b,2,M_1a),

  M_2a = maps:put($a,1,M_0),
  M_2b = maps:put($b,3,M_2a),

  M_3a = maps:put($a,1,M_0),
  M_3b = maps:put($b,0,M_3a),

  maps:put(3, M_3b, maps:put(2, M_2b, maps:put(1, M_1b, maps:put(0,M_0b,M_0)))).

-spec dfa(integer(), string(), _, list()) -> accepted | rejected.


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
  M_1_SLASH = maps:put($+,2,M_1_STAR),
  M_1_DOT = maps:put($.,2,M_1_SLASH),
  M_1_LP = maps:put($+,2,M_1_DOT),
  M_1_RP = maps:put($+,2,M_1_LP),
  M_1_SP = maps:put($  ,2,M_1_RP),
  M_1_DOL = maps:put($$,2,M_1_SP),
  M_1_LF = maps:put($\n,2,M_1_DOL),
  {maps:put(1,M_1_LF, maps:put(0, M_0e, M_0)), [{2,$*}],"Variable"}.




plus() ->
  M_0 = maps:new(),
  M_0_PLUS = maps:put($+,1,M_0),
  {maps:put(0, M_0_PLUS, M_0), [{1, no, "Suma" }]}.



ws() ->
  M_0 = maps:new(),
  M_0_BLANK = maps:put(32,1,M_0),
  M_0_LF = maps:put($\n,1,M_0_BLANK),

  M_1_BLANK = maps:put(32,1,M_0),
  M_1_LF = maps:put($\n,1,M_1_BLANK),
  M_1a = maps:put($a,2,M_1_LF),
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
  M_1_LP = maps:put($(,2,M_1_DOT),
  M_1_RP = maps:put($),2,M_1_LP),
  M_1_DOL = maps:put($$,2,M_1_RP),
  {maps:put(1, M_1_DOL, maps:put(0,M_0_LF, M_0)), [{2, $* }], "Blanco"}.






dfa(State,String, Move, Accepted, Lexeme) ->
  %io:format("~w, ~s, ~s~n", [State, String, Lexeme]),
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

%search(State, States)
search(_, []) -> false;
search(State, [H | T]) ->
  case H of
    {State, Star, Token} -> {value, {State, Star, Token}};
    _ -> search(State, T)
  end.



open(Archivo) ->
  case file:open(Archivo, read) of
    {ok, Device} -> {Device, [],'_'};
    {error, Reason} -> {error, Reason}
  end.

get_char({Device, [], _}) ->
  Char = io:get_chars(Device, a, 1),
  case is_list(Char) of
    true -> {Device, [], hd(Char)};
    false -> {Device, [], Char}
  end;
get_char({Device, [H|T], _}) -> {Device, T, H}.

unget_char({Device, Lst, Char}) -> {Device, [Char | Lst], '_'}.

lee(Archivo) -> A1 = open(Archivo), lee1(A1).

lee1(Archivo) ->
  A1 = get_char(Archivo),
  case A1 of
    {_Device, _Lst, eof} -> io:format("");
    {_Device, _Lst, C} -> io:format("~c",[C]), lee1(A1)
  end.