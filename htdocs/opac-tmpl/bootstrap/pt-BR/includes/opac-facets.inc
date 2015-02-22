[% IF ( opacfacets && facets_loop && total ) %]
 <div id="search-facets">
 <h4><a href="#" class="menu-collapse-toggle">Refine a sua pesquisa</a></h4>
 <ul class="menu-collapse">
 <li id="availability_facet">Disponibilidade <ul>
 <li>
 [% IF ( available ) %] Exibindo apenas <strong>disponível</strong> exemplares. <a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |url %][% limit_cgi_not_availablity %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |url %][% END %]">Exibir todos os itens</a>
 [% ELSE %]
 <a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |url %][% limit_cgi |url %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |url %][% END %]&amp;limit=available">Limitar aos exemplares atualmente disponíveis.</a>
 [% END %]
 </li>
 </ul>
 [% IF ( related ) %] <li>(pesquisas relacionadas: [% FOREACH relate IN related %][% relate.related_search %][% END %])</li>[% END %]
 </li>

 [% FOREACH facets_loo IN facets_loop %]
 [% IF facets_loo.facets.size > 0 %]
 <li id="[% facets_loo.type_id %]">
 [% IF facets_loo.type_label_Authors %]<h5 id="facet-authors">Autores</h5>[% END %]
 [% IF facets_loo.type_label_Titles %]<h5 id="facet-titles">Títulos</h5>[% END %]
 [% IF facets_loo.type_label_Topics %]<h5 id="facet-topics">Assuntos</h5>[% END %]
 [% IF facets_loo.type_label_Places %]<h5 id="facet-places">Locais</h5>[% END %]
 [% IF facets_loo.type_label_Series %]<h5 id="facet-series">Série</h5>[% END %]
 [% IF facets_loo.type_label_ItemTypes %]<h5 id="facet-itemtypes">Tipo de material</h5>[% END %]
 [% UNLESS singleBranchMode %]
 [% IF ( facets_loo.type_label_HomeLibrary ) %]<span id="facet-home-libraries">Bibliotecas de origem</span>[% END %]
 [% IF ( facets_loo.type_label_HoldingLibrary ) %]<span id="facet-holding-libraries">Bibliotecas</span>[% END %]
 [% END %]
 [% IF facets_loo.type_label_Location %]<h5 id="facet-locations">Locais</h5>[% END %]
 <ul>
 [% FOREACH facet IN facets_loo.facets %]
 <li>
 [% SET query_cgi_f = query_cgi | url %]
 [% SET limit_cgi_f = limit_cgi | url %]
 [% SET url = "/cgi-bin/koha/opac-search.pl?" _ query_cgi_f _ limit_cgi_f %]
 [% IF ( sort_by ) %]
 [% SET url = url _ "&amp;sort_by=" _ sort_by |url %]
 [% END %]
 [% facet.facet_link_value = BLOCK %][% facet.facet_link_value | uri %][% END %]
 [% IF facet.active %]
 [% SET url = url _ "&amp;nolimit=" _ facet.type_link_value _ ":" _ facet.facet_link_value %]
 <span class="facet-label">[% facet.facet_label_value %]</span>
 [<a href="[% url |url%]" title="Remover faceta [% facet.facet_link_value | html %]">x</a>]
 [% ELSE %]
 [% SET url = url _ "&amp;limit=" _ facet.type_link_value _ ":" _ facet.facet_link_value %]
 <span class="facet-label"><a href="[% url |url%]" title="[% facet.facet_title_value |html %]">[% facet.facet_label_value %]</a></span>
 [% IF ( displayFacetCount ) %]
 <span class="facet-count"> ([% facet.facet_count %])</span>
 [% END %]
 [% END %]
 </li>
 [% END %]
 [% IF ( facets_loo.expandable ) %]
 <li class="showmore">
 <a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |url %][% limit_cgi |url %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |url %][% END %][% IF ( offset ) %]
                                            &amp;offset=[% offset |url %][% END %]&amp;expand=[% facets_loo.expand |url %]#[% facets_loo.type_id |url %]">Exibir mais</a>
 </li>
 [% END %]
 </ul>
 </li>
 [% END # / IF facets_loo.facets.size > 0 %]
 [% END # / FOREACH facets_loo  %]
 </ul>
 </div> <!-- / #search-facets -->

 [% IF ( OPACResultsSidebar ) %]
 <div id="opacresultssidebar">
 [% OPACResultsSidebar %]
 </div>
 [% END %]
[% END # / IF opacfacets && facets_loop %]
