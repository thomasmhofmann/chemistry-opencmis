VER=0.8.0-SNAPSHOT
M2_REPO=~/.m2/repository
CP="target/classes:\
$M2_REPO/javax/activation/activation/1.1/activation-1.1.jar:\
$M2_REPO/javax/xml/bind/jaxb-api/2.1/jaxb-api-2.1.jar:\
$M2_REPO/javax/xml/ws/jaxws-api/2.1/jaxws-api-2.1.jar:\
$M2_REPO/javax/xml/soap/saaj-api/1.3/saaj-api-1.3.jar:\
$M2_REPO/javax/xml/stream/stax-api/1.0/stax-api-1.0.jar:\
$M2_REPO/org/apache/james/apache-mime4j-core/0.7/apache-mime4j-core-0.7.jar:\
$M2_REPO/org/apache/james/apache-mime4j-dom/0.7/apache-mime4j-dom-0.7.jar:\
$M2_REPO/asm/asm/3.1/asm-3.1.jar:\
$M2_REPO/org/bouncycastle/bcmail-jdk15/1.45/bcmail-jdk15-1.45.jar:\
$M2_REPO/org/bouncycastle/bcprov-jdk15/1.45/bcprov-jdk15-1.45.jar:\
$M2_REPO/de/l3s/boilerpipe/boilerpipe/1.1.0/boilerpipe-1.1.0.jar:\
$M2_REPO/org/apache/chemistry/opencmis/chemistry-opencmis-client-api/$VER/chemistry-opencmis-client-api-$VER.jar:\
$M2_REPO/org/apache/chemistry/opencmis/chemistry-opencmis-client-bindings/$VER/chemistry-opencmis-client-bindings-$VER.jar:\
$M2_REPO/org/apache/chemistry/opencmis/chemistry-opencmis-client-impl/$VER/chemistry-opencmis-client-impl-$VER.jar:\
$M2_REPO/org/apache/chemistry/opencmis/chemistry-opencmis-commons-api/$VER/chemistry-opencmis-commons-api-$VER.jar:\
$M2_REPO/org/apache/chemistry/opencmis/chemistry-opencmis-commons-impl/$VER/chemistry-opencmis-commons-impl-$VER.jar:\
$M2_REPO/org/apache/chemistry/opencmis/chemistry-opencmis-test-util/$VER/chemistry-opencmis-test-util-$VER.jar:\
$M2_REPO/commons-codec/commons-codec/1.5/commons-codec-1.5.jar:\
$M2_REPO/org/apache/commons/commons-compress/1.3/commons-compress-1.3.jar:\
$M2_REPO/commons-io/commons-io/2.0.1/commons-io-2.0.1.jar:\
$M2_REPO/commons-logging/commons-logging/1.1.1/commons-logging-1.1.1.jar:\
$M2_REPO/dom4j/dom4j/1.6.1/dom4j-1.6.1.jar:\
$M2_REPO/org/apache/pdfbox/fontbox/1.6.0/fontbox-1.6.0.jar:\
$M2_REPO/org/apache/geronimo/specs/geronimo-stax-api_1.0_spec/1.0.1/geronimo-stax-api_1.0_spec-1.0.1.jar:\
$M2_REPO/com/googlecode/mp4parser/isoparser/1.0-beta-5/isoparser-1.0-beta-5.jar:\
$M2_REPO/javassist/javassist/3.6.0.GA/javassist-3.6.0.GA.jar:\
$M2_REPO/com/sun/xml/bind/jaxb-impl/2.1.11/jaxb-impl-2.1.11.jar:\
$M2_REPO/com/sun/xml/ws/jaxws-rt/2.1.7/jaxws-rt-2.1.7.jar:\
$M2_REPO/jdom/jdom/1.0/jdom-1.0.jar:\
$M2_REPO/org/apache/pdfbox/jempbox/1.6.0/jempbox-1.6.0.jar:\
$M2_REPO/net/sf/jopt-simple/jopt-simple/3.2/jopt-simple-3.2.jar:\
$M2_REPO/junit/junit/4.7/junit-4.7.jar:\
$M2_REPO/log4j/log4j/1.2.16/log4j-1.2.16.jar:\
$M2_REPO/com/drewnoakes/metadata-extractor/2.4.0-beta-1/metadata-extractor-2.4.0-beta-1.jar:\
$M2_REPO/org/jvnet/mimepull/1.3/mimepull-1.3.jar:\
$M2_REPO/edu/ucar/netcdf/4.2-min/netcdf-4.2-min.jar:\
$M2_REPO/org/apache/felix/org.osgi.core/1.0.0/org.osgi.core-1.0.0.jar:\
$M2_REPO/org/apache/pdfbox/pdfbox/1.6.0/pdfbox-1.6.0.jar:\
$M2_REPO/org/apache/poi/poi/3.8-beta5/poi-3.8-beta5.jar:\
$M2_REPO/org/apache/poi/poi-ooxml/3.8-beta5/poi-ooxml-3.8-beta5.jar:\
$M2_REPO/org/apache/poi/poi-ooxml-schemas/3.8-beta5/poi-ooxml-schemas-3.8-beta5.jar:\
$M2_REPO/org/apache/poi/poi-scratchpad/3.8-beta5/poi-scratchpad-3.8-beta5.jar:\
$M2_REPO/com/sun/org/apache/xml/internal/resolver/20050927/resolver-20050927.jar:\
$M2_REPO/rome/rome/0.9/rome-0.9.jar:\
$M2_REPO/com/sun/xml/messaging/saaj/saaj-impl/1.3.3/saaj-impl-1.3.3.jar:\
$M2_REPO/net/sf/scannotation/scannotation/1.0.2/scannotation-1.0.2.jar:\
$M2_REPO/org/slf4j/slf4j-api/1.6.4/slf4j-api-1.6.4.jar:\
$M2_REPO/org/slf4j/slf4j-log4j12/1.6.4/slf4j-log4j12-1.6.4.jar:\
$M2_REPO/stax/stax-api/1.0.1/stax-api-1.0.1.jar:\
$M2_REPO/org/jvnet/staxex/stax-ex/1.2/stax-ex-1.2.jar:\
$M2_REPO/com/sun/xml/stream/buffer/streambuffer/0.9/streambuffer-0.9.jar:\
$M2_REPO/org/ccil/cowan/tagsoup/tagsoup/1.2.1/tagsoup-1.2.1.jar:\
$M2_REPO/org/apache/tika/tika-core/1.1/tika-core-1.1.jar:\
$M2_REPO/org/apache/tika/tika-parsers/1.1/tika-parsers-1.1.jar:\
$M2_REPO/org/gagravarr/vorbis-java-core/0.1/vorbis-java-core-0.1-tests.jar:\
$M2_REPO/org/gagravarr/vorbis-java-core/0.1/vorbis-java-core-0.1.jar:\
$M2_REPO/org/gagravarr/vorbis-java-tika/0.1/vorbis-java-tika-0.1.jar:\
$M2_REPO/org/codehaus/woodstox/wstx-asl/3.2.3/wstx-asl-3.2.3.jar:\
$M2_REPO/org/apache/xmlbeans/xmlbeans/2.3.0/xmlbeans-2.3.0.jar"