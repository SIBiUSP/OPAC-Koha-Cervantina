[% UNLESS ( is_popup ) %]
 [% IF ( opaccredits ) %]
 <div class="container-fluid">
 <div class="row-fluid">
 <div class="span12">
 <div id="opaccredits">
 [% opaccredits %]
 </div>
 </div>
 </div>
 </div>
 [% END #/ opaccredits %]

 [% IF ( OpacKohaUrl ) %]
 <div class="container-fluid">
 <div class="row-fluid">
 <div class="span12">
 <div id="koha_url" class="clearfix">
 <p>Powered by [% IF template.name.match('opac-main.tt') %] <a class="koha_url" href="http://koha-community.org">Koha</a>
 [% ELSE %]
 <a class="koha_url" rel="nofollow" href="http://koha-community.org">Koha</a>
 [% END %]</p>
 </div>
 </div> <!-- /.span12 -->
 </div> <!-- /.row-fluid -->
 </div> <!-- /.container-fluid -->
 [% END # / OpacKohaUrl %]

</div> <!-- / #wrap in masthead.inc -->

 [% IF ( opaclanguagesdisplay ) %]
 [% IF ( languages_loop && opaclanguagesdisplay ) %]
 [% UNLESS ( one_language_enabled ) %]
 <div id="changelanguage" class="navbar navbar-fixed-bottom navbar-static-bottom">
 <div class="navbar-inner">
 <ul id="i18nMenu" class="nav">
 <li><p class="lang navbar-text"><strong>Idiomas:&nbsp;</strong></p></li>
 [% FOREACH languages_loo IN languages_loop %]
 [% IF ( languages_loo.group_enabled ) %]
 [% IF ( languages_loo.plural ) %]
 <li class="dropdown">
 <a data-toggle="dropdown" class="dropdown-toggle sublangs" id="show[% languages_loo.rfc4646_subtag %]" href="#">[% IF ( languages_loo.native_description ) %][% languages_loo.native_description %][% ELSE %][% languages_loo.rfc4646_subtag %][% END %] <b class="caret"></b></a>
 <ul id="sub[% languages_loo.rfc4646_subtag %]" class="dropdown-menu">
 [% FOREACH sublanguages_loo IN languages_loo.sublanguages_loop %]
 [% IF ( sublanguages_loo.enabled ) %]
 [% IF ( sublanguages_loo.sublanguage_current ) %]
 <li> <p>[% sublanguages_loo.native_description %] [% sublanguages_loo.script_description %] [% sublanguages_loo.region_description %] [% sublanguages_loo.variant_description %] ([% sublanguages_loo.rfc4646_subtag %])</p></li>
 [% ELSE %]
 <li><a href="/cgi-bin/koha/opac-changelanguage.pl?language=[% sublanguages_loo.rfc4646_subtag %]"> [% sublanguages_loo.native_description %] [% sublanguages_loo.script_description %] [% sublanguages_loo.region_description %] [% sublanguages_loo.variant_description %] ([% sublanguages_loo.rfc4646_subtag %])</a></li>
 [% END %]
 [% END # / IF sublanguages_loo.enabled %]
 [% END # / FOREACH sublanguages_loo %]
 </ul>
 </li> <!-- / .more -->
 [% ELSE %]
 [% IF ( languages_loo.group_enabled ) %]
 [% IF ( languages_loo.current ) %]
 <li class="active"><p class="navbar-text">[% IF ( languages_loo.native_description ) %][% languages_loo.native_description %][% ELSE %][% languages_loo.rfc4646_subtag %][% END %]</p></li>
 [% ELSE %]
 <li><a href="/cgi-bin/koha/opac-changelanguage.pl?language=[% languages_loo.rfc4646_subtag %]">[% IF ( languages_loo.native_description ) %][% languages_loo.native_description %][% ELSE %][% languages_loo.rfc4646_subtag %][% END %]</a></li>
 [% END %]
 [% END # / IF languages_loo.current %]
 [% END # / IF ( languages_loo.plural ) %]
 [% END # / IF ( languages_loo.group_enabled ) %]
 [% END # / FOREACH languages_loo IN languages_loop %]
 </ul> <!-- / #i18menu -->
 </div> <!-- / .navbar-inner -->
 </div> <!-- / #changelanguage -->
 [% END # / UNLESS ( one_language_enabled ) %]
 [% END # / IF ( languages_loop && opaclanguagesdisplay ) %]
 [% END # / IF opaclanguagesdisplay %]
[% END # / UNLESS is_popup %]


<!-- JavaScript includes -->
<script type="text/javascript" src="[% interface %]/[% theme %]/lib/jquery/jquery.js"></script>
<script type="text/javascript" src="[% interface %]/[% theme %]/lib/jquery/jquery-ui.js"></script>
<script type="text/javascript">
// Resolve name collision between jQuery UI and Twitter Bootstrap
$.widget.bridge('uitooltip', $.ui.tooltip);
</script>
<script type="text/javascript" src="[% interface %]/[% theme %]/lib/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="[% interface %]/[% theme %]/js/global.js"></script>
<script type="text/javascript">
    Modernizr.load([
        // Test need for polyfill
        {
            test: window.matchMedia,
            nope: "[% interface %]/[% theme %]/lib/media.match.min.js"
        },
        // and then load enquire
        "[% interface %]/[% theme %]/lib/enquire.min.js",
        "[% interface %]/[% theme %]/js/script.js"
    ]);
</script>
[% IF ( OPACAmazonCoverImages || SyndeticsCoverImages ) %]
<script type="text/javascript">//<![CDATA[
        var NO_AMAZON_IMAGE = _("Capa não disponível");
    //]]>
</script>
<script type="text/javascript" src="[% interface %]/[% theme %]/js/amazonimages.js"></script>
[% END %]

<script type="text/javascript">
    //<![CDATA[
    var MSG_CONFIRM_AGAIN = _("Atenção: não pode continuar. Por favor, confirme mais uma vez")
    var MSG_DELETE_SEARCH_HISTORY = _("Tem certeza de que deseja excluir seu histórico de pesquisa?");
    var MSG_NO_SUGGESTION_SELECTED = _("Nenhuma sugestão foi selecionada");
    [% IF Koha.Preference( 'opacbookbag' ) == 1 or Koha.Preference( 'virtualshelves' ) == 1 %]
        var MSG_BASKET_EMPTY = _("Sua sacola está vazia");
        var MSG_RECORD_IN_BASKET = _("Este exemplar já se encontra em seu carrinho");
        var MSG_RECORD_ADDED = _("Este exemplar foi adicionado ao seu carrinho");
        var MSG_RECORD_REMOVED = _("Este item foi removido de seu carrinho");
        var MSG_NRECORDS_ADDED = _(" exemplar(es) adicionado(s) a sua sacola");
        var MSG_NRECORDS_IN_BASKET = _("já está em sua sacola");
        var MSG_NO_RECORD_SELECTED = _("Nenhum item foi selecionado");
        var MSG_NO_RECORD_ADDED = _("Nenhum item foi adicionado a sua sacola");
        var MSG_CONFIRM_DEL_BASKET = _("Tem certeza de que deseja esvaziar sua sacola?");
        var MSG_CONFIRM_DEL_RECORDS = _("Tem certeza de que deseja remover os itens selecionados?");
        var MSG_ITEM_IN_CART = _("Na sua sacola");
        var MSG_IN_YOUR_CART = _("Itens em seu cesto: ");
        var MSG_ITEM_NOT_IN_CART = _("Adicionar a sua sacola");
        var MSG_NO_RECORD_SELECTED = _("Nenhum item foi selecionado");
    [% END %]
    [% IF ( Koha.Preference( 'opacuserlogin' ) == 1 ) && ( Koha.Preference( 'TagsEnabled' ) == 1 ) %]
        var MSG_TAGS_DISABLED = _("Desculpe, o uso de tags não está habilitado neste sistema.");
        var MSG_TAG_ALL_BAD = _("Nota: sua tag era inteiramente código de marcação. Não foi adicionada. Tente novamente somente com texto.");
        var MSG_ILLEGAL_PARAMETER = _("Erro! Parâmetro ilegal");
        var MSG_TAG_SCRUBBED = _("Nota: sua etiqueta possuia código de marcação que foi removido. A tag foi adicionada como ");
        var MSG_ADD_TAG_FAILED = _("Erro! A operação add_tag falhou em");
        var MSG_ADD_TAG_FAILED_NOTE = _("Nota: você só pode atribuir uma vez a mesma tag. Clique em 'Minhas tags' para ver seu conjunto de tags.");
        var MSG_DELETE_TAG_FAILED = _("Erro! Você não pode apagar a tag");
        var MSG_DELETE_TAG_FAILED_NOTE = _("Nota: você só pode apagar suas próprias tags.")
        var MSG_LOGIN_REQUIRED = _("Você precisa estar logado para adicionar tags.");
        var MSG_TAGS_ADDED = _("Tags adicionadas: ");
        var MSG_TAGS_DELETED = _("Tags adicionadas: ");
        var MSG_TAGS_ERRORS = _("Erros: ");
        var MSG_MULTI_ADD_TAG_FAILED = _("Não é possível adicionar uma ou mais tags.");
        var MSG_NO_TAG_SPECIFIED = _("Nenhuma tag foi especificada.");
    [% END %]
    [% IF ( OPACAmazonCoverImages || SyndeticsCoverImages ) %]
        $(window).load(function() {
            verify_images();
         });
    [% END %]
    //]]>
</script>

[% IF Koha.Preference( 'opacbookbag' ) == 1 %]
 <script type="text/javascript" src="[% interface %]/[% theme %]/js/basket.js"></script>
[% ELSIF ( Koha.Preference( 'virtualshelves' ) == 1 ) %]
 <script type="text/javascript" src="[% interface %]/[% theme %]/js/basket.js"></script>
[% ELSE %]
 <script type="text/javascript">var readCookie;</script>
[% END %]

[% IF Koha.Preference( 'opacuserlogin' ) == 1 %][% IF Koha.Preference( 'TagsEnabled' ) == 1 %]<script type="text/javascript" src="[% interface %]/[% theme %]/js/tags.js"></script>[% END %][% ELSE %][% END %]
[% IF ( GoogleJackets ) %]
 <script type="text/javascript" src="[% interface %]/[% theme %]/js/google-jackets.js"></script>
 <script type="text/javascript">
        //<![CDATA[
        var NO_GOOGLE_JACKET = _("Capa não disponível");
        //]]>
    </script>
[% END %]
[% IF OpenLibraryCovers %]
 <script type="text/javascript" src="[% interface %]/[% theme %]/js/openlibrary.js"></script>
 <script type="text/javascript">
    //<![CDATA[
    var NO_OL_JACKET = _("Capa não disponível");
    var OL_PREVIEW = _("Preview");
    //]]>
    </script>
[% END %]

[% IF OPACLocalCoverImages %]
 <script type="text/javascript" src="[% interface %]/[% theme %]/js/localcovers.js"></script>
 <script type="text/javascript">
    //<![CDATA[
    var NO_LOCAL_JACKET = _("Capa não disponível");
    //]]>
    </script>
[% END %]

[% IF ( BakerTaylorEnabled ) %]
 <script type="text/javascript" src="[% interface %]/[% theme %]/js/bakertaylorimages.js"></script>
 <script type="text/javascript">
        //<![CDATA[
        var NO_BAKERTAYLOR_IMAGE = _("Capa não disponível");
        $(window).load(function(){
            bt_verify_images();
        });
        //]]>
    </script>
[% END %]
[% IF ( GoogleIndicTransliteration ) %]
 <script type="text/javascript" src="http://www.google.com/jsapi"></script>
 <script type="text/javascript" src="[% interface %]/[% theme %]/js/googleindictransliteration.js"></script>
[% END %]
[% IF persona %]
 <script src="https://login.persona.org/include.js"></script>
 <script type="text/javascript">

    navigator.id.watch({
        loggedInUser: [% IF emailaddress && loggedinpersona %]'[% emailaddress %]'[% ELSE %]null[% END %],
        onlogin: function (assertion) {
            $.post('/cgi-bin/koha/svc/login',
                { assertion: assertion },
                function (data) {
                    window.location = '/cgi-bin/koha/opac-user.pl';
                }
            )
            .fail(function() { var errstr = _("Não foi possível fazer o login, talvez seu e-mail esteja errado");
                alert(errstr);
            });
        },
        onlogout: function () {
            window.location = '/cgi-bin/koha/opac-main.pl?logout.x=1';
        }
    });

    var signinLink = document.getElementById('browserid');

    if (signinLink) {
        signinLink.onclick = function(evt) {
            // Requests a signed identity assertion from the user.
            navigator.id.request({
                siteName: "[% LibraryName | html %]",
                returnTo: '/cgi-bin/koha/opac-user.pl',
                oncancel: function() { alert('user refuses to share identity.'); }
                });
            };
    }

    </script>
[% END #  / IF persona %]
[% PROCESS jsinclude %]

[% IF ( opacuserjs ) %]
 <script type="text/javascript">
        //<![CDATA[
        [% opacuserjs %]
        //]]>
    </script>
[% END %]
</body>
</html>
