

<!DOCTYPE stylesheet [<!ENTITY nbsp "&#160;" >]>

<!-- $Id: MARC21slim2DC.xsl,v 1.1 2003/01/06 08:20:27 adam Exp $ -->
<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:items="http://www.koha-community.org/items"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="marc items">
 <xsl:import href="NORMARCslimUtils.xsl"/>
 <xsl:output method = "html" indent="yes" omit-xml-declaration = "yes" encoding="UTF-8"/>
 <xsl:key name="item-by-status" match="items:item" use="items:status"/>
 <xsl:key name="item-by-status-and-branch" match="items:item" use="concat(items:status, ' ', items:homebranch)"/>

 <xsl:template match="/">
 <xsl:apply-templates/>
 </xsl:template>
 <xsl:template match="marc:record">

 <!-- System preferences -->
 <xsl:variable name="BiblioDefaultView" select="marc:sysprefs/marc:syspref[@name='BiblioDefaultView']"/>
 <xsl:variable name="UseControlNumber" select="marc:sysprefs/marc:syspref[@name='UseControlNumber']"/>
 <xsl:variable name="DisplayOPACiconsXSLT" select="marc:sysprefs/marc:syspref[@name='DisplayOPACiconsXSLT']"/>
 <xsl:variable name="singleBranchMode" select="marc:sysprefs/marc:syspref[@name='singleBranchMode']"/>

 <xsl:variable name="leader" select="marc:leader"/>
 <xsl:variable name="leader6" select="substring($leader,7,1)"/>
 <xsl:variable name="leader7" select="substring($leader,8,1)"/>
 <xsl:variable name="biblionumber" select="marc:datafield[@tag=999]/marc:subfield[@code='c']"/>
 <xsl:variable name="isbn" select="marc:datafield[@tag=020]/marc:subfield[@code='a']"/>
 <xsl:variable name="controlField007" select="marc:controlfield[@tag=007]"/>
 <xsl:variable name="controlField007-00" select="substring($controlField007,1,1)"/>
 <xsl:variable name="controlField007-01" select="substring($controlField007,2,1)"/>
 <xsl:variable name="controlField008" select="marc:controlfield[@tag=008]"/>
 <xsl:variable name="field019b" select="marc:datafield[@tag=019]/marc:subfield[@code='b']"/>
 <xsl:variable name="typeOf008">
 <!-- The logic here should be exactly the same for NORMARCslim2intranetDetail.xsl, NORMARCslim2intranetResults.xsl, NORMARCslim2OPACDetail.xsl and NORMARCslim2OPACResults.xsl -->
 <xsl:choose>
 <xsl:when test="$field019b='b' or $field019b='k' or $field019b='l' or $leader6='b'">Meu</xsl:when>
 <xsl:when test="$field019b='e' or contains($field019b,'ec') or contains($field019b,'ed') or contains($field019b,'ee') or contains($field019b,'ef') or $leader6='g'">FV</xsl:when>
 <xsl:when test="$field019b='c' or $field019b='d' or contains($field019b,'da') or contains($field019b,'db') or contains($field019b,'dc') or contains($field019b,'dd') or contains($field019b,'dg') or contains($field019b,'dh') or contains($field019b,'di') or contains($field019b,'dj') or contains($field019b,'dk') or $leader6='c' or $leader6='d' or $leader6='i' or $leader6='j'">Música</xsl:when>
 <xsl:when test="$field019b='a' or contains($field019b,'ab') or contains($field019b,'aj') or $leader6='e' or $leader6='f'">Face</xsl:when>
 <xsl:when test="$field019b='f' or $field019b='i' or contains($field019b,'ib') or contains($field019b,'ic') or contains($field019b,'fd') or contains($field019b,'ff') or contains($field019b,'fi') or $leader6='k'">gra</xsl:when>
 <xsl:when test="$field019b='g' or contains($field019b,'gb') or contains($field019b,'gd') or contains($field019b,'ge') or $leader6='m'">Fio</xsl:when>
 <xsl:when test="$leader6='o'">kom</xsl:when>
 <xsl:when test="$field019b='h' or $leader6='r'">trd</xsl:when>
 <xsl:when test="$field019b='j' or $leader6='a'">
 <xsl:choose>
 <xsl:when test="$leader7='a' or $leader7='c' or $leader7='m' or $leader7='p'">Meu</xsl:when>
 <xsl:when test="$field019b='j' or $leader7='b' or $leader7='s'">Para</xsl:when>
 </xsl:choose>
 </xsl:when>
 </xsl:choose>
 </xsl:variable>
 <xsl:variable name="controlField008-23" select="substring($controlField008,24,1)"/>
 <xsl:variable name="controlField008-21" select="substring($controlField008,22,1)"/>
 <xsl:variable name="controlField008-22" select="substring($controlField008,23,1)"/>
 <xsl:variable name="controlField008-24" select="substring($controlField008,25,4)"/>
 <xsl:variable name="controlField008-26" select="substring($controlField008,27,1)"/>
 <xsl:variable name="controlField008-29" select="substring($controlField008,30,1)"/>
 <xsl:variable name="controlField008-34" select="substring($controlField008,35,1)"/>
 <xsl:variable name="controlField008-33" select="substring($controlField008,34,1)"/>
 <xsl:variable name="controlField008-30-31" select="substring($controlField008,31,2)"/>

 <xsl:variable name="physicalDescription">

 <!-- Why are these treated specially?

 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='a']">
 reformatted digital
 </xsl:if>
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='b']">
 digitized microfilm
 </xsl:if>
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='d']">
 digitized other analog
 </xsl:if>

 <xsl:variable name="check008-23">
 <xsl:if test="$typeOf008='BK' or $typeOf008='MU' or $typeOf008='CR' or $typeOf008='MX'">
 <xsl:value-of select="true()"></xsl:value-of>
 </xsl:if>
 </xsl:variable>
 <xsl:variable name="check008-29">
 <xsl:if test="$typeOf008='MP' or $typeOf008='VM'">
 <xsl:value-of select="true()"></xsl:value-of>
 </xsl:if>
 </xsl:variable>

 <xsl:choose>
 <xsl:when test="($check008-23 and $controlField008-23='f') or ($check008-29 and $controlField008-29='f')">
 braille
 </xsl:when>
 <xsl:when test="($controlField008-23=' ' and ($leader6='c' or $leader6='d')) or (($typeOf008='BK' or $typeOf008='CR') and ($controlField008-23=' ' or $controlField008='r'))">
 print
 </xsl:when>
 <xsl:when test="$leader6 = 'm' or ($check008-23 and $controlField008-23='s') or ($check008-29 and $controlField008-29='s')">
 electronic
 </xsl:when>
 <xsl:when test="($check008-23 and $controlField008-23='b') or ($check008-29 and $controlField008-29='b')">
 microfiche
 </xsl:when>
 <xsl:when test="($check008-23 and $controlField008-23='a') or ($check008-29 and $controlField008-29='a')">
 microfilm
 </xsl:when>
 </xsl:choose>

 -->

 <!-- 019$b from BSMARC -->

 <xsl:if test="$field019b">
 <xsl:if test="$field019b='a'"> Material cartográfico</xsl:if>
 <xsl:if test="contains($field019b,'ab')"> Atlas</xsl:if>
 <xsl:if test="contains($field019b,'aj')"> Mapa</xsl:if>
 <xsl:if test="$field019b='b'"> Manuscrito</xsl:if>
 <xsl:if test="$field019b='c'"> Partitura</xsl:if>
 <xsl:if test="$field019b='d'"> Gravação de áudio</xsl:if>
 <xsl:if test="contains($field019b,'da')"> Placa Gramophone</xsl:if>
 <xsl:if test="contains($field019b,'db')"> Fita cassete</xsl:if>
 <xsl:if test="contains($field019b,'dc')"> Placa compacta</xsl:if>
 <xsl:if test="contains($field019b,'dd')"> Avspiller med lydfil (eks. Digibøker)</xsl:if>
 <xsl:if test="contains($field019b,'dg')"> Música</xsl:if>
 <xsl:if test="contains($field019b,'dh')"> Språkkurs</xsl:if>
 <xsl:if test="contains($field019b,'di')"> Áudiolivro</xsl:if>
 <xsl:if test="contains($field019b,'dj')"> Discurso de outros/outras</xsl:if>
 <xsl:if test="contains($field019b,'dk')"> Documento combinado</xsl:if>
 <xsl:if test="$field019b='e'"> Cinema e vídeo</xsl:if>
 <xsl:if test="contains($field019b,'ec')"> Sala de cinema</xsl:if>
 <xsl:if test="contains($field019b,'ed')"> Videocassete (VHS)</xsl:if>
 <xsl:if test="contains($field019b,'ee')"> Disco de vídeo (DVD)</xsl:if>
 <xsl:if test="contains($field019b,'ef')"> Disco Blu-ray</xsl:if>
 <xsl:if test="$field019b='f'"> Material impresso</xsl:if>
 <xsl:if test="contains($field019b,'fd')"> Dias</xsl:if>
 <xsl:if test="contains($field019b,'ff')"> Fotografia</xsl:if>
 <xsl:if test="contains($field019b,'fi')"> Reprodução de arte</xsl:if>
 <xsl:if test="$field019b='g'"> Recursos eletrônicos</xsl:if>
 <xsl:if test="contains($field019b,'gb')"> Disquete</xsl:if>
 <xsl:if test="contains($field019b,'gd')"> Disco óptico (CD-ROM)</xsl:if>
 <xsl:if test="contains($field019b,'ge')"> Recursos web</xsl:if>
 <xsl:if test="$field019b='h'"> Objeto tridimensional</xsl:if>
 <xsl:if test="$field019b='i'"> Microforma</xsl:if>
 <xsl:if test="contains($field019b,'ib')"> Microfilme</xsl:if>
 <xsl:if test="contains($field019b,'ic')"> Microfilme</xsl:if>
 <xsl:if test="$field019b='j'"> Periódicos</xsl:if>
 <xsl:if test="$field019b='k'"> Artikler (i bøker eller periodika)</xsl:if>
 <xsl:if test="$field019b='l'"> Fysiske bøker</xsl:if>
 </xsl:if>

 <!-- Check positions 00 and 01 of controlfield 007 -->

 <xsl:if test="$controlField007-00='a'">
 <!-- Kartografisk materiale (unntatt globus) -->
 <xsl:if test="$controlField007-01='a'">Mapa anamórfico</xsl:if>
 <xsl:if test="$controlField007-01='b'">Atlas</xsl:if>
 <xsl:if test="$controlField007-01='c'">Arte da fantasia</xsl:if>
 <xsl:if test="$controlField007-01='d'">Flykart</xsl:if>
 <xsl:if test="$controlField007-01='e'">Sjøkart</xsl:if>
 <xsl:if test="$controlField007-01='f'">Mapa do site</xsl:if>
 <xsl:if test="$controlField007-01='g'">Diagrama de blocos</xsl:if>
 <xsl:if test="$controlField007-01='h'">Mapa estelar</xsl:if>
 <xsl:if test="$controlField007-01='j'">Mapa</xsl:if>
 <xsl:if test="$controlField007-01='k'">Perfil</xsl:if>
 <xsl:if test="$controlField007-01='l'">Fotografia</xsl:if>
 <xsl:if test="$controlField007-01='m'">Mosaico de fotos</xsl:if>
 <xsl:if test="$controlField007-01='n'">Paisagem</xsl:if>
 <xsl:if test="$controlField007-01='o'">Mapa de caracteres</xsl:if>
 <xsl:if test="$controlField007-01='p'">Trykt kart</xsl:if>
 <xsl:if test="$controlField007-01='q'">Modelo de terreno</xsl:if>
 <xsl:if test="$controlField007-01='r'">Remover análise de imagem</xsl:if>
 <xsl:if test="$controlField007-01='s'">Área dos mapas</xsl:if>
 <xsl:if test="$controlField007-01='t'">Planta</xsl:if>
 <xsl:if test="$controlField007-01='y'">Mapa em perspectiva</xsl:if>
 <xsl:if test="$controlField007-01='z'">Outros tipos de mapa</xsl:if>
 </xsl:if>

 <xsl:if test="$controlField007-00='c'">
 <!-- Maskinlesbar fil -->
 <xsl:if test="$controlField007-01='a'">Disco óptico magnético</xsl:if>
 <xsl:if test="$controlField007-01='b'">Cartão de memória</xsl:if>
 <xsl:if test="$controlField007-01='c'">Fita óptica</xsl:if>
 <xsl:if test="$controlField007-01='d'">Disquete</xsl:if>
 <xsl:if test="$controlField007-01='h'">Disco rígido</xsl:if>
 <xsl:if test="$controlField007-01='k'">Magnetbåndkassett</xsl:if>
 <xsl:if test="$controlField007-01='m'">Magnetbåndspole</xsl:if>
 <xsl:if test="$controlField007-01='n'">Acesso remoto (online)</xsl:if>
 <xsl:if test="$controlField007-01='o'">Disco óptico</xsl:if>
 <xsl:if test="$controlField007-01='z'">Outros meios de armazenamento</xsl:if>
 </xsl:if>

 <xsl:if test="$controlField007-00='d'">
 <!-- Globus -->
 <xsl:if test="$controlField007-01='a'">Globo estelar</xsl:if>
 <xsl:if test="$controlField007-01='b'">Planet- eller måneglobus</xsl:if>
 <xsl:if test="$controlField007-01='c'">Globo</xsl:if>
 <xsl:if test="$controlField007-01='z'">Outros tipos de globo</xsl:if>
 </xsl:if>

 <xsl:if test="$controlField007-00='g'">
 <!-- Grafisk materiale som er tenkt projisert eller gjennomlyst -->
 <xsl:if test="$controlField007-01='h'">Holograma</xsl:if>
 <xsl:if test="$controlField007-01='o'">Billedbånd</xsl:if>
 <xsl:if test="$controlField007-01='p'">Imagem estereofônica</xsl:if>
 <xsl:if test="$controlField007-01='r'">Røntgenbilde</xsl:if>
 <xsl:if test="$controlField007-01='s'">Dia</xsl:if>
 <xsl:if test="$controlField007-01='t'">Transparências</xsl:if>
 <xsl:if test="$controlField007-01='z'">Outros tipos de material</xsl:if>
 </xsl:if>

 <xsl:if test="$controlField007-00='h'">
 <!-- Mikroform -->
 <xsl:if test="$controlField007-01='a'">Postais</xsl:if>
 <xsl:if test="$controlField007-01='c'">Cartucho de microfilme</xsl:if>
 <xsl:if test="$controlField007-01='d'">Microfilme</xsl:if>
 <xsl:if test="$controlField007-01='e'">Microfilme</xsl:if>
 <xsl:if test="$controlField007-01='g'">Micro-opaco</xsl:if>
 <xsl:if test="$controlField007-01='z'">Outros tipos de microforma</xsl:if>
 </xsl:if>

 <xsl:if test="$controlField007-00='k'">
 <!-- Grafisk materiale som er ugjennomtrengelig for lys -->
 <xsl:if test="$controlField007-01='c'">Montagem</xsl:if> <!-- Originalt kunstverk -->
 <xsl:if test="$controlField007-01='d'">Desenho</xsl:if> <!-- Originalt kunstverk -->
 <xsl:if test="$controlField007-01='e'">Quadro</xsl:if> <!-- Originalt kunstverk -->
 <xsl:if test="$controlField007-01='g'">Negativo fotográfico</xsl:if>
 <xsl:if test="$controlField007-01='h'">Fotografia</xsl:if> <!-- Brukes også om ugjennomsiktige stereobilder. -->
 <xsl:if test="$controlField007-01='i'">Imagem</xsl:if> <!-- Brukes når en mer spesifikk betegnelse er ukjent eller uønsket. -->
 <xsl:if test="$controlField007-01='j'">Folha gráfica</xsl:if>
 <xsl:if test="$controlField007-01='k'">Flipover</xsl:if>
 <xsl:if test="$controlField007-01='l'">Desenho técnico</xsl:if>
 <xsl:if test="$controlField007-01='m'">Lousa</xsl:if>
 <xsl:if test="$controlField007-01='n'">Quadro</xsl:if>
 <xsl:if test="$controlField007-01='o'">Figuras</xsl:if>
 <xsl:if test="$controlField007-01='p'">Cartão postal</xsl:if>
 <xsl:if test="$controlField007-01='q'">Cartão símbolo</xsl:if>
 <xsl:if test="$controlField007-01='r'">Reprodução de arte</xsl:if>
 <xsl:if test="$controlField007-01='s'">Cartão postal</xsl:if>
 <xsl:if test="$controlField007-01='t'">Cartaz</xsl:if>
 <xsl:if test="$controlField007-01='z'">Outros tipos de material</xsl:if>
 </xsl:if>

 <xsl:if test="$controlField007-00='m'">
 <!-- Film -->
 <xsl:if test="$controlField007-01='c'">Filmsløyfe</xsl:if>
 <xsl:if test="$controlField007-01='f'">Fita de vídeo</xsl:if>
 <xsl:if test="$controlField007-01='r'">Sala de cinema</xsl:if>
 <xsl:if test="$controlField007-01='z'">Outros tipos de filme</xsl:if>
 </xsl:if>

 <xsl:if test="$controlField007-00='s'">
 <!-- Lydopptak -->
 <xsl:if test="$controlField007-01='c'">Placa compacta</xsl:if>
 <xsl:if test="$controlField007-01='d'">Placa Gramophone</xsl:if>
 <xsl:if test="$controlField007-01='e'">Cilindro</xsl:if> <!-- Lydrull, voksrull, fonografsylinder -->
 <xsl:if test="$controlField007-01='g'">Sløyfekassett</xsl:if>
 <xsl:if test="$controlField007-01='i'">Trilha sonora de filme</xsl:if>
 <xsl:if test="$controlField007-01='q'">Rolo (piano de rolo/ órgão de rolo)</xsl:if>
 <xsl:if test="$controlField007-01='s'">Fita cassete</xsl:if>
 <xsl:if test="$controlField007-01='t'">Lydbånd</xsl:if>
 <xsl:if test="$controlField007-01='w'">Wire</xsl:if>
 <xsl:if test="$controlField007-01='z'">Outros materiais de áudio</xsl:if>
 </xsl:if>

 <xsl:if test="$controlField007-00='u'">
 <!-- Tre-dimensjonal gjenstand -->
 <xsl:if test="$controlField007-01='a'">Obra de arte original</xsl:if> <!-- F.eks. en skulptur. -->
 <xsl:if test="$controlField007-01='c'">Reprodução de arte</xsl:if>
 <xsl:if test="$controlField007-01='d'">Diorama</xsl:if>
 <xsl:if test="$controlField007-01='e'">Øvelsesmodell</xsl:if>
 <xsl:if test="$controlField007-01='g'">Desempenho</xsl:if>
 <xsl:if test="$controlField007-01='p'">Mikroskopdia</xsl:if>
 <xsl:if test="$controlField007-01='q'">Modelo</xsl:if>
 <xsl:if test="$controlField007-01='r'">Realia</xsl:if>
 <xsl:if test="$controlField007-01='u'">Exibir</xsl:if>
 <xsl:if test="$controlField007-01='z'">Outros tipos de objeto</xsl:if>
 </xsl:if>

 <xsl:if test="$controlField007-00='v'">
 <!-- Videoopptak -->
 <xsl:if test="$controlField007-01='d'">Disco de vídeo</xsl:if>
 <xsl:if test="$controlField007-01='f'">Videocassete</xsl:if>
 <xsl:if test="$controlField007-01='r'">Bobina de vídeo</xsl:if>
 <xsl:if test="$controlField007-01='z'">Outros tipos de vídeo</xsl:if>
 </xsl:if>

 </xsl:variable>

 <!-- Tittel og ansvarsopplysninger -->
 <a>
 <xsl:attribute name="href">
 <xsl:call-template name="buildBiblioDefaultViewURL">
 <xsl:with-param name="BiblioDefaultView">
 <xsl:value-of select="$BiblioDefaultView"/>
 </xsl:with-param>
 </xsl:call-template>
 <xsl:value-of select="$biblionumber"/>
 </xsl:attribute>
 <xsl:attribute name="class">title</xsl:attribute>

 <xsl:if test="marc:datafield[@tag=245]">
 <xsl:for-each select="marc:datafield[@tag=245]">
 <xsl:variable name="title">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 <xsl:if test="marc:subfield[@code='h']">
 <xsl:text> </xsl:text>
 (<xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">h</xsl:with-param>
 </xsl:call-template>)
 </xsl:if>
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:text> : </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">b</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">np</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:variable name="titleChop">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="$title"/>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:value-of select="$titleChop"/>
 </xsl:for-each>
 </xsl:if>
 </a>
 <p>

 <xsl:choose
