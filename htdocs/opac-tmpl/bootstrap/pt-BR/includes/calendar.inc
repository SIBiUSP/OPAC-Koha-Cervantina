<script type="text/javascript">
    //<![CDATA[
        var debug    = "[% debug %]";
        var dformat  = "[% dateformat %]";
        var sentmsg = 0;
        if (debug > 1) {alert("dateformat: " + dformat + "\ndebug is on (level " + debug + ")");}

        function Date_from_syspref(dstring) {
                var dateX = dstring.split(/[-/]/);
                if (debug > 1 && sentmsg < 1) {sentmsg++; alert("Date_from_syspref(" + dstring + ") splits to:\n" + dateX.join("\n"));}
                if (dformat === "iso") {
                        return new Date(dateX[0], (dateX[1] - 1), dateX[2]);  // YYYY-MM-DD to (YYYY,m(0-11),d)
                } else if (dformat === "us") {
                        return new Date(dateX[2], (dateX[0] - 1), dateX[1]);  // MM/DD/YYYY to (YYYY,m(0-11),d)
                } else if (dformat === "metric") {
                        return new Date(dateX[2], (dateX[1] - 1), dateX[0]);  // DD/MM/YYYY to (YYYY,m(0-11),d)
                } else {
                        if (debug > 0) {alert("KOHA ERROR - Unrecognized date format: " +dformat);}
                        return 0;
                }
        }

        /* Instead of including multiple localization files as you would normally see with
           jQueryUI we expose the localization strings in the default configuration */
        jQuery(function($){
            $.datepicker.regional[''] = {
                closeText: _("Concluído"),
                prevText: _("Ant"),
                nextText: _("Próximo"),
                currentText: _("Hoje"),
                monthNames: [_("Janeiro"),_("Fevereiro"),_("Março"),_("Abril"),_("Mai"),_("Junho"),
                _("Julho"),_("Agosto"),_("Setembro"),_("Outubro"),_("Novembro"),_("Dezembro")],
                monthNamesShort: [_("Jan"), _("Fev"), _("Mar"), _("Abr"), _("Mai"), _("Jun"),
                _("Jul"), _("Ago"), _("Set"), _("Out"), _("Nov"), _("Dez")],
                dayNames: [_("Domingo"), _("Segunda"), _("Terça"), _("Quarta"), _("Quinta"), _("Sexta"), _("Sábado")],
                dayNamesShort: [_("Dom"), _("Meu"), _("ter"), _("Qua"), _("Qui"), _("Sex"), _("Sáb")],
                dayNamesMin: [_("D"),_("S"),_("T"),_("Nós"),_("Q"),_("S"),_("S")],
                weekHeader: _("Wk"),
                dateFormat: '[% IF ( dateformat == "us" ) %]mm/dd/yy[% ELSIF ( dateformat == "metric" ) %]dd/mm/yy[% ELSE %]yy-mm-dd[% END %]',
                firstDay: [% CalendarFirstDayOfWeek %],
                isRTL: [% IF ( bidi ) %]true[% ELSE %]false[% END %],
                showMonthAfterYear: false,
                yearSuffix: ''};
            $.datepicker.setDefaults($.datepicker.regional['']);
        });

        $(document).ready(function(){

        $.datepicker.setDefaults({
                showOn: "both",
                changeMonth: true,
                changeYear: true,
                buttonImage: '[% interface %]/lib/famfamfam/silk/calendar.png',
                buttonImageOnly: true,
                showButtonPanel: true,
                showOtherMonths: true
            });

            $( ".datepicker" ).datepicker();
            // http://jqueryui.com/demos/datepicker/#date-range
            var dates = $( ".datepickerfrom, .datepickerto" ).datepicker({
                changeMonth: true,
                numberOfMonths: 1,
                onSelect: function( selectedDate ) {
                    var option = this.id == "from" ? "minDate" : "maxDate",
                        instance = $( this ).data( "datepicker" );
                        date = $.datepicker.parseDate(
                            instance.settings.dateFormat ||
                            $.datepicker._defaults.dateFormat,
                            selectedDate, instance.settings );
                    dates.not( this ).datepicker( "option", option, date );
                }
            });
        });
    //]]>
</script>
