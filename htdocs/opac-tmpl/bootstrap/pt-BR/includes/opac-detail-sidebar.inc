<ul id="action">
 [% UNLESS ( norequests ) %]
 [% IF Koha.Preference( 'opacuserlogin' ) == 1 %]
 [% IF Koha.Preference( 'RequestOnOpac' ) == 1 %]
 [% IF ( AllowOnShelfHolds ) %]
 <li><a class="reserve" href="/cgi-bin/koha/opac-reserve.pl?biblionumber=[% biblionumber %]">Reservar</a></li>
 [% ELSE %]
 [% IF ( ItemsIssued ) %]
 <li><a class="reserve" href="/cgi-bin/koha/opac-reserve.pl?biblionumber=[% biblionumber %]">Reservar</a></li>
 [% END %]
 [% END %]
 [% END %]
 [% END %]
 [% END %]
 <li><a class="print-large" href="#" onclick="window.print();">Imprimir</a></li>
 [% IF Koha.Preference( 'virtualshelves' ) == 1 %]
 [% IF ( ( Koha.Preference( 'opacuserlogin' ) == 1 ) && loggedinusername ) %]
 <li><a class="addtoshelf" href="/cgi-bin/koha/opac-addbybiblionumber.pl?biblionumber=[% biblionumber %]" onclick="Dopop('opac-addbybiblionumber.pl?biblionumber=[% biblionumber %]'); return false;">
 Salvar nas suas listas </a></li>
 [% END %]
 [% END %]
 [% IF Koha.Preference( 'opacbookbag' ) == 1 %]
 [% IF ( incart ) %]
 <li><a class="incart cart[% biblionumber %]" href="#" onclick="addRecord('[% biblionumber %]'); return false;">Na sua sacola</a> <a class="cartRemove cartR[% biblionumber %]" href="#" onclick="delSingleRecord('[% biblionumber %]'); return false;">(remover)</a></li>
 [% ELSE %]
 <li><a class="addtocart cart[% biblionumber %]" href="#" onclick="addRecord('[% biblionumber %]'); return false;">Adicionar a sua sacola</a> <a style="display:none;" class="cartRemove cartR[% biblionumber %]" href="#" onclick="delSingleRecord('[% biblionumber %]'); return false;">(remover)</a></li>
 [% END %]
 [% END %]
 [% IF ( OpacHighlightedWords && query_desc ) %]
 <li>
 <a href="#" class="highlight_toggle" id="highlight_toggle_off">Tirar realce</a>
 <a href="#" class="highlight_toggle" id="highlight_toggle_on">Realçar</a>
 </li>
 [% END %]

 [% IF ( export_options.size ) %]
 <li>
 <div id="export">
 <div class="dropdown">
 <a id="format" class="dropdown-toggle" data-toggle="dropdown" href="#">Salvar registro <b class="caret"></b></a>
 <ul class="dropdown-menu pull-right" role="menu" aria-labelledby="format">
 [% FOREACH option IN export_options %]
 <li>
 <a role="menuitem" href="/cgi-bin/koha/opac-export.pl?op=export&amp;bib=[% biblionumber %]&amp;format=[% option %]">
 [% SWITCH option %] [% CASE 'bibtex' %]BIBTEX [% CASE 'dc' %]Dublin Core (XML) [% CASE 'endnote' %]EndNote [% CASE 'marcxml' %]MARCXML [% CASE 'marc8' %]MARC (non-Unicode/MARC-8) [% CASE 'utf8' %]MARC (Unicode/UTF-8) [% CASE 'marcstd' %]MARC (Unicode/UTF-8, Standard) [% CASE 'mods' %]MODS (XML) [% CASE 'ris' %]RIS [% END %] </a>
 </li>
 [% END %]
 </ul>
 </div>
 </div>
 </li>
 [% END %]

 [% IF ( OPACSearchForTitleIn ) %]
 <li>
 <div id="moresearches_menu">
 <div class="dropdown">
 <a id="furthersearches" class="dropdown-toggle" data-toggle="dropdown" href="#">Pesquisar em outras fontes <b class="caret"></b></a>
 <ul class="dropdown-menu pull-right" role="menu" aria-labelledby="furthersearches">
 <li><a href="#" class="menu-inactive">Pesquisar por este título em:</a></li>
 [% OPACSearchForTitleIn %]
 </ul>
 </div>
 </div>
 </li>
 [% END %]
</ul>
