<option value="relevance">Relevância</option>
<optgroup label="Popularidade">
 [% IF ( sort_by == "popularity_dsc" ) %]
 <option value="popularity_dsc" selected="selected">Popularidade (do maior para o menor)</option>
 [% ELSE %]
 <option value="popularity_dsc">Popularidade (do maior para o menor)</option>
 [% END %]
 [% IF ( sort_by == "popularity_asc" ) %]
 <option value="popularity_asc" selected="selected">Popularidade (do menor para o maior)</option>
 [% ELSE %]
 <option value="popularity_asc">Popularidade (do menor para o maior)</option>
 [% END %]
</optgroup>
<optgroup label="Autor">
 [% IF ( sort_by == "author_az" || sort_by == "author_asc" ) %]
 <option value="author_az" selected="selected">Autor (A-Z)</option>
 [% ELSE %]
 <option value="author_az">Autor (A-Z)</option>
 [% END %]
 [% IF ( sort_by == "author_za" || sort_by == "author_dsc" ) %]
 <option value="author_za" selected="selected">Autor (Z-A)</option>
 [% ELSE %]
 <option value="author_za">Autor (Z-A)</option>
 [% END %]
</optgroup>
<optgroup label="Número de chamada">
 [% IF ( sort_by == "call_number_asc" ) %]
 <option value="call_number_asc" selected="selected">Número de chamada (de 0-9 a A-Z)</option>
 [% ELSE %]
 <option value="call_number_asc">Número de chamada (de 0-9 a A-Z)</option>
 [% END %]
 [% IF ( sort_by == "call_number_dsc" ) %]
 <option value="call_number_dsc" selected="selected">Número de chamada (de Z-A a 9-0)</option>
 [% ELSE %]
 <option value="call_number_dsc">Número de chamada (de Z-A a 9-0)</option>
 [% END %]
</optgroup>
<optgroup label="Datas">
 [% IF ( sort_by == "pubdate_dsc" ) %]
 <option value="pubdate_dsc" selected="selected">Date de publicação/Data de copyright: Do mais recente para o mais antigo</option>
 [% ELSE %]
 <option value="pubdate_dsc">Date de publicação/Data de copyright: Do mais recente para o mais antigo</option>
 [% END %]
 [% IF ( sort_by == "pubdate_asc" ) %]
 <option value="pubdate_asc" selected="selected">Data de publicação/Data de copyright: Do mais antigo para o mais recente</option>
 [% ELSE %]
 <option value="pubdate_asc">Data de publicação/Data de copyright: Do mais antigo para o mais recente</option>
 [% END %]
 [% IF ( sort_by == "acqdate_dsc" ) %]
 <option value="acqdate_dsc" selected="selected">Data de Aquisição: Da mais recente para a mais antiga</option>
 [% ELSE %]
 <option value="acqdate_dsc">Data de Aquisição: Da mais recente para a mais antiga</option>
 [% END %]
 [% IF ( sort_by == "acqdate_asc" ) %]
 <option value="acqdate_asc" selected="selected">Data de Aquisição: Da mais recente para a mais antiga</option>
 [% ELSE %]
 <option value="acqdate_asc">Data de Aquisição: Da mais recente para a mais antiga</option>
 [% END %]
</optgroup>
<optgroup label="Título">
 [% IF ( sort_by == "title_az" || sort_by == "title_asc" ) %]
 <option value="title_az" selected="selected">Título (A-Z)</option>
 [% ELSE %]
 <option value="title_az">Título (A-Z)</option>
 [% END %]
 [% IF ( sort_by == "title_za" || sort_by == "title_dsc" ) %]
 <option value="title_za" selected="selected">Titulo (Z-A)</option>
 [% ELSE %]
 <option value="title_za">Titulo (Z-A)</option>
 [% END %]
</optgroup>