> <xsl:when test="marc:datafield[@tag=100] or marc:datafield[@tag=110] or marc:datafield[@tag=111] or marc:datafield[@tag=700] or marc:datafield[@tag=710] or marc:datafield[@tag=711]">

 av <xsl:for-each select="marc:datafield[(@tag=100 or @tag=700) and @ind1!='z']">
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:call-template name="nameABCDQ"/>.
 </xsl:when>
 <xsl:otherwise>
 <xsl:call-template name="nameABCDQ"/>;
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>

 <xsl:for-each select="marc:datafield[(@tag=110 or @tag=710) and @ind1!='z']">
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:call-template name="nameABCDN"/>.
 </xsl:when>
 <xsl:otherwise>
 <xsl:call-template name="nameABCDN"/>;
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>

 <xsl:for-each select="marc:datafield[(@tag=111 or @tag=711) and @ind1!='z']">
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:call-template name="nameACDEQ"/>.
 </xsl:when>
 <xsl:otherwise>
 <xsl:call-template name="nameACDEQ"/>;
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </xsl:when>
 </xsl:choose>
 </p>

 <xsl:if test="marc:datafield[@tag=250]">
 <span class="results_summary">
 <span class="label">Utgave: </span>
 <xsl:for-each select="marc:datafield[@tag=250]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Analytics -->
 <xsl:if test="$leader7='s' or $leader7='c'">
 <span class="results_summary analytics"><span class="label">Analítica: </span>
 <a>
 <xsl:choose>
 <xsl:when test="$UseControlNumber = '1' and marc:controlfield[@tag=001]">
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=rcn:<xsl:value-of select="marc:controlfield[@tag=001]"/>+and+(bib-level:a+or+bib-level:b)</xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=Host-item:<xsl:value-of select="translate(marc:datafield[@tag=245]/marc:subfield[@code='a'], '/', '')"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:text>Mostrar analíticas</xsl:text>
 </a>
 </span>
 </xsl:if>

 <!-- 773 - Links from child to parent -->
 <xsl:if test="marc:datafield[@tag=773]">
 <xsl:for-each select="marc:datafield[@tag=773]">
 <xsl:if test="@ind1=0">
 <span class="results_summary in"><span class="label">
 <xsl:choose>
 <xsl:when test="@ind2=' '">
 Em: </xsl:when>
 <xsl:when test="@ind2=8">
 <xsl:if test="marc:subfield[@code='i']">
 <xsl:value-of select="marc:subfield[@code='i']"/>
 </xsl:if>
 </xsl:when>
 </xsl:choose>
 </span>
 <xsl:variable name="f773">
 <xsl:call-template name="chopPunctuation"><xsl:with-param name="chopString"><xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a_t</xsl:with-param>
 </xsl:call-template></xsl:with-param></xsl:call-template>
 </xsl:variable>
 <xsl:choose>
 <xsl:when test="$UseControlNumber = '1' and marc:subfield[@code='w']">
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=Control-number:<xsl:call-template name="extractControlNumber"><xsl:with-param name="subfieldW" select="marc:subfield[@code='w']"/></xsl:call-template></xsl:attribute>
 <xsl:value-of select="translate($f773, '()', '')"/>
 </a>
 <xsl:if test="marc:subfield[@code='g']"><xsl:text> </xsl:text><xsl:value-of select="marc:subfield[@code='g']"/></xsl:if>
 </xsl:when>
 <xsl:when test="marc:subfield[@code='0']">
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-detail.pl?biblionumber=<xsl:value-of select="marc:subfield[@code='0']"/></xsl:attribute>
 <xsl:value-of select="$f773"/>
 </a>
 </xsl:when>
 <xsl:otherwise>
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=ti,phr:<xsl:value-of select="translate($f773, '()', '')"/></xsl:attribute>
 <xsl:value-of select="$f773"/>
 </a>
 <xsl:if test="marc:subfield[@code='g']"><xsl:text> </xsl:text><xsl:value-of select="marc:subfield[@code='g']"/></xsl:if>
 </xsl:otherwise>
 </xsl:choose>
 </span>
 <xsl:if test="marc:subfield[@code='n']">
 <span class="results_summary"><xsl:value-of select="marc:subfield[@code='n']"/></span>
 </xsl:if>
 </xsl:if>
 </xsl:for-each>
 </xsl:if>

