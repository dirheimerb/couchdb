% Licensed under the Apache License, Version 2.0 (the "License"); you may not
% use this file except in compliance with the License. You may obtain a copy of
% the License at
%
%   http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
% WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
% License for the specific language governing permissions and limitations under
% the License.

-module(aegis_sup).

-behaviour(supervisor).

-vsn(1).


-export([
    start_link/0
]).

-export([
    init/1
]).


start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).


init([]) ->
    Flags = #{
        strategy => one_for_one,
        intensity => 5,
        period => 10
    },
    Children = [
        #{
            id => aegis_key_manager,
            start => {aegis_key_manager, start_link, []},
            shutdown => 5000
        },
        #{
            id => aegis_server,
            start => {aegis_server, start_link, []},
            shutdown => 5000
        }
    ],
    {ok, {Flags, Children}}.