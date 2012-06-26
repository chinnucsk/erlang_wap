-module(controller_chat).
-author("ramy.daghstani@gmail.com").
-export([init/3]).

-include("/usr/lib/yaws/include/yaws_api.hrl").
-include("wap.hrl").
-compile(export_all).

init(Kernel, "", A) ->
	apply(?MODULE, default, [Kernel, "",  A]);

init(Kernel, Parameters, A) ->
	try (apply(?MODULE, list_to_atom(Parameters), [Kernel, [],  A])) of
		ok -> ok
	catch
		error:undef -> init(Kernel, "", A)
	end.

default(Kernel, _ExtraParameters, A) ->
  CD = lib_cookie:getcookiedata(A),
  case CD#cookiedata.permission of
    anonymous -> Kernel ! {ok, view_login:out(A)};
    _ -> Kernel ! {ok, view_chat:out(A)}
  end,
	ok.