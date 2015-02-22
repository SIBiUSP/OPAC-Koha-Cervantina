[% USE Koha %]
<div id="wrap">
 <div id="header-region">
 <div class="navbar navbar-inverse navbar-static-top">
 <div class="navbar-inner">
 <div class="container-fluid">
 <h1 id="logo">
 <a class="brand" href="/cgi-bin/koha/opac-main.pl">
 [% IF ( LibraryNameTitle ) %] [% LibraryNameTitle %] [% ELSE %] Koha online [% END %] </a>
 </h1>
 [% IF ( Koha.Preference( 'opacbookbag' ) == 1 ) %]
 <div id="cartDetails" class="cart-message">O seu carinho está vazio.</div>
 [% END %]
 <ul class="nav">
 [% IF ( Koha.Preference( 'opacbookbag' ) == 1 ) %]
 <li class="dropdown">
 <a href="#" class="dropdown-toggle" id="cartmenulink" data-toggle="dropdown" role="button">
 <i id="carticon" class="icon-shopping-cart icon-white"></i> <span class="cartlabel">Sacola</span> <span id="basketcount"></span>
 </a>
 <ul aria-labelledby="cartmenulink" role="menu" class="dropdown-menu">
 <li role="presentation">
 <a href="#" id="cartmenuitem" class="cart-message" tabindex="-1" role="menuitem">O seu carinho está vazio.</a>
 </li>
 </ul>
 </li>
 [% END %]
 [% IF ( Koha.Preference( 'virtualshelves' ) == 1 ) && ( Koha.Preference( 'opacbookbag' ) == 1 ) %]
 <li class="divider-vertical"></li>
 [% END %]
 [% IF ( Koha.Preference( 'virtualshelves' ) == 1 ) %]
 <li class="dropdown">
 <a href="#" class="dropdown-toggle" id="listsmenu" data-toggle="dropdown" role="button"><i class="icon-list icon-white"></i> <span class="listslabel">Listas</span> <b class="caret"></b></a>
 <ul aria-labelledby="listsmenu" role="menu" class="dropdown-menu">
 [% IF ( pubshelves ) %]
 <li role="presentation"><a href="/cgi-bin/koha/opac-shelves.pl?display=publicshelves" tabindex="-1" role="menuitem"><strong>Listas públicas</strong></a></li>
 [% FOREACH pubshelvesloo IN pubshelvesloop %]
 <li role="presentation"><a href="/cgi-bin/koha/opac-shelves.pl?viewshelf=[% pubshelvesloo.shelfnumber %]&amp;sortfield=[% pubshelvesloo.sortfield %]" tabindex="-1" role="menuitem">[% pubshelvesloo.shelfname |html %]</a></li>
 [% END %]
 <li role="presentation"><a href="/cgi-bin/koha/opac-shelves.pl?display=publicshelves" tabindex="-1" role="menuitem" class="listmenulink">Ver todos</a></li>
 [% ELSE %]
 <li role="presentation"><a href="#" tabindex="-1" class="menu-inactive" role="menuitem">Não há listas públicas</a></li>
 [% END %]
 <li class="divider" role="presentation"></li>
 [% IF Koha.Preference( 'opacuserlogin' ) == 1 %]
 <li role="presentation"><a href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves" tabindex="-1" role="menuitem"><strong>Listas privadas</strong></a></li>
 [% IF ( loggedinusername ) %]
 [% IF ( barshelves ) %]
 [% FOREACH barshelvesloo IN barshelvesloop %]
 <li role="presentation"><a href="/cgi-bin/koha/opac-shelves.pl?viewshelf=[% barshelvesloo.shelfnumber %]&amp;sortfield=[% barshelvesloo.sortfield %]" tabindex="-1" role="menuitem">[% barshelvesloo.shelfname |html %]</a></li>
 [% END %]
 <li role="presentation"><a href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves" tabindex="-1" role="menuitem" class="listmenulink">Ver todos</a></li>
 [% ELSE %]
 <li role="presentation"><a href="#" tabindex="-1" class="menu-inactive" role="menuitem">Não há listas privadas</a></li>
 <li role="presentation"><a href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves" tabindex="-1" role="menuitem" class="listmenulink">Nova lista</a></li>
 [% END %]
 [% ELSE %]
 <li role="presentation"><a href="/cgi-bin/koha/opac-user.pl" tabindex="-1" class="menu-inactive loginModal-trigger" role="menuitem">Faça o login para criar suas próprias listas</a></li>
 [% END # / IF loggedinusername %]
 [% END # / IF opacuserlogin %]
 </ul> <!-- / .dropdown-menu -->
 </li> <!-- / .dropdown -->
 [% END # / IF virtualshelves %]
 </ul> <!-- / .nav -->
 [% IF Koha.Preference( 'virtualshelves' ) == 1 %]<div id="listsDetails"></div>[% END %]
 [% IF Koha.Preference( 'opacuserlogin' ) == 1 || EnableOpacSearchHistory %]
 <a id="user-menu-trigger" class="pull-right" href="#"><i class="icon-user"></i> <span class="caret"></span></a>
 <div id="members">
 <ul class="nav pull-right">
 [% IF Koha.Preference( 'opacuserlogin' ) == 1 %]
 [% UNLESS ( loggedinusername ) %]
 [% IF Koha.Preference('casAuthentication') %]
 [%# CAS authentication is too complicated for modal window %]
 <li><a href="/cgi-bin/koha/opac-user.pl">Acesse sua conta</a></li>
 [% ELSE %]
 <li><a href="/cgi-bin/koha/opac-user.pl" class="loginModal-trigger" role="button" data-toggle="modal">Acesse sua conta</a></li>
 [% END %]
 [% END %]
 [% IF ( loggedinusername ) %]
 <li><p class="members navbar-text">Bem vindo, <a href="/cgi-bin/koha/opac-user.pl"><span class="loggedinusername">[% FOREACH USER_INF IN USER_INFO %][% USER_INF.title %] [% USER_INF.firstname %] [% USER_INF.surname %][% END %]</span></a></p></li>
 <li class="divider-vertical"></li>
 [% END %]
 [% END %]
 [% IF EnableOpacSearchHistory %]
 <li><p class="navbar-text"><a href="/cgi-bin/koha/opac-search-history.pl" title="Visualizar seu histórico de esquisa">Histórico de pesquisa</a> [<a href="/cgi-bin/koha/opac-search-history.pl?action=delete" class="logout" title="Excluir seu histórico de pesquisa" onclick="return confirm(MSG_DELETE_SEARCH_HISTORY);">x</a>]</p></li>
 <li class="divider-vertical"></li>
 [% END %]
 [% IF Koha.Preference( 'opacuserlogin' ) == 1 %]
 [% IF ( loggedinusername ) %]
 <li><p class="navbar-text">
 [% IF persona %]
 <a class="logout" id="logout" href="/cgi-bin/koha/opac-main.pl?logout.x=1" onclick='navigator.id.logout();'>
 [% ELSE %]
 <a class="logout" id="logout" href="/cgi-bin/koha/opac-main.pl?logout.x=1">
 [% END %] Sair</a></p></li>
 [% END %]
 [% END %]
 </ul>
 </div> <!-- /members -->
 [% END # IF opacuserlogin %]
 </div> <!-- /container-fluid -->
 </div> <!-- /navbar-inner -->
 </div> <!-- /navbar -->

 [% IF ( opacheader ) %]
 <div class="container-fluid">
 <div class="row-fluid">
 <div id="opacheader">
 [% opacheader %]
 </div>
 </div>
 </div>
 [% END %]
 </div> <!-- / header-region -->

 <div class="container-fluid">
 <div class="row-fluid">
 <div id="opac-main-search">
 <!-- <div class="span2">
 [% IF ( opacsmallimage ) %]
 <h1 id="libraryname" style="background-image: url('[% opacsmallimage %]');">
 [% ELSE %]
 <h1 id="libraryname">
 [% END %]
 <a href="/cgi-bin/koha/opac-main.pl">[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Koha Online Catalog[% END %]</a></h1>
 </div> /.span2 -->
 <div class="span12">
 [% IF ( OpacPublic ) %]
 [% UNLESS ( advsearch ) %]
 [% IF ( Koha.Preference( 'OpacAddMastheadLibraryPulldown' ) == 1 ) %]
 <div class="mastheadsearch librarypulldown">
 [% ELSE %]
 <div class="mastheadsearch">
 [% END %]
 [% IF Koha.Preference('OpacCustomSearch') == '' %]
 <form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform" class="form-inline">
 <label for="masthead_search"> Pesquisar [% UNLESS ( Koha.Preference( 'OpacAddMastheadLibraryPulldown' ) == 1 ) %] [% IF ( mylibraryfirst ) %] (em [% mylibraryfirst %] somente)[% END %] [% END %] </label>

 <select name="idx" id="masthead_search">
 [% IF ( ms_kw ) %]
 <option selected="selected" value="">Catálogo da biblioteca</option>
 [% ELSE %]
 <option value="">Catálogo da biblioteca</option>
 [% END # /ms_kw %]
 [% IF ( ms_ti ) %]
 <option selected="selected" value="ti">Título</option>
 [% ELSE %]
 <option value="ti">Título</option>
 [% END # /ms_ti %]
 [% IF ( ms_au ) %]
 <option selected="selected" value="au">Autor</option>
 [% ELSE %]
 <option value="au">Autor</option>
 [% END # /ms_au%]
 [% IF ( ms_su ) %]
 <option selected="selected" value="su">Assunto</option>
 [% ELSE %]
 <option value="su">Assunto</option>
 [% END # /ms_su %]
 [% IF ( ms_nb ) %]
 <option selected="selected" value="nb">ISBN</option>
 [% ELSE %]
 <option value="nb">ISBN</option>
 [% END # /ms_nb%]
 [% IF ( ms_se ) %]
 <option selected="selected" value="se">Série</option>
 [% ELSE %]
 <option value="se">Série</option>
 [% END # /ms_se %]
 [% IF ( numbersphr ) %]
 [% IF ( ms_callnum ) %]
 <option selected="selected" value="callnum,phr">Número de chamada</option>
 [% ELSE %]
 <option value="callnum,phr">Número de chamada</option>
 [% END #/ms_callnum %]
 [% ELSE %]
 [% IF ( ms_callnum ) %]
 <option selected="selected" value="callnum">Número de chamada</option>
 [% ELSE %]
 <option value="callnum">Número de chamada</option>
 [% END # /ms_callnum %]
 [% END # /numbersphr %]
 </select>

 [% UNLESS ( Koha.Preference( 'OpacAddMastheadLibraryPulldown' ) == 1 ) %]
 <div class="input-append nolibrarypulldown">
 [% END %]
 [% IF ( ms_value ) %]
 <input value="[% ms_value |html %]" name="q" type="text" title="Digite os termos de pesquisa" class="transl1" id="translControl1" /><span id="translControl"></span>
 [% ELSE %]
 <input name="q" type="text" title="Digite os termos de pesquisa" class="transl1" id="translControl1" /><span id="translControl"></span>
 [% END # /ms_value %]

 [% UNLESS ( Koha.Preference( 'OpacAddMastheadLibraryPulldown' ) == 1 ) %]
 <button type="submit" id="searchsubmit" class="btn btn-primary">Pesquisar</button>
 </div>
 [% END %]

 [% IF ( Koha.Preference( 'OpacAddMastheadLibraryPulldown' ) == 1 ) %]
 <div class="input-append">
 <select name="branch_group_limit" id="select_library">
 <option value="">Todas as bibliotecas</option>
 [% IF BranchCategoriesLoop %]<optgroup label="Bibliotecas">[% END %]
 [% FOREACH BranchesLoo IN BranchesLoop %]
 [% IF ( BranchesLoo.selected ) %]<option selected="selected" value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>
 [% ELSE %]<option value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>[% END %]
 [% END %]
 [% IF BranchCategoriesLoop %]
 </optgroup>
 <optgroup label="Grupos">
 [% FOREACH bc IN BranchCategoriesLoop %]
 [% IF ( bc.selected ) %]
 <option selected="selected" value="multibranchlimit-[% bc.categorycode %]">[% bc.categoryname %]</option>
 [% ELSE %]
 <option value="multibranchlimit-[% bc.categorycode %]">[% bc.categoryname %]</option>
 [% END # / bc.selected %]
 [% END %]
 </optgroup>
 [% END # / BranchCategoriesLoop %]
 </select>
 <button type="submit" id="searchsubmit" class="btn btn-primary">Pesquisar</button>
 </div>
 [% ELSE %]
 [% IF ( opac_limit_override ) %]
 [% IF ( opac_search_limit ) %]
 <input name="limit" value="[% opac_search_limit %]" type="hidden" />
 [% END %]
 [% ELSE %]
 [% IF ( mylibraryfirst ) %]
 <input name="limit" value="branch:[% mylibraryfirst %]" type="hidden" />
 [% END %]
 [% END # / opac_limit_override %]
 [% END # / OpacAddMastheadLibraryPulldown %]

 </form>
 [% ELSE # / Koha.Preference('OpacCustomSearch') == '' %]
 [% Koha.Preference('OpacCustomSearch') %]
 [% END # / Koha.Preference('OpacCustomSearch') == '' %]
 </div> <!-- / .mastheadsearch -->
 [% END # / UNLESS advsearch %]

 <div class="row-fluid">
 <div id="moresearches">
 <ul>
 <li><a href="/cgi-bin/koha/opac-search.pl">Pesquisa avançada</a></li>
 [% IF ( Koha.Preference( 'UseCourseReserves' ) == 1 ) %]<li><a href="/cgi-bin/koha/opac-course-reserves.pl">Bibliografia de cursos</a></li>[% END %]
 [% IF Koha.Preference( 'OpacBrowser' ) == 1 %]<li><a href="/cgi-bin/koha/opac-browser.pl">Pesquisar por hierarquia</a></li>[% END %]
 [% IF Koha.Preference( 'OpacAuthorities' ) == 1 %]<li><a href="/cgi-bin/koha/opac-authorities-home.pl">Resultados da pesquisa por autoridades</a></li>[% END %]
 [% IF ( ( Koha.Preference( 'opacuserlogin' ) == 1 ) && ( Koha.Preference( 'reviewson' ) == 1 ) && ( Koha.Preference( 'OpacShowRecentComments' ) == 1 ) ) %]<li><a href="/cgi-bin/koha/opac-showreviews.pl">Comentários recentes</a></li>[% END %]
 [% IF Koha.Preference( 'TagsEnabled' ) == 1 %]<li><a href="/cgi-bin/koha/opac-tags.pl">Nuvem de tags</a></li>[% END %]
 [% IF Koha.Preference( 'OpacCloud' ) == 1 %]<li><a href="/cgi-bin/koha/opac-tags_subject.pl">Nuvem de assuntos</a></li>[% END %]
 [% IF Koha.Preference( 'OpacTopissue' ) == 1 %]<li><a href="/cgi-bin/koha/opac-topissues.pl">Mais consultados</a></li>[% END %]
 [% IF Koha.Preference( 'suggestion' ) == 1 %]
 [% IF Koha.Preference( 'AnonSuggestions' ) == 1 %]
 <li><a href="/cgi-bin/koha/opac-suggestions.pl">Sugestões de aquisição</a></li>
 [% ELSIF ( ( Koha.Preference( 'OPACViewOthersSuggestions' ) == 1 ) ) %]
 <li><a href="/cgi-bin/koha/opac-suggestions.pl">Sugestões de aquisição</a></li>
 [% END %]
 [% END %]
 </ul>
 </div> <!-- /#moresearches -->
 </div> <!-- /.row-fluid -->

 [% END # / OpacPublic %]
 </div> <!-- /.span10 -->
 </div> <!-- /.opac-main-search -->
 </div> <!-- / .row-fluid -->
 </div> <!-- /.container-fluid -->

 <!-- Login form hidden by default, used for modal window -->
 <div id="loginModal" class="modal hide" tabindex="-1" role="dialog" aria-labelledby="modalLoginLabel" aria-hidden="true">
 <div class="modal-header">
 <button type="button" class="closebtn" data-dismiss="modal" aria-hidden="true">×</button>
 <h3 id="modalLoginLabel">Acesse sua conta</h3>
 </div>
 <form action="/cgi-bin/koha/opac-user.pl" method="post" name="auth" id="modalAuth">
 <div class="modal-body">
 [% IF ( shibbolethAuthentication ) %]
 [% IF ( invalidShibLogin ) %]
 <!-- This is what is displayed if shibboleth login has failed to match a koha user -->
 <div class="alert alert-info">
 <p>Sorry, your Shibboleth identity does not match a valid library identity. If you have a local login, you may use that below.</p>
 </div>
 [% ELSE %]
 <h4>Shibboleth Login</h4>
 <p>If you have a Shibboleth account, please <a href="[% shibbolethLoginUrl %]">clique aqui para entrar</a>.</p>
 <h4>Local Login</h4>
 [% END %]
 [% END %]
 <input type="hidden" name="koha_login_context" value="opac" />
 <fieldset class="brief">
 <label for="muserid">Login:</label><input type="text" id="muserid" name="userid" />
 <label for="mpassword">Senha:</label><input type="password" id="mpassword" name="password" />
 [% IF Koha.Preference( 'NoLoginInstructions' ) %]
 <div id="nologininstructions-modal">
 [% Koha.Preference( 'NoLoginInstructions' ) %]
 </div>
 [% END %]
 [% IF PatronSelfRegistration && PatronSelfRegistrationDefaultCategory %]<div id="mpatronregistration"><p>Ainda não tem senha? <a href="/cgi-bin/koha/opac-memberentry.pl">Registrar aqui.</a></p></div>[% END %]
 </fieldset>
 </div>
 <div class="modal-footer">
 <input value="Login" type="submit" class="btn btn-primary" />
 <a href="#" data-dismiss="modal" aria-hidden="true" class="cancel">Cancelar</a>
 </div>
 </form> <!-- /#auth -->
 </div> <!-- /#modalAuth -->