<xsl:if test="$DisplayOPACiconsXSLT!='0'">
 <span class="results_summary">
 <xsl:if test="$typeOf008!=''">
 <span class="label">Materialtype: </span>
 <xsl:choose>
 <xsl:when test="$typeOf008='Mon'"><img alt="Livro" src="/opac-tmpl/lib/famfamfam/BK.png" title="Livro" /> Livro</xsl:when>
 <xsl:when test="$typeOf008='Per'"><img alt="Periódicos" src="/opac-tmpl/lib/famfamfam/AR.png" title="Periódicos" /> Periódicos</xsl:when>
 <xsl:when test="$typeOf008='Fil'"><img alt="Fio" src="/opac-tmpl/lib/famfamfam/CF.png" title="Fio" /> Fio</xsl:when>
 <xsl:when test="$typeOf008='Kar'"><img alt="Mapa" src="/opac-tmpl/lib/famfamfam/MP.png" title="Mapa" /> Mapa</xsl:when>
 <xsl:when test="$typeOf008='FV'"><img alt="Cinema e vídeo" src="/opac-tmpl/lib/famfamfam/VM.png" title="Cinema e vídeo" /> Cinema e vídeo</xsl:when>
 <xsl:when test="$typeOf008='Mus'"><img alt="Partituras e gravações de áudio" src="/opac-tmpl/lib/famfamfam/PR.png" title="Partituras e gravações de áudio" /> Música</xsl:when>
 <xsl:when test="$typeOf008='gra'"><img alt="Material impresso" src="/opac-tmpl/lib/famfamfam/GR.png" title="Material impresso" /> Material impresso</xsl:when>
 <xsl:when test="$typeOf008='kom'"><img alt="Documentos combinados" src="/opac-tmpl/lib/famfamfam/MX.png" title="Documentos combinados" /> Documentos combinados</xsl:when>
 <xsl:when test="$typeOf008='trd'"><img alt="Objetos tridimensionais" src="/opac-tmpl/lib/famfamfam/TD.png" title="Objetos tridimensionais" /> Objetos tridimensionais</xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="string-length(normalize-space($physicalDescription))">
 <span class="label">; Formato: </span><xsl:copy-of select="$physicalDescription"></xsl:copy-of>
 </xsl:if>

 <!-- test
 <xsl:for-each select="marc:datafield[@tag=019]">
 019b:
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">b</xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 -->

 <xsl:if test="$controlField008-21 or $controlField008-22 or $controlField008-24 or $controlField008-26 or $controlField008-29 or $controlField008-34 or $controlField008-33 or $controlField008-30-31 or $controlField008-33">

 <xsl:if test="$typeOf008='Per'">
 <xsl:if test="$controlField008-21 and contains($controlField008-21,'amnpz')">
 <span class="label">; Periódico: </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-21='a'">Årbok</xsl:when>
 <xsl:when test="$controlField008-21='m'">Monografia seriada</xsl:when>
 <xsl:when test="$controlField008-21='n'">Opinião</xsl:when>
 <xsl:when test="$controlField008-21='p'">Periódico</xsl:when>
 <xsl:when test="$controlField008-21='z'">Outros tipos de periódico</xsl:when>
 </xsl:choose>
 </xsl:if>

 <xsl:if test="$typeOf008='Mon' or $typeOf008='Per'">
 <xsl:if test="contains($controlField008-24,'abcdefhiklmnoqrstx')">
 <span class="label">; Innhold: </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="contains($controlField008-24,'a')"> Resumos/ órgão de referência</xsl:when>
 <xsl:when test="contains($controlField008-24,'b')"> Bibliográfo</xsl:when>
 <xsl:when test="contains($controlField008-24,'c')"> Catálogo</xsl:when>
 <xsl:when test="contains($controlField008-24,'d')"> Ordbøker</xsl:when>
 <xsl:when test="contains($controlField008-24,'e')"> Enciclopédia</xsl:when>
 <xsl:when test="contains($controlField008-24,'f')"> Håndbøker</xsl:when>
 <xsl:when test="contains($controlField008-24,'h')"> Obras de referência</xsl:when>
 <xsl:when test="contains($controlField008-24,'i')"> Registrar</xsl:when>
 <xsl:when test="contains($controlField008-24,'k')"> Discografias</xsl:when>
 <xsl:when test="contains($controlField008-24,'l')"> Leis e regulamentos</xsl:when>
 <xsl:when test="contains($controlField008-24,'m')"> Principais tarefas/ dissertações</xsl:when>
 <xsl:when test="contains($controlField008-24,'n')"> Panorama de obras sobre determinado assunto</xsl:when>
 <xsl:when test="contains($controlField008-24,'o')"> Comentários</xsl:when>
 <xsl:when test="contains($controlField008-24,'q')"> Filmografia</xsl:when>
 <xsl:when test="contains($controlField008-24,'r')"> Adressebøker</xsl:when>
 <xsl:when test="contains($controlField008-24,'s')"> Estatísticas</xsl:when>
 <xsl:when test="contains($controlField008-24,'t')"> Relatório técnico</xsl:when>
 <xsl:when test="contains($controlField008-24,'x')"> Dissertações e teses</xsl:when>
 <!--
 <xsl:when test="contains($controlField008-24,'z')"> Annet</xsl:when>
 -->
 </xsl:choose>
 <xsl:choose>
 <xsl:when test="$controlField008-29='1'">
 Konferansepublikasjon </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='CF'">
 <xsl:if test="$controlField008-26='a' or $controlField008-26='b' or $controlField008-26='c' or $controlField008-26='d' or $controlField008-26='e' or $controlField008-26='f' or $controlField008-26='g' or $controlField008-26='h' or $controlField008-26='i' or $controlField008-26='j'">
 <span class="label">; Tipo de arquivo de computador: </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-26='a'">Dados numéricos</xsl:when>
 <xsl:when test="$controlField008-26='b'">Software</xsl:when>
 <xsl:when test="$controlField008-26='c'">Dados gráficos</xsl:when>
 <xsl:when test="$controlField008-26='d'">Texto</xsl:when>
 <xsl:when test="$controlField008-26='e'">Dados bibliográficos</xsl:when>
 <xsl:when test="$controlField008-26='f'">Fonte</xsl:when>
 <xsl:when test="$controlField008-26='g'">Desempenho</xsl:when>
 <xsl:when test="$controlField008-26='h'">Áudio</xsl:when>
 <xsl:when test="$controlField008-26='i'">Multimídia interativa</xsl:when>
 <xsl:when test="$controlField008-26='j'">Serviços online</xsl:when>
 <!-- Probably makes no sense to display these
 <xsl:when test="$controlField008-26='m'">En kombinasjon av to eller flere av de ovennevnte</xsl:when>
 <xsl:when test="$controlField008-26='u'">Ukjent</xsl:when>
 <xsl:when test="$controlField008-26='z'">Annen type data</xsl:when>
 -->
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='Mon'">
 <xsl:if test="(substring($controlField008,25,1)='j') or (substring($controlField008,25,1)='1') or ($controlField008-34='a' or $controlField008-34='b' or $controlField008-34='c' or $controlField008-34='d')">
 <span class="label">; Innhold: </span>
 </xsl:if>
 <xsl:if test="substring($controlField008,31,1)='1' or substring($controlField008,31,1)='a' or substring($controlField008,31,1)='b'">
 Festskrift </xsl:if>
 <xsl:if test="$controlField008-34='a' or $controlField008-34='a' or $controlField008-34='b' or $controlField008-34='c' or $controlField008-34='d'">
 Biografia </xsl:if>

 <xsl:if test="$controlField008-33 and $controlField008-33!='^' and $controlField008-33!=' '">
 <span class="label">; Litterær form: </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-33='0'">Ikke skjønnlitteratur</xsl:when>
 <xsl:when test="$controlField008-33='l'">Lærebok, brevkurs</xsl:when>
 <xsl:when test="$controlField008-33='1'">Skjønnlitteratur</xsl:when>
 <xsl:when test="$controlField008-33='r'">Romance</xsl:when>
 <xsl:when test="$controlField008-33='n'">Contos/ histórias</xsl:when>
 <xsl:when test="$controlField008-33='d'">Poesia</xsl:when>
 <xsl:when test="$controlField008-33='s'">Reprodução</xsl:when>
 <xsl:when test="$controlField008-33='t'">Desenho animado</xsl:when>
 <xsl:when test="$controlField008-33='a'">Antologia</xsl:when>
 <xsl:when test="$controlField008-33='p'">Caderneta</xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='Mus' and $controlField008-30-31 and $controlField008-30-31!='^^' and $controlField008-30-31!='  '">
 <span class="label">; Litterær form: </span> <!-- Literary text for sound recordings -->
 <xsl:if test="contains($controlField008-30-31,'a')">Autobiografias</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'b')">Biografias</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'c')">Conversas e discussões</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'d')">Drama</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'e')">Ensaios</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'f')">Romances</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'g')">Relatórios, resumos</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'h')">Histórias e contos</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'i')">Educação</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'j')">Språkundervisning</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'k')">Comédia</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'l')">Palestras, discursos</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'m')">Memórias</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'o')">Aventura</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'p')">Poesia</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'r')">Fremføring av alle typer ikke-musikalske produksjoner</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'s')">Sons (sons de pássaros, por exemplo)</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'t')">Entrevistas</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'z')">Outros tipos de conteúdo</xsl:if>
 </xsl:if>

 <!--
 <xsl:if test="$typeOf008='VM'">
 <span class="label">; Type of visual material: </span>
 <xsl:choose>
 <xsl:when test="$controlField008-33='a'">
 art original
 </xsl:when>
 <xsl:when test="$controlField008-33='b'">
 kit
 </xsl:when>
 <xsl:when test="$controlField008-33='c'">
 art reproduction
 </xsl:when>
 <xsl:when test="$controlField008-33='d'">
 diorama
 </xsl:when>
 <xsl:when test="$controlField008-33='f'">
 filmstrip
 </xsl:when>
 <xsl:when test="$controlField008-33='g'">
 legal article
 </xsl:when>
 <xsl:when test="$controlField008-33='i'">
 picture
 </xsl:when>
 <xsl:when test="$controlField008-33='k'">
 graphic
 </xsl:when>
 <xsl:when test="$controlField008-33='l'">
 technical drawing
 </xsl:when>
 <xsl:when test="$controlField008-33='m'">
 motion picture
 </xsl:when>
 <xsl:when test="$controlField008-33='n'">
 chart
 </xsl:when>
 <xsl:when test="$controlField008-33='o'">
 flash card
 </xsl:when>
 <xsl:when test="$controlField008-33='p'">
 microscope slide
 </xsl:when>
 <xsl:when test="$controlField008-33='q' or marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2
,1)='q']">
 model
 </xsl:when>
 <xsl:when test="$controlField008-33='r'">
 realia
 </xsl:when>
 <xsl:when test="$controlField008-33='s'">
 slide
 </xsl:when>
 <xsl:when test="$controlField008-33='t'">
 transparency
 </xsl:when>
 <xsl:when test="$controlField008-33='v'">
 videorecording
 </xsl:when>
 <xsl:when test="$controlField008-33='w'">
 toy
 </xsl:when>
 </xsl:choose>
 </xsl:if>
 -->

 </xsl:if>

 <!--
 <xsl:if test="($typeOf008='Mon' or $typeOf008='Per' or $typeOf008='Mus' or $typeOf008='FV' or $typeOf008='Fil') and ($controlField008-22='a' or $controlField008-22='b' or $controlField008-22='c' or $controlField008-22='d' or $controlField008-22='e' or $controlField008-22='g' or $controlField008-22='j' or $controlField008-22='f')">
 -->
 <xsl:if test="$typeOf008='Mon'">
 <span class="label">; Målgruppe: </span>
 <xsl:choose>
 <xsl:when test="$controlField008-22='a'">Adultos;</xsl:when>
 <xsl:when test="$controlField008-22='b'">Billedbøker for voksne;</xsl:when>
 <xsl:when test="$controlField008-22='j'">Crianças e jovens;</xsl:when>
 <xsl:when test="$controlField008-22='k'">Billedbøker;</xsl:when>
 <xsl:when test="$controlField008-22='l'">Barn i alderen til og med 5 år;</xsl:when>
 <xsl:when test="$controlField008-22='m'">Elever på 1. til 3. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='n'">Elever på 4. og 5. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='o'">Elever på 6. og 7. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='p'">Elever på ungdomstrinnet;</xsl:when>
 <xsl:when test="$controlField008-22='v'">Billedbøker for barn i alderen til og med 5 år;</xsl:when>
 <xsl:when test="$controlField008-22='w'">Billedbøker for elever på 1. til 3. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='x'">Billedbøker for elever på 4. og 5. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='y'">Billedbøker for elever på 6. og 7. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='z'">Billedbøker for elever på ungdomstrinnet;</xsl:when>
 <xsl:when test="$controlField008-22='f'">Especializados;</xsl:when>
 <xsl:when test="$controlField008-22='q'">Fácil de ler;</xsl:when>
 <xsl:when test="$controlField008-22='r'">Para deficientes mentais;</xsl:when>
 <xsl:when test="$controlField008-22='s'">Fonte grande;</xsl:when>
 <xsl:when test="$controlField008-22='g'">Geralmente;</xsl:when>
 <xsl:when test="$controlField008-22='u'">Desconhecido;</xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='Per'">
 <span class="label">; Målgruppe: </span>
 <xsl:choose>
 <xsl:when test="$controlField008-22='a'">Adultos;</xsl:when>
 <xsl:when test="$controlField008-22='b'">Desenhos animados para adultos;</xsl:when>
 <xsl:when test="$controlField008-22='j'">Crianças e jovens;</xsl:when>
 <xsl:when test="$controlField008-22='k'">Desenhos animados;</xsl:when>
 <xsl:when test="$controlField008-22='l'">Barn i alderen til og med 5 år;</xsl:when>
 <xsl:when test="$controlField008-22='m'">Elever på 1. til 3. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='n'">Elever på 4. og 5. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='o'">Elever på 6. og 7. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='p'">Elever på ungdomstrinnet;</xsl:when>
 <xsl:when test="$controlField008-22='v'">Tegneserier for barn i alderen til og med 5 år;</xsl:when>
 <xsl:when test="$controlField008-22='w'">Tegneserier for elever på 1. til 3. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='x'">Tegneserier for elever på 4. og 5. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='y'">Tegneserier for elever på 6. og 7. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='z'">Tegneserier for elever på ungdomstrinnet;</xsl:when>
 <xsl:when test="$controlField008-22='f'">Especializados;</xsl:when>
 <xsl:when test="$controlField008-22='q'">Fácil de ler;</xsl:when>
 <xsl:when test="$controlField008-22='r'">Para deficientes mentais;</xsl:when>
 <xsl:when test="$controlField008-22='s'">Fonte grande;</xsl:when>
 <xsl:when test="$controlField008-22='g'">Geralmente;</xsl:when>
 <xsl:when test="$controlField008-22='u'">Desconhecido;</xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='Fil' or $typeOf008='Mus'">
 <span class="label">; Målgruppe: </span>
 <xsl:choose>
 <xsl:when test="$controlField008-22='a'">Adultos;</xsl:when>
 <xsl:when test="$controlField008-22='j'">Crianças e jovens;</xsl:when>
 <xsl:when test="$controlField008-22='1'">Barn i alderen til og med 5 år;</xsl:when>
 <xsl:when test="$controlField008-22='m'">Elever på 1. til 3. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='n'">Elever på 4. og 5. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='o'">Elever på 6. og 7. klassetrinn;</xsl:when>
 <xsl:when test="$controlField008-22='p'">Elever på ungdomstrinnet;</xsl:when>
 <xsl:when test="$controlField008-22='f'">Especializados;</xsl:when>
 <xsl:when test="$controlField008-22='q'">Fácil de ler;</xsl:when>
 <xsl:when test="$controlField008-22='r'">Para deficientes mentais;</xsl:when>
 <xsl:when test="$controlField008-22='s'">Fonte grande;</xsl:when>
 <xsl:when test="$controlField008-22='g'">Geralmente;</xsl:when>
 <xsl:when test="$controlField008-22='u'">Desconhecido;</xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='FV'">
 <span class="label">; Målgruppe: </span>
 <xsl:choose>
 <xsl:when test="$controlField008-22='a'">Adultos;</xsl:when>
 <xsl:when test="$controlField008-22='1'">Voksne over 18 år;</xsl:when>
 <xsl:when test="$controlField008-22='2'">Voksne over 15 år;</xsl:when>
 <xsl:when test="$controlField008-22='j'">Crianças e jovens;</xsl:when>
 <xsl:when test="$controlField008-22='4'">Ungdom over 12 år;</xsl:when>
 <xsl:when test="$controlField008-22='5'">Barn over 7 år;</xsl:when>
 <xsl:when test="$controlField008-22='6'">Småbarn;</xsl:when>
 <xsl:when test="$controlField008-22='f'">Especializados;</xsl:when>
 <xsl:when test="$controlField008-22='g'">Geralmente;</xsl:when>
 <xsl:when test="$controlField008-22='u'">Desconhecido;</xsl:when>
 </xsl:choose>
 </xsl:if>
 </span>
</xsl:if>

 <!-- Utgivelse, distribusjon osv -->
 <xsl:if test="marc:datafield[@tag=260]">
 <span class="results_summary">
 <span class="label">Utgiver: </span>
 <xsl:for-each select="marc:datafield[@tag=260]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">bcg</xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- Parallelltittel (R) -->
 <xsl:if test="marc:datafield[@tag=246]">
 <span class="results_summary">
 <span class="label">Parallelltittel: </span>
 <xsl:for-each select="marc:datafield[@tag=246]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 </span>

 </xsl:if>

<span class="results_summary">
 <span class="label">Disponibilidade: </span>
 <xsl:choose>
 <xsl:when test="count(key('item-by-status', 'available'))=0 and count(key('item-by-status', 'reference'))=0">Nenhum item disponível </xsl:when>

 <xsl:when test="count(key('item-by-status', 'available'))>0">
 <span class="available">
 <b><xsl:text>Exemplares disponíveis para empréstimo: </xsl:text></b>
 <xsl:variable name="available_items" select="key('item-by-status', 'available')"/>
 <xsl:choose>
 <xsl:when test="$singleBranchMode=1">
 <xsl:for-each select="$available_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber"> [<xsl:value-of select="items:itemcallnumber"/>]</xsl:if>
 <xsl:text> (</xsl:text>
 <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
 <xsl:text>)</xsl:text>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </xsl:when>
 <xsl:otherwise>
 <xsl:for-each select="$available_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:value-of select="items:homebranch"/>
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber"> [<xsl:value-of select="items:itemcallnumber"/>]</xsl:if>

 <xsl:text> (</xsl:text>
 <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
 <xsl:text>)</xsl:text>
<xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </xsl:otherwise>
 </xsl:choose>
 </span>
 </xsl:when>

 </xsl:choose>

 <xsl:choose>
 <xsl:when test="count(key('item-by-status', 'reference'))>0">
 <span class="available">
 <b><xsl:text>Exemplares disponíveis para consulta: </xsl:text></b>
 <xsl:variable name="reference_items"
                           select="key('item-by-status', 'reference')"/>
 <xsl:for-each select="$reference_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:if test="$singleBranchMode=0">
 <xsl:value-of select="items:homebranch"/>
 </xsl:if>
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber"> [<xsl:value-of select="items:itemcallnumber"/>]</xsl:if>
 <xsl:text> (</xsl:text>
 <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
 <xsl:text>)</xsl:text>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise></xsl:choose>

 </xsl:for-each>
 </span>
 </xsl:when>
 </xsl:choose>

 <xsl:if test="count(key('item-by-status', 'Checked out'))>0">
 <span class="unavailable">
 <xsl:text>Emprestado (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Checked out'))"/>

 <xsl:text>). </xsl:text>
 </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'Withdrawn'))>0">
 <span class="unavailable">
 <xsl:text>Descartado (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Withdrawn'))"/>
 <xsl:text>). </xsl:text> </span>

 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'Lost'))>0">
 <span class="unavailable">
 <xsl:text>Perdido (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Lost'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>

 <xsl:if test="count(key('item-by-status', 'Damaged'))>0">
 <span class="unavailable">
 <xsl:text>Danificado (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Damaged'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'On order'))>0">

 <span class="unavailable">
 <xsl:text>Em aquisição (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'On order'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'In transit'))>0">
 <span class="unavailable">

 <xsl:text>Em trânsito (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'In transit'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'Waiting'))>0">
 <span class="unavailable">
 <xsl:text>Na reserva (</xsl:text>

 <xsl:value-of select="count(key('item-by-status', 'Waiting'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 </span>

 </xsl:template>

 <xsl:template name="termsOfAddress">
 <xsl:if test="marc:subfield[@code='b' or @code='c']">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">bc</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>

 <xsl:template name="nameDate">
 <xsl:for-each select="marc:subfield[@code='d']">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."/>
 </xsl:call-template>
 </xsl:for-each>
 </xsl:template>

 <xsl:template name="role">
 <xsl:for-each select="marc:subfield[@code='e']">
 <xsl:value-of select="."/>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='4']">
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:template>

 <xsl:template name="specialSubfieldSelect">
 <xsl:param name="anyCodes"/>
 <xsl:param name="axis"/>
 <xsl:param name="beforeCodes"/>
 <xsl:param name="afterCodes"/>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield">
 <xsl:if test="contains($anyCodes, @code) or (contains($beforeCodes,@code) and following-sibling::marc:subfield[@code=$axis]) or (contains($afterCodes,@code) and preceding-sibling::marc:subfield[@code=$axis])">
 <xsl:value-of select="text()"/>
 <xsl:text> </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"/>
 </xsl:template>

 <xsl:template name="subtitle">
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:subfield[@code='b']"/>

 <!--<xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">b</xsl:with-param>
 </xsl:call-template>-->
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>

 <xsl:template name="chopBrackets">
 <xsl:param name="chopString"></xsl:param>
 <xsl:variable name="string">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="$chopString"></xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:if test="substring($string, 1,1)='['">
 <xsl:value-of select="substring($string,2, string-length($string)-2)"></xsl:value-of>
 </xsl:if>
 <xsl:if test="substring($string, 1,1)!='['">
 <xsl:value-of select="$string"></xsl:value-of>
 </xsl:if>
 </xsl:template>

</xsl:stylesheet>
