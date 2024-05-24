jmp main

;---- Variáveis globais: podem ser usadas em todas as rotinas
Palavra: var #20	        ;vetor para armazenar as letras da palavra
Tecla: var #1		        ;guarda a tecla que foi digitada
Acerto: var #1		        ;contador de acertos
Erro: var #1		        ;contador de erros
chaveRandom: var #2	     ;usada para sortear a palavra	
TamanhoPalavra: var #1    ;guarda o tamanho da palavra
posLetra: var #1          ;guarda a posicao da letra 
PalavraDigitada: var #20  ;guarda a palavra inputada
posCursor: var #1         ;guarda a posicao do cursor
contadorVerdes: var #1    ;contador de letras verdes  
Contador: var #1          ;contador de tentativas durante a rodada
Catalogo : var #1566      ;armazena o endereço das 783 palavras
catTamanhos: var #783     ;armazena o tamanho das 783 palavras do catalogo (sempre 5)

;----Catálogo com as 783 palavras do jogo
word0: string "abrir"
word1: string "abriu"
word2: string "abuso"
word3: string "acaso"
word4: string "acesa"
word5: string "aceso"
word6: string "achar"
word7: string "acima"
word8: string "adeus"
word9: string "adiar"
word10: string "advir"
word11: string "afago"
word12: string "afeto"
word13: string "afins"
word14: string "afora"
word15: string "agora"
word16: string "agudo"
word17: string "ainda"
word18: string "ajuda"
word19: string "alado"
word20: string "algoz"
word21: string "algum"
word22: string "alude"
word23: string "aluno"
word24: string "amada"
word25: string "amado"
word26: string "ambas"
word27: string "ambos"
word28: string "amena"
word29: string "ameno"
word30: string "amiga"
word31: string "amigo"
word32: string "amplo"
word33: string "alias"
word34: string "andar"
word35: string "anelo"
word36: string "anexo"
word37: string "antes"
word38: string "antro"
word39: string "anuir"
word40: string "aonde"
word41: string "apear"
word42: string "apego"
word43: string "apelo"
word44: string "apoio"
word45: string "apraz"
word46: string "arado"
word47: string "arcar"
word48: string "ardil"
word49: string "ardis"
word50: string "ardor"
word51: string "areia"
word52: string "arfar"
word53: string "aroma"
word54: string "arroz"
word55: string "artur"
word56: string "asilo"
word57: string "assar"
word58: string "assaz"
word59: string "assim"
word60: string "astro"
word61: string "ateia"
word62: string "ativo"
word63: string "atroz"
word64: string "atual"
word65: string "atuar"
word66: string "audaz"
word67: string "autor"
word68: string "autos"
word69: string "avaro"
word70: string "aviar"
word71: string "aviso"
word72: string "axial"
word73: string "axila"
word74: string "baixa"
word75: string "baixo"
word76: string "banal"
word77: string "bando"
word78: string "banto"
word79: string "banzo"
word80: string "barro"
word81: string "bater"
word82: string "bazar"
word83: string "beata"
word84: string "bedel"
word85: string "beijo"
word86: string "berro"
word87: string "besta"
word88: string "bicho"
word89: string "bioma"
word90: string "birra"
word91: string "boato"
word92: string "bolsa"
word93: string "bolso"
word94: string "botar"
word95: string "brabo"
word96: string "brado"
word97: string "brava"
word98: string "bravo"
word99: string "brega"
word100: string "breve"
word101: string "briga"
word102: string "brisa"
word103: string "broxa"
word104: string "bruma"
word105: string "bruta"
word106: string "bruto"
word107: string "bucho"
word108: string "bulir"
word109: string "bunda"
word110: string "burra"
word111: string "burro"
word112: string "busca"
word113: string "cabal"
word114: string "caber"
word115: string "cacho"
word116: string "cacto"
word117: string "caixa"
word118: string "calda"
word119: string "calma"
word120: string "calmo"
word121: string "calor"
word122: string "calvo"
word123: string "campa"
word124: string "campo"
word125: string "canil"
word126: string "canso"
word127: string "canto"
word128: string "capaz"
word129: string "cardo"
word130: string "cargo"
word131: string "carma"
word132: string "carro"
word133: string "carta"
word134: string "casal"
word135: string "casar"
word136: string "casta"
word137: string "casto"
word138: string "catre"
word139: string "cauda"
word140: string "causa"
word141: string "ceder"
word142: string "ceita"
word143: string "cenho"
word144: string "censo"
word145: string "cerca"
word146: string "cerne"
word147: string "certa"
word148: string "certo"
word149: string "cesta"
word150: string "cetro"
word151: string "chaga"
word152: string "chama"
word153: string "chata"
word154: string "chato"
word155: string "chave"
word156: string "chefe"
word157: string "cheia"
word158: string "cheio"
word159: string "chula"
word160: string "chulo"
word161: string "chuva"
word162: string "ciclo"
word163: string "cifra"
word164: string "cinto"
word165: string "cioso"
word166: string "cisma"
word167: string "citar"
word168: string "civil"
word169: string "claro"
word170: string "clava"
word171: string "clean"
word172: string "clero"
word173: string "clima"
word174: string "close"
word175: string "cocho"
word176: string "coesa"
word177: string "coeso"
word178: string "coevo"
word179: string "coisa"
word180: string "coito"
word181: string "combo"
word182: string "comer"
word183: string "comum"
word184: string "conta"
word185: string "conto"
word186: string "coral"
word187: string "corar"
word188: string "corja"
word189: string "canoa"
word190: string "coroa"
word191: string "corpo"
word192: string "corso"
word193: string "coser"
word194: string "cosmo"
word195: string "cousa"
word196: string "cover"
word197: string "covil"
word198: string "cozer"
word199: string "credo"
word200: string "criar"
word201: string "crime"
word202: string "crise"
word203: string "crivo"
word204: string "cruel"
word205: string "culpa"
word206: string "culta"
word207: string "culto"
word208: string "cunho"
word209: string "curso"
word210: string "custo"
word211: string "daqui"
word212: string "deixa"
word213: string "dengo"
word214: string "densa"
word215: string "denso"
word216: string "depor"
word217: string "deram"
word218: string "desde"
word219: string "dessa"
word220: string "desse"
word221: string "desta"
word222: string "deste"
word223: string "deter"
word224: string "dever"
word225: string "devir"
word226: string "digno"
word227: string "dizer"
word228: string "dogma"
word229: string "doido"
word230: string "dorso"
word231: string "dedos"
word232: string "drama"
word233: string "droga"
word234: string "ecoar"
word235: string "elite"
word236: string "enfim"
word237: string "enjoo"
word238: string "entre"
word239: string "ereto"
word240: string "dente"
word241: string "emoji"
word242: string "estar"
word243: string "envio"
word244: string "entao"
word245: string "etapa"
word246: string "etnia"
word247: string "exame"
word248: string "exato"
word249: string "exijo"
word250: string "expor"
word251: string "extra"
word252: string "facho"
word253: string "facto"
word254: string "faina"
word255: string "faixa"
word256: string "falar"
word257: string "falha"
word258: string "falta"
word259: string "fardo"
word260: string "farol"
word261: string "farsa"
word262: string "farta"
word263: string "farto"
word264: string "fatal"
word265: string "fator"
word266: string "fatos"
word267: string "fauna"
word268: string "favor"
word269: string "fazer"
word270: string "fazes"
word271: string "fazia"
word272: string "feita"
word273: string "feito"
word274: string "feixe"
word275: string "feliz"
word276: string "fenda"
word277: string "feroz"
word278: string "ferpa"
word279: string "ferro"
word280: string "festa"
word281: string "feudo"
word282: string "ficar"
word283: string "ficha"
word284: string "filho"
word285: string "final"
word286: string "facil"
word287: string "futil"
word288: string "finjo"
word289: string "firma"
word290: string "firme"
word291: string "fitar"
word292: string "fixar"
word293: string "flora"
word294: string "fluir"
word295: string "fluxo"
word296: string "fusao"
word297: string "folga"
word298: string "folha"
word299: string "folia"
word300: string "fonte"
word301: string "forem"
word302: string "forma"
word303: string "forro"
word304: string "forte"
word305: string "fossa"
word306: string "fosse"
word307: string "filha"
word308: string "fraco"
word309: string "frase"
word310: string "frota"
word311: string "fruir"
word312: string "fruto"
word313: string "fugaz"
word314: string "fugir"
word315: string "fugiu"
word316: string "fundo"
word317: string "furto"
word318: string "gabar"
word319: string "graca"
word320: string "genio"
word321: string "genro"
word322: string "gente"
word323: string "geral"
word324: string "gerar"
word325: string "gerir"
word326: string "gesto"
word327: string "garra"
word328: string "globo"
word329: string "golpe"
word330: string "gosto"
word331: string "gasto"
word332: string "grama"
word333: string "grata"
word334: string "grato"
word335: string "grave"
word336: string "gotas"
word337: string "grupo"
word338: string "gueto"
word339: string "guisa"
word340: string "guria"
word341: string "haste"
word342: string "haver"
word343: string "havia"
word344: string "hiato"
word345: string "hobby"
word346: string "homem"
word347: string "honra"
word348: string "horda"
word349: string "horto"
word350: string "hiena"
word351: string "houve"
word352: string "humor"
word353: string "ideal"
word354: string "ideia"
word355: string "idoso"
word356: string "igual"
word357: string "ileso"
word358: string "impor"
word359: string "imune"
word360: string "inata"
word361: string "inato"
word362: string "inter"
word363: string "irado"
word364: string "itens"
word365: string "jegue"
word366: string "jeans"
word367: string "jeito"
word368: string "jejum"
word369: string "jarra"
word370: string "jogar"
word371: string "jovem"
word372: string "judeu"
word373: string "jaula"
word374: string "junto"
word375: string "justa"
word376: string "justo"
word377: string "lapis"
word378: string "laico"
word379: string "lapso"
word380: string "largo"
word381: string "lunar"
word382: string "laudo"
word383: string "lavra"
word384: string "lazer"
word385: string "legal"
word386: string "leigo"
word387: string "leite"
word388: string "leito"
word389: string "lenda"
word390: string "lento"
word391: string "latim"
word392: string "lider"
word393: string "letal"
word394: string "letra"
word395: string "levar"
word396: string "lotus"
word397: string "lidar"
word398: string "ligar"
word399: string "light"
word400: string "limbo"
word401: string "limpo"
word402: string "linda"
word403: string "lindo"
word404: string "linha"
word405: string "livre"
word406: string "livro"
word407: string "local"
word408: string "lesao"
word409: string "lenta"
word410: string "logos"
word411: string "logro"
word412: string "longe"
word413: string "longo"
word414: string "louca"
word415: string "louco"
word416: string "louro"
word417: string "lousa"
word418: string "lucro"
word419: string "lugar"
word420: string "lutar"
word421: string "macho"
word422: string "macio"
word423: string "macro"
word424: string "magia"
word425: string "magna"
word426: string "maior"
word427: string "malta"
word428: string "manga"
word429: string "manha"
word430: string "mania"
word431: string "manso"
word432: string "manto"
word433: string "marca"
word434: string "marco"
word435: string "massa"
word436: string "matar"
word437: string "menta"
word438: string "mumia"
word439: string "medir"
word440: string "meiga"
word441: string "meigo"
word442: string "menos"
word443: string "mente"
word444: string "meses"
word445: string "mesma"
word446: string "mesmo"
word447: string "moeda"
word448: string "mexer"
word449: string "mimar"
word450: string "mimos"
word451: string "minar"
word452: string "minha"
word453: string "misto"
word454: string "melao"
word455: string "molde"
word456: string "molho"
word457: string "monge"
word458: string "monta"
word459: string "monte"
word460: string "moral"
word461: string "morar"
word462: string "morto"
word463: string "morro"
word464: string "morte"
word465: string "midia"
word466: string "motim"
word467: string "mover"
word468: string "mudar"
word469: string "muito"
word470: string "mundo"
word471: string "museu"
word472: string "narco"
word473: string "natal"
word474: string "navio"
word475: string "negar"
word476: string "negro"
word477: string "nessa"
word478: string "nesse"
word479: string "nesta"
word480: string "neste"
word481: string "nicho"
word482: string "nobre"
word483: string "noite"
word484: string "norma"
word485: string "nossa"
word486: string "nosso"
word487: string "nunca"
word488: string "nuvem"
word489: string "obter"
word490: string "ocaso"
word491: string "odiar"
word492: string "olhar"
word493: string "ontem"
word494: string "opaco"
word495: string "optar"
word496: string "ordem"
word497: string "olhos"
word498: string "orixa"
word499: string "ousar"
word500: string "outro"
word501: string "ouvir"
word502: string "pacto"
word503: string "paiol"
word504: string "paira"
word505: string "pajem"
word506: string "papel"
word507: string "parar"
word508: string "prata"
word509: string "pista"
word510: string "pardo"
word511: string "parte"
word512: string "porem"
word513: string "ponta"
word514: string "porco"
word515: string "pasmo"
word516: string "passa"
word517: string "passe"
word518: string "passo"
word519: string "pauta"
word520: string "pavor"
word521: string "pluma"
word522: string "pedir"
word523: string "pedra"
word524: string "pinta"
word525: string "pegar"
word526: string "peita"
word527: string "pombo"
word528: string "peixe"
word529: string "penca"
word530: string "penso"
word531: string "penta"
word532: string "perco"
word533: string "perda"
word534: string "perto"
word535: string "pesar"
word536: string "peste"
word537: string "piada"
word538: string "pirar"
word539: string "pilar"
word540: string "pinho"
word541: string "pique"
word542: string "pisar"
word543: string "placa"
word544: string "plano"
word545: string "plebe"
word546: string "plena"
word547: string "pleno"
word548: string "pluto"
word549: string "pobre"
word550: string "podar"
word551: string "poder"
word552: string "poema"
word553: string "poeta"
word554: string "pomar"
word555: string "pompa"
word556: string "ponha"
word557: string "ponto"
word558: string "porca"
word559: string "porta"
word560: string "porte"
word561: string "possa"
word562: string "posse"
word563: string "posso"
word564: string "posto"
word565: string "pouco"
word566: string "prado"
word567: string "praga"
word568: string "praia"
word569: string "praxe"
word570: string "prazo"
word571: string "prece"
word572: string "presa"
word573: string "preso"
word574: string "preto"
word575: string "prime"
word576: string "probo"
word577: string "prole"
word578: string "prono"
word579: string "prosa"
word580: string "proto"
word581: string "prova"
word582: string "prumo"
word583: string "psico"
word584: string "puder"
word585: string "pudor"
word586: string "pugna"
word587: string "pulha"
word588: string "punha"
word589: string "puxar"
word590: string "raiva"
word591: string "rapaz"
word592: string "redor"
word593: string "refil"
word594: string "reger"
word595: string "regra"
word596: string "reino"
word597: string "reler"
word598: string "reles"
word599: string "relva"
word600: string "remir"
word601: string "renda"
word602: string "rente"
word603: string "repor"
word604: string "reses"
word605: string "resto"
word606: string "reter"
word607: string "retro"
word608: string "revel"
word609: string "rever"
word610: string "rezar"
word611: string "rigor"
word612: string "risco"
word613: string "riste"
word614: string "ritmo"
word615: string "rival"
word616: string "rocha"
word617: string "rogar"
word618: string "rouca"
word619: string "round"
word620: string "roupa"
word621: string "rubro"
word622: string "rumor"
word623: string "rural"
word624: string "saber"
word625: string "sabia"
word626: string "sabor"
word627: string "sadio"
word628: string "saiba"
word629: string "saldo"
word630: string "salmo"
word631: string "salva"
word632: string "salve"
word633: string "salvo"
word634: string "sanar"
word635: string "santo"
word636: string "sarau"
word637: string "seara"
word638: string "segar"
word639: string "segue"
word640: string "seita"
word641: string "seiva"
word642: string "seixo"
word643: string "selar"
word644: string "senda"
word645: string "sendo"
word646: string "senil"
word647: string "senso"
word648: string "sente"
word649: string "servo"
word650: string "sesta"
word651: string "setor"
word652: string "sexta"
word653: string "sexto"
word654: string "sigla"
word655: string "signo"
word656: string "silvo"
word657: string "sinal"
word658: string "sinta"
word659: string "sinto"
word660: string "sobre"
word661: string "soldo"
word662: string "solta"
word663: string "solto"
word664: string "sonho"
word665: string "sonsa"
word666: string "sonso"
word667: string "sorte"
word668: string "suave"
word669: string "subir"
word670: string "sugar"
word671: string "sulco"
word672: string "sumir"
word673: string "super"
word674: string "supor"
word675: string "supra"
word676: string "surja"
word677: string "surto"
word678: string "sutil"
word679: string "tacha"
word680: string "tange"
word681: string "tanto"
word682: string "tarde"
word683: string "tchau"
word684: string "tecer"
word685: string "temer"
word686: string "temor"
word687: string "tempo"
word688: string "tenaz"
word689: string "tende"
word690: string "tendo"
word691: string "tenha"
word692: string "tenra"
word693: string "tenro"
word694: string "tenso"
word695: string "tento"
word696: string "termo"
word697: string "terno"
word698: string "terra"
word699: string "teste"
word700: string "tetra"
word701: string "texto"
word702: string "tinha"
word703: string "tirar"
word704: string "tiver"
word705: string "toada"
word706: string "tocar"
word707: string "todas"
word708: string "todos"
word709: string "tomar"
word710: string "torna"
word711: string "torpe"
word712: string "torso"
word713: string "tosco"
word714: string "traga"
word715: string "trago"
word716: string "traje"
word717: string "trama"
word718: string "trato"
word719: string "treta"
word720: string "tribo"
word721: string "troca"
word722: string "troco"
word723: string "trupe"
word724: string "tumba"
word725: string "turba"
word726: string "turma"
word727: string "turva"
word728: string "turvo"
word729: string "tutor"
word730: string "verme"
word731: string "vadio"
word732: string "vagar"
word733: string "valer"
word734: string "valha"
word735: string "valia"
word736: string "valor"
word737: string "varoa"
word738: string "vasta"
word739: string "vasto"
word740: string "vazia"
word741: string "vazio"
word742: string "vedar"
word743: string "velar"
word744: string "velha"
word745: string "velho"
word746: string "veloz"
word747: string "vemos"
word748: string "venal"
word749: string "vendo"
word750: string "venha"
word751: string "venho"
word752: string "vento"
word753: string "verba"
word754: string "verbo"
word755: string "verde"
word756: string "versa"
word757: string "verso"
word758: string "verve"
word759: string "vetar"
word760: string "vetor"
word761: string "vezes"
word762: string "viado"
word763: string "viger"
word764: string "vigia"
word765: string "vigor"
word766: string "vimos"
word767: string "vinha"
word768: string "viram"
word769: string "virar"
word770: string "viria"
word771: string "viril"
word772: string "visar"
word773: string "visse"
word774: string "vista"
word775: string "visto"
word776: string "vital"
word777: string "vivaz"
word778: string "viver"
word779: string "volta"
word780: string "voraz"
word781: string "vosso"
word782: string "vulgo"
word783: string "vulto"

; --Catalogo com as referencias para as palavras
static Catalogo + #0, #word0
static Catalogo + #2, #word1
static Catalogo + #4, #word2
static Catalogo + #6, #word3
static Catalogo + #8, #word4
static Catalogo + #10, #word5
static Catalogo + #12, #word6
static Catalogo + #14, #word7
static Catalogo + #16, #word8
static Catalogo + #18, #word9
static Catalogo + #20, #word10
static Catalogo + #22, #word11
static Catalogo + #24, #word12
static Catalogo + #26, #word13
static Catalogo + #28, #word14
static Catalogo + #30, #word15
static Catalogo + #32, #word16
static Catalogo + #34, #word17
static Catalogo + #36, #word18
static Catalogo + #38, #word19
static Catalogo + #40, #word20
static Catalogo + #42, #word21
static Catalogo + #44, #word22
static Catalogo + #46, #word23
static Catalogo + #48, #word24
static Catalogo + #50, #word25
static Catalogo + #52, #word26
static Catalogo + #54, #word27
static Catalogo + #56, #word28
static Catalogo + #58, #word29
static Catalogo + #60, #word30
static Catalogo + #62, #word31
static Catalogo + #64, #word32
static Catalogo + #66, #word33
static Catalogo + #68, #word34
static Catalogo + #70, #word35
static Catalogo + #72, #word36
static Catalogo + #74, #word37
static Catalogo + #76, #word38
static Catalogo + #78, #word39
static Catalogo + #80, #word40
static Catalogo + #82, #word41
static Catalogo + #84, #word42
static Catalogo + #86, #word43
static Catalogo + #88, #word44
static Catalogo + #90, #word45
static Catalogo + #92, #word46
static Catalogo + #94, #word47
static Catalogo + #96, #word48
static Catalogo + #98, #word49
static Catalogo + #100, #word50
static Catalogo + #102, #word51
static Catalogo + #104, #word52
static Catalogo + #106, #word53
static Catalogo + #108, #word54
static Catalogo + #110, #word55
static Catalogo + #112, #word56
static Catalogo + #114, #word57
static Catalogo + #116, #word58
static Catalogo + #118, #word59
static Catalogo + #120, #word60
static Catalogo + #122, #word61
static Catalogo + #124, #word62
static Catalogo + #126, #word63
static Catalogo + #128, #word64
static Catalogo + #130, #word65
static Catalogo + #132, #word66
static Catalogo + #134, #word67
static Catalogo + #136, #word68
static Catalogo + #138, #word69
static Catalogo + #140, #word70
static Catalogo + #142, #word71
static Catalogo + #144, #word72
static Catalogo + #146, #word73
static Catalogo + #148, #word74
static Catalogo + #150, #word75
static Catalogo + #152, #word76
static Catalogo + #154, #word77
static Catalogo + #156, #word78
static Catalogo + #158, #word79
static Catalogo + #160, #word80
static Catalogo + #162, #word81
static Catalogo + #164, #word82
static Catalogo + #166, #word83
static Catalogo + #168, #word84
static Catalogo + #170, #word85
static Catalogo + #172, #word86
static Catalogo + #174, #word87
static Catalogo + #176, #word88
static Catalogo + #178, #word89
static Catalogo + #180, #word90
static Catalogo + #182, #word91
static Catalogo + #184, #word92
static Catalogo + #186, #word93
static Catalogo + #188, #word94
static Catalogo + #190, #word95
static Catalogo + #192, #word96
static Catalogo + #194, #word97
static Catalogo + #196, #word98
static Catalogo + #198, #word99
static Catalogo + #200, #word100
static Catalogo + #202, #word101
static Catalogo + #204, #word102
static Catalogo + #206, #word103
static Catalogo + #208, #word104
static Catalogo + #210, #word105
static Catalogo + #212, #word106
static Catalogo + #214, #word107
static Catalogo + #216, #word108
static Catalogo + #218, #word109
static Catalogo + #220, #word110
static Catalogo + #222, #word111
static Catalogo + #224, #word112
static Catalogo + #226, #word113
static Catalogo + #228, #word114
static Catalogo + #230, #word115
static Catalogo + #232, #word116
static Catalogo + #234, #word117
static Catalogo + #236, #word118
static Catalogo + #238, #word119
static Catalogo + #240, #word120
static Catalogo + #242, #word121
static Catalogo + #244, #word122
static Catalogo + #246, #word123
static Catalogo + #248, #word124
static Catalogo + #250, #word125
static Catalogo + #252, #word126
static Catalogo + #254, #word127
static Catalogo + #256, #word128
static Catalogo + #258, #word129
static Catalogo + #260, #word130
static Catalogo + #262, #word131
static Catalogo + #264, #word132
static Catalogo + #266, #word133
static Catalogo + #268, #word134
static Catalogo + #270, #word135
static Catalogo + #272, #word136
static Catalogo + #274, #word137
static Catalogo + #276, #word138
static Catalogo + #278, #word139
static Catalogo + #280, #word140
static Catalogo + #282, #word141
static Catalogo + #284, #word142
static Catalogo + #286, #word143
static Catalogo + #288, #word144
static Catalogo + #290, #word145
static Catalogo + #292, #word146
static Catalogo + #294, #word147
static Catalogo + #296, #word148
static Catalogo + #298, #word149
static Catalogo + #300, #word150
static Catalogo + #302, #word151
static Catalogo + #304, #word152
static Catalogo + #306, #word153
static Catalogo + #308, #word154
static Catalogo + #310, #word155
static Catalogo + #312, #word156
static Catalogo + #314, #word157
static Catalogo + #316, #word158
static Catalogo + #318, #word159
static Catalogo + #320, #word160
static Catalogo + #322, #word161
static Catalogo + #324, #word162
static Catalogo + #326, #word163
static Catalogo + #328, #word164
static Catalogo + #330, #word165
static Catalogo + #332, #word166
static Catalogo + #334, #word167
static Catalogo + #336, #word168
static Catalogo + #338, #word169
static Catalogo + #340, #word170
static Catalogo + #342, #word171
static Catalogo + #344, #word172
static Catalogo + #346, #word173
static Catalogo + #348, #word174
static Catalogo + #350, #word175
static Catalogo + #352, #word176
static Catalogo + #354, #word177
static Catalogo + #356, #word178
static Catalogo + #358, #word179
static Catalogo + #360, #word180
static Catalogo + #362, #word181
static Catalogo + #364, #word182
static Catalogo + #366, #word183
static Catalogo + #368, #word184
static Catalogo + #370, #word185
static Catalogo + #372, #word186
static Catalogo + #374, #word187
static Catalogo + #376, #word188
static Catalogo + #378, #word189
static Catalogo + #380, #word190
static Catalogo + #382, #word191
static Catalogo + #384, #word192
static Catalogo + #386, #word193
static Catalogo + #388, #word194
static Catalogo + #390, #word195
static Catalogo + #392, #word196
static Catalogo + #394, #word197
static Catalogo + #396, #word198
static Catalogo + #398, #word199
static Catalogo + #400, #word200
static Catalogo + #402, #word201
static Catalogo + #404, #word202
static Catalogo + #406, #word203
static Catalogo + #408, #word204
static Catalogo + #410, #word205
static Catalogo + #412, #word206
static Catalogo + #414, #word207
static Catalogo + #416, #word208
static Catalogo + #418, #word209
static Catalogo + #420, #word210
static Catalogo + #422, #word211
static Catalogo + #424, #word212
static Catalogo + #426, #word213
static Catalogo + #428, #word214
static Catalogo + #430, #word215
static Catalogo + #432, #word216
static Catalogo + #434, #word217
static Catalogo + #436, #word218
static Catalogo + #438, #word219
static Catalogo + #440, #word220
static Catalogo + #442, #word221
static Catalogo + #444, #word222
static Catalogo + #446, #word223
static Catalogo + #448, #word224
static Catalogo + #450, #word225
static Catalogo + #452, #word226
static Catalogo + #454, #word227
static Catalogo + #456, #word228
static Catalogo + #458, #word229
static Catalogo + #460, #word230
static Catalogo + #462, #word231
static Catalogo + #464, #word232
static Catalogo + #466, #word233
static Catalogo + #468, #word234
static Catalogo + #470, #word235
static Catalogo + #472, #word236
static Catalogo + #474, #word237
static Catalogo + #476, #word238
static Catalogo + #478, #word239
static Catalogo + #480, #word240
static Catalogo + #482, #word241
static Catalogo + #484, #word242
static Catalogo + #486, #word243
static Catalogo + #488, #word244
static Catalogo + #490, #word245
static Catalogo + #492, #word246
static Catalogo + #494, #word247
static Catalogo + #496, #word248
static Catalogo + #498, #word249
static Catalogo + #500, #word250
static Catalogo + #502, #word251
static Catalogo + #504, #word252
static Catalogo + #506, #word253
static Catalogo + #508, #word254
static Catalogo + #510, #word255
static Catalogo + #512, #word256
static Catalogo + #514, #word257
static Catalogo + #516, #word258
static Catalogo + #518, #word259
static Catalogo + #520, #word260
static Catalogo + #522, #word261
static Catalogo + #524, #word262
static Catalogo + #526, #word263
static Catalogo + #528, #word264
static Catalogo + #530, #word265
static Catalogo + #532, #word266
static Catalogo + #534, #word267
static Catalogo + #536, #word268
static Catalogo + #538, #word269
static Catalogo + #540, #word270
static Catalogo + #542, #word271
static Catalogo + #544, #word272
static Catalogo + #546, #word273
static Catalogo + #548, #word274
static Catalogo + #550, #word275
static Catalogo + #552, #word276
static Catalogo + #554, #word277
static Catalogo + #556, #word278
static Catalogo + #558, #word279
static Catalogo + #560, #word280
static Catalogo + #562, #word281
static Catalogo + #564, #word282
static Catalogo + #566, #word283
static Catalogo + #568, #word284
static Catalogo + #570, #word285
static Catalogo + #572, #word286
static Catalogo + #574, #word287
static Catalogo + #576, #word288
static Catalogo + #578, #word289
static Catalogo + #580, #word290
static Catalogo + #582, #word291
static Catalogo + #584, #word292
static Catalogo + #586, #word293
static Catalogo + #588, #word294
static Catalogo + #590, #word295
static Catalogo + #592, #word296
static Catalogo + #594, #word297
static Catalogo + #596, #word298
static Catalogo + #598, #word299
static Catalogo + #600, #word300
static Catalogo + #602, #word301
static Catalogo + #604, #word302
static Catalogo + #606, #word303
static Catalogo + #608, #word304
static Catalogo + #610, #word305
static Catalogo + #612, #word306
static Catalogo + #614, #word307
static Catalogo + #616, #word308
static Catalogo + #618, #word309
static Catalogo + #620, #word310
static Catalogo + #622, #word311
static Catalogo + #624, #word312
static Catalogo + #626, #word313
static Catalogo + #628, #word314
static Catalogo + #630, #word315
static Catalogo + #632, #word316
static Catalogo + #634, #word317
static Catalogo + #636, #word318
static Catalogo + #638, #word319
static Catalogo + #640, #word320
static Catalogo + #642, #word321
static Catalogo + #644, #word322
static Catalogo + #646, #word323
static Catalogo + #648, #word324
static Catalogo + #650, #word325
static Catalogo + #652, #word326
static Catalogo + #654, #word327
static Catalogo + #656, #word328
static Catalogo + #658, #word329
static Catalogo + #660, #word330
static Catalogo + #662, #word331
static Catalogo + #664, #word332
static Catalogo + #666, #word333
static Catalogo + #668, #word334
static Catalogo + #670, #word335
static Catalogo + #672, #word336
static Catalogo + #674, #word337
static Catalogo + #676, #word338
static Catalogo + #678, #word339
static Catalogo + #680, #word340
static Catalogo + #682, #word341
static Catalogo + #684, #word342
static Catalogo + #686, #word343
static Catalogo + #688, #word344
static Catalogo + #690, #word345
static Catalogo + #692, #word346
static Catalogo + #694, #word347
static Catalogo + #696, #word348
static Catalogo + #698, #word349
static Catalogo + #700, #word350
static Catalogo + #702, #word351
static Catalogo + #704, #word352
static Catalogo + #706, #word353
static Catalogo + #708, #word354
static Catalogo + #710, #word355
static Catalogo + #712, #word356
static Catalogo + #714, #word357
static Catalogo + #716, #word358
static Catalogo + #718, #word359
static Catalogo + #720, #word360
static Catalogo + #722, #word361
static Catalogo + #724, #word362
static Catalogo + #726, #word363
static Catalogo + #728, #word364
static Catalogo + #730, #word365
static Catalogo + #732, #word366
static Catalogo + #734, #word367
static Catalogo + #736, #word368
static Catalogo + #738, #word369
static Catalogo + #740, #word370
static Catalogo + #742, #word371
static Catalogo + #744, #word372
static Catalogo + #746, #word373
static Catalogo + #748, #word374
static Catalogo + #750, #word375
static Catalogo + #752, #word376
static Catalogo + #754, #word377
static Catalogo + #756, #word378
static Catalogo + #758, #word379
static Catalogo + #760, #word380
static Catalogo + #762, #word381
static Catalogo + #764, #word382
static Catalogo + #766, #word383
static Catalogo + #768, #word384
static Catalogo + #770, #word385
static Catalogo + #772, #word386
static Catalogo + #774, #word387
static Catalogo + #776, #word388
static Catalogo + #778, #word389
static Catalogo + #780, #word390
static Catalogo + #782, #word391
static Catalogo + #784, #word392
static Catalogo + #786, #word393
static Catalogo + #788, #word394
static Catalogo + #790, #word395
static Catalogo + #792, #word396
static Catalogo + #794, #word397
static Catalogo + #796, #word398
static Catalogo + #798, #word399
static Catalogo + #800, #word400
static Catalogo + #802, #word401
static Catalogo + #804, #word402
static Catalogo + #806, #word403
static Catalogo + #808, #word404
static Catalogo + #810, #word405
static Catalogo + #812, #word406
static Catalogo + #814, #word407
static Catalogo + #816, #word408
static Catalogo + #818, #word409
static Catalogo + #820, #word410
static Catalogo + #822, #word411
static Catalogo + #824, #word412
static Catalogo + #826, #word413
static Catalogo + #828, #word414
static Catalogo + #830, #word415
static Catalogo + #832, #word416
static Catalogo + #834, #word417
static Catalogo + #836, #word418
static Catalogo + #838, #word419
static Catalogo + #840, #word420
static Catalogo + #842, #word421
static Catalogo + #844, #word422
static Catalogo + #846, #word423
static Catalogo + #848, #word424
static Catalogo + #850, #word425
static Catalogo + #852, #word426
static Catalogo + #854, #word427
static Catalogo + #856, #word428
static Catalogo + #858, #word429
static Catalogo + #860, #word430
static Catalogo + #862, #word431
static Catalogo + #864, #word432
static Catalogo + #866, #word433
static Catalogo + #868, #word434
static Catalogo + #870, #word435
static Catalogo + #872, #word436
static Catalogo + #874, #word437
static Catalogo + #876, #word438
static Catalogo + #878, #word439
static Catalogo + #880, #word440
static Catalogo + #882, #word441
static Catalogo + #884, #word442
static Catalogo + #886, #word443
static Catalogo + #888, #word444
static Catalogo + #890, #word445
static Catalogo + #892, #word446
static Catalogo + #894, #word447
static Catalogo + #896, #word448
static Catalogo + #898, #word449
static Catalogo + #900, #word450
static Catalogo + #902, #word451
static Catalogo + #904, #word452
static Catalogo + #906, #word453
static Catalogo + #908, #word454
static Catalogo + #910, #word455
static Catalogo + #912, #word456
static Catalogo + #914, #word457
static Catalogo + #916, #word458
static Catalogo + #918, #word459
static Catalogo + #920, #word460
static Catalogo + #922, #word461
static Catalogo + #924, #word462
static Catalogo + #926, #word463
static Catalogo + #928, #word464
static Catalogo + #930, #word465
static Catalogo + #932, #word466
static Catalogo + #934, #word467
static Catalogo + #936, #word468
static Catalogo + #938, #word469
static Catalogo + #940, #word470
static Catalogo + #942, #word471
static Catalogo + #944, #word472
static Catalogo + #946, #word473
static Catalogo + #948, #word474
static Catalogo + #950, #word475
static Catalogo + #952, #word476
static Catalogo + #954, #word477
static Catalogo + #956, #word478
static Catalogo + #958, #word479
static Catalogo + #960, #word480
static Catalogo + #962, #word481
static Catalogo + #964, #word482
static Catalogo + #966, #word483
static Catalogo + #968, #word484
static Catalogo + #970, #word485
static Catalogo + #972, #word486
static Catalogo + #974, #word487
static Catalogo + #976, #word488
static Catalogo + #978, #word489
static Catalogo + #980, #word490
static Catalogo + #982, #word491
static Catalogo + #984, #word492
static Catalogo + #986, #word493
static Catalogo + #988, #word494
static Catalogo + #990, #word495
static Catalogo + #992, #word496
static Catalogo + #994, #word497
static Catalogo + #996, #word498
static Catalogo + #998, #word499
static Catalogo + #1000, #word500
static Catalogo + #1002, #word501
static Catalogo + #1004, #word502
static Catalogo + #1006, #word503
static Catalogo + #1008, #word504
static Catalogo + #1010, #word505
static Catalogo + #1012, #word506
static Catalogo + #1014, #word507
static Catalogo + #1016, #word508
static Catalogo + #1018, #word509
static Catalogo + #1020, #word510
static Catalogo + #1022, #word511
static Catalogo + #1024, #word512
static Catalogo + #1026, #word513
static Catalogo + #1028, #word514
static Catalogo + #1030, #word515
static Catalogo + #1032, #word516
static Catalogo + #1034, #word517
static Catalogo + #1036, #word518
static Catalogo + #1038, #word519
static Catalogo + #1040, #word520
static Catalogo + #1042, #word521
static Catalogo + #1044, #word522
static Catalogo + #1046, #word523
static Catalogo + #1048, #word524
static Catalogo + #1050, #word525
static Catalogo + #1052, #word526
static Catalogo + #1054, #word527
static Catalogo + #1056, #word528
static Catalogo + #1058, #word529
static Catalogo + #1060, #word530
static Catalogo + #1062, #word531
static Catalogo + #1064, #word532
static Catalogo + #1066, #word533
static Catalogo + #1068, #word534
static Catalogo + #1070, #word535
static Catalogo + #1072, #word536
static Catalogo + #1074, #word537
static Catalogo + #1076, #word538
static Catalogo + #1078, #word539
static Catalogo + #1080, #word540
static Catalogo + #1082, #word541
static Catalogo + #1084, #word542
static Catalogo + #1086, #word543
static Catalogo + #1088, #word544
static Catalogo + #1090, #word545
static Catalogo + #1092, #word546
static Catalogo + #1094, #word547
static Catalogo + #1096, #word548
static Catalogo + #1098, #word549
static Catalogo + #1100, #word550
static Catalogo + #1102, #word551
static Catalogo + #1104, #word552
static Catalogo + #1106, #word553
static Catalogo + #1108, #word554
static Catalogo + #1110, #word555
static Catalogo + #1112, #word556
static Catalogo + #1114, #word557
static Catalogo + #1116, #word558
static Catalogo + #1118, #word559
static Catalogo + #1120, #word560
static Catalogo + #1122, #word561
static Catalogo + #1124, #word562
static Catalogo + #1126, #word563
static Catalogo + #1128, #word564
static Catalogo + #1130, #word565
static Catalogo + #1132, #word566
static Catalogo + #1134, #word567
static Catalogo + #1136, #word568
static Catalogo + #1138, #word569
static Catalogo + #1140, #word570
static Catalogo + #1142, #word571
static Catalogo + #1144, #word572
static Catalogo + #1146, #word573
static Catalogo + #1148, #word574
static Catalogo + #1150, #word575
static Catalogo + #1152, #word576
static Catalogo + #1154, #word577
static Catalogo + #1156, #word578
static Catalogo + #1158, #word579
static Catalogo + #1160, #word580
static Catalogo + #1162, #word581
static Catalogo + #1164, #word582
static Catalogo + #1166, #word583
static Catalogo + #1168, #word584
static Catalogo + #1170, #word585
static Catalogo + #1172, #word586
static Catalogo + #1174, #word587
static Catalogo + #1176, #word588
static Catalogo + #1178, #word589
static Catalogo + #1180, #word590
static Catalogo + #1182, #word591
static Catalogo + #1184, #word592
static Catalogo + #1186, #word593
static Catalogo + #1188, #word594
static Catalogo + #1190, #word595
static Catalogo + #1192, #word596
static Catalogo + #1194, #word597
static Catalogo + #1196, #word598
static Catalogo + #1198, #word599
static Catalogo + #1200, #word600
static Catalogo + #1202, #word601
static Catalogo + #1204, #word602
static Catalogo + #1206, #word603
static Catalogo + #1208, #word604
static Catalogo + #1210, #word605
static Catalogo + #1212, #word606
static Catalogo + #1214, #word607
static Catalogo + #1216, #word608
static Catalogo + #1218, #word609
static Catalogo + #1220, #word610
static Catalogo + #1222, #word611
static Catalogo + #1224, #word612
static Catalogo + #1226, #word613
static Catalogo + #1228, #word614
static Catalogo + #1230, #word615
static Catalogo + #1232, #word616
static Catalogo + #1234, #word617
static Catalogo + #1236, #word618
static Catalogo + #1238, #word619
static Catalogo + #1240, #word620
static Catalogo + #1242, #word621
static Catalogo + #1244, #word622
static Catalogo + #1246, #word623
static Catalogo + #1248, #word624
static Catalogo + #1250, #word625
static Catalogo + #1252, #word626
static Catalogo + #1254, #word627
static Catalogo + #1256, #word628
static Catalogo + #1258, #word629
static Catalogo + #1260, #word630
static Catalogo + #1262, #word631
static Catalogo + #1264, #word632
static Catalogo + #1266, #word633
static Catalogo + #1268, #word634
static Catalogo + #1270, #word635
static Catalogo + #1272, #word636
static Catalogo + #1274, #word637
static Catalogo + #1276, #word638
static Catalogo + #1278, #word639
static Catalogo + #1280, #word640
static Catalogo + #1282, #word641
static Catalogo + #1284, #word642
static Catalogo + #1286, #word643
static Catalogo + #1288, #word644
static Catalogo + #1290, #word645
static Catalogo + #1292, #word646
static Catalogo + #1294, #word647
static Catalogo + #1296, #word648
static Catalogo + #1298, #word649
static Catalogo + #1300, #word650
static Catalogo + #1302, #word651
static Catalogo + #1304, #word652
static Catalogo + #1306, #word653
static Catalogo + #1308, #word654
static Catalogo + #1310, #word655
static Catalogo + #1312, #word656
static Catalogo + #1314, #word657
static Catalogo + #1316, #word658
static Catalogo + #1318, #word659
static Catalogo + #1320, #word660
static Catalogo + #1322, #word661
static Catalogo + #1324, #word662
static Catalogo + #1326, #word663
static Catalogo + #1328, #word664
static Catalogo + #1330, #word665
static Catalogo + #1332, #word666
static Catalogo + #1334, #word667
static Catalogo + #1336, #word668
static Catalogo + #1338, #word669
static Catalogo + #1340, #word670
static Catalogo + #1342, #word671
static Catalogo + #1344, #word672
static Catalogo + #1346, #word673
static Catalogo + #1348, #word674
static Catalogo + #1350, #word675
static Catalogo + #1352, #word676
static Catalogo + #1354, #word677
static Catalogo + #1356, #word678
static Catalogo + #1358, #word679
static Catalogo + #1360, #word680
static Catalogo + #1362, #word681
static Catalogo + #1364, #word682
static Catalogo + #1366, #word683
static Catalogo + #1368, #word684
static Catalogo + #1370, #word685
static Catalogo + #1372, #word686
static Catalogo + #1374, #word687
static Catalogo + #1376, #word688
static Catalogo + #1378, #word689
static Catalogo + #1380, #word690
static Catalogo + #1382, #word691
static Catalogo + #1384, #word692
static Catalogo + #1386, #word693
static Catalogo + #1388, #word694
static Catalogo + #1390, #word695
static Catalogo + #1392, #word696
static Catalogo + #1394, #word697
static Catalogo + #1396, #word698
static Catalogo + #1398, #word699
static Catalogo + #1400, #word700
static Catalogo + #1402, #word701
static Catalogo + #1404, #word702
static Catalogo + #1406, #word703
static Catalogo + #1408, #word704
static Catalogo + #1410, #word705
static Catalogo + #1412, #word706
static Catalogo + #1414, #word707
static Catalogo + #1416, #word708
static Catalogo + #1418, #word709
static Catalogo + #1420, #word710
static Catalogo + #1422, #word711
static Catalogo + #1424, #word712
static Catalogo + #1426, #word713
static Catalogo + #1428, #word714
static Catalogo + #1430, #word715
static Catalogo + #1432, #word716
static Catalogo + #1434, #word717
static Catalogo + #1436, #word718
static Catalogo + #1438, #word719
static Catalogo + #1440, #word720
static Catalogo + #1442, #word721
static Catalogo + #1444, #word722
static Catalogo + #1446, #word723
static Catalogo + #1448, #word724
static Catalogo + #1450, #word725
static Catalogo + #1452, #word726
static Catalogo + #1454, #word727
static Catalogo + #1456, #word728
static Catalogo + #1458, #word729
static Catalogo + #1460, #word730
static Catalogo + #1462, #word731
static Catalogo + #1464, #word732
static Catalogo + #1466, #word733
static Catalogo + #1468, #word734
static Catalogo + #1470, #word735
static Catalogo + #1472, #word736
static Catalogo + #1474, #word737
static Catalogo + #1476, #word738
static Catalogo + #1478, #word739
static Catalogo + #1480, #word740
static Catalogo + #1482, #word741
static Catalogo + #1484, #word742
static Catalogo + #1486, #word743
static Catalogo + #1488, #word744
static Catalogo + #1490, #word745
static Catalogo + #1492, #word746
static Catalogo + #1494, #word747
static Catalogo + #1496, #word748
static Catalogo + #1498, #word749
static Catalogo + #1500, #word750
static Catalogo + #1502, #word751
static Catalogo + #1504, #word752
static Catalogo + #1506, #word753
static Catalogo + #1508, #word754
static Catalogo + #1510, #word755
static Catalogo + #1512, #word756
static Catalogo + #1514, #word757
static Catalogo + #1516, #word758
static Catalogo + #1518, #word759
static Catalogo + #1520, #word760
static Catalogo + #1522, #word761
static Catalogo + #1524, #word762
static Catalogo + #1526, #word763
static Catalogo + #1528, #word764
static Catalogo + #1530, #word765
static Catalogo + #1532, #word766
static Catalogo + #1534, #word767
static Catalogo + #1536, #word768
static Catalogo + #1538, #word769
static Catalogo + #1540, #word770
static Catalogo + #1542, #word771
static Catalogo + #1544, #word772
static Catalogo + #1546, #word773
static Catalogo + #1548, #word774
static Catalogo + #1550, #word775
static Catalogo + #1552, #word776
static Catalogo + #1554, #word777
static Catalogo + #1556, #word778
static Catalogo + #1558, #word779
static Catalogo + #1560, #word780
static Catalogo + #1562, #word781
static Catalogo + #1564, #word782
static Catalogo + #1566, #word783

;Tamanho desse catalogo = quantidade de palavras no catalogo original
static catTamanhos + #0, #5
static catTamanhos + #1, #5
static catTamanhos + #2, #5
static catTamanhos + #3, #5
static catTamanhos + #4, #5
static catTamanhos + #5, #5
static catTamanhos + #6, #5
static catTamanhos + #7, #5
static catTamanhos + #8, #5
static catTamanhos + #9, #5
static catTamanhos + #10, #5
static catTamanhos + #11, #5
static catTamanhos + #12, #5
static catTamanhos + #13, #5
static catTamanhos + #14, #5
static catTamanhos + #15, #5
static catTamanhos + #16, #5
static catTamanhos + #17, #5
static catTamanhos + #18, #5
static catTamanhos + #19, #5
static catTamanhos + #20, #5
static catTamanhos + #21, #5
static catTamanhos + #22, #5
static catTamanhos + #23, #5
static catTamanhos + #24, #5
static catTamanhos + #25, #5
static catTamanhos + #26, #5
static catTamanhos + #27, #5
static catTamanhos + #28, #5
static catTamanhos + #29, #5
static catTamanhos + #30, #5
static catTamanhos + #31, #5
static catTamanhos + #32, #5
static catTamanhos + #33, #5
static catTamanhos + #34, #5
static catTamanhos + #35, #5
static catTamanhos + #36, #5
static catTamanhos + #37, #5
static catTamanhos + #38, #5
static catTamanhos + #39, #5
static catTamanhos + #40, #5
static catTamanhos + #41, #5
static catTamanhos + #42, #5
static catTamanhos + #43, #5
static catTamanhos + #44, #5
static catTamanhos + #45, #5
static catTamanhos + #46, #5
static catTamanhos + #47, #5
static catTamanhos + #48, #5
static catTamanhos + #49, #5
static catTamanhos + #50, #5
static catTamanhos + #51, #5
static catTamanhos + #52, #5
static catTamanhos + #53, #5
static catTamanhos + #54, #5
static catTamanhos + #55, #5
static catTamanhos + #56, #5
static catTamanhos + #57, #5
static catTamanhos + #58, #5
static catTamanhos + #59, #5
static catTamanhos + #60, #5
static catTamanhos + #61, #5
static catTamanhos + #62, #5
static catTamanhos + #63, #5
static catTamanhos + #64, #5
static catTamanhos + #65, #5
static catTamanhos + #66, #5
static catTamanhos + #67, #5
static catTamanhos + #68, #5
static catTamanhos + #69, #5
static catTamanhos + #70, #5
static catTamanhos + #71, #5
static catTamanhos + #72, #5
static catTamanhos + #73, #5
static catTamanhos + #74, #5
static catTamanhos + #75, #5
static catTamanhos + #76, #5
static catTamanhos + #77, #5
static catTamanhos + #78, #5
static catTamanhos + #79, #5
static catTamanhos + #80, #5
static catTamanhos + #81, #5
static catTamanhos + #82, #5
static catTamanhos + #83, #5
static catTamanhos + #84, #5
static catTamanhos + #85, #5
static catTamanhos + #86, #5
static catTamanhos + #87, #5
static catTamanhos + #88, #5
static catTamanhos + #89, #5
static catTamanhos + #90, #5
static catTamanhos + #91, #5
static catTamanhos + #92, #5
static catTamanhos + #93, #5
static catTamanhos + #94, #5
static catTamanhos + #95, #5
static catTamanhos + #96, #5
static catTamanhos + #97, #5
static catTamanhos + #98, #5
static catTamanhos + #99, #5
static catTamanhos + #100, #5
static catTamanhos + #101, #5
static catTamanhos + #102, #5
static catTamanhos + #103, #5
static catTamanhos + #104, #5
static catTamanhos + #105, #5
static catTamanhos + #106, #5
static catTamanhos + #107, #5
static catTamanhos + #108, #5
static catTamanhos + #109, #5
static catTamanhos + #110, #5
static catTamanhos + #111, #5
static catTamanhos + #112, #5
static catTamanhos + #113, #5
static catTamanhos + #114, #5
static catTamanhos + #115, #5
static catTamanhos + #116, #5
static catTamanhos + #117, #5
static catTamanhos + #118, #5
static catTamanhos + #119, #5
static catTamanhos + #120, #5
static catTamanhos + #121, #5
static catTamanhos + #122, #5
static catTamanhos + #123, #5
static catTamanhos + #124, #5
static catTamanhos + #125, #5
static catTamanhos + #126, #5
static catTamanhos + #127, #5
static catTamanhos + #128, #5
static catTamanhos + #129, #5
static catTamanhos + #130, #5
static catTamanhos + #131, #5
static catTamanhos + #132, #5
static catTamanhos + #133, #5
static catTamanhos + #134, #5
static catTamanhos + #135, #5
static catTamanhos + #136, #5
static catTamanhos + #137, #5
static catTamanhos + #138, #5
static catTamanhos + #139, #5
static catTamanhos + #140, #5
static catTamanhos + #141, #5
static catTamanhos + #142, #5
static catTamanhos + #143, #5
static catTamanhos + #144, #5
static catTamanhos + #145, #5
static catTamanhos + #146, #5
static catTamanhos + #147, #5
static catTamanhos + #148, #5
static catTamanhos + #149, #5
static catTamanhos + #150, #5
static catTamanhos + #151, #5
static catTamanhos + #152, #5
static catTamanhos + #153, #5
static catTamanhos + #154, #5
static catTamanhos + #155, #5
static catTamanhos + #156, #5
static catTamanhos + #157, #5
static catTamanhos + #158, #5
static catTamanhos + #159, #5
static catTamanhos + #160, #5
static catTamanhos + #161, #5
static catTamanhos + #162, #5
static catTamanhos + #163, #5
static catTamanhos + #164, #5
static catTamanhos + #165, #5
static catTamanhos + #166, #5
static catTamanhos + #167, #5
static catTamanhos + #168, #5
static catTamanhos + #169, #5
static catTamanhos + #170, #5
static catTamanhos + #171, #5
static catTamanhos + #172, #5
static catTamanhos + #173, #5
static catTamanhos + #174, #5
static catTamanhos + #175, #5
static catTamanhos + #176, #5
static catTamanhos + #177, #5
static catTamanhos + #178, #5
static catTamanhos + #179, #5
static catTamanhos + #180, #5
static catTamanhos + #181, #5
static catTamanhos + #182, #5
static catTamanhos + #183, #5
static catTamanhos + #184, #5
static catTamanhos + #185, #5
static catTamanhos + #186, #5
static catTamanhos + #187, #5
static catTamanhos + #188, #5
static catTamanhos + #189, #5
static catTamanhos + #190, #5
static catTamanhos + #191, #5
static catTamanhos + #192, #5
static catTamanhos + #193, #5
static catTamanhos + #194, #5
static catTamanhos + #195, #5
static catTamanhos + #196, #5
static catTamanhos + #197, #5
static catTamanhos + #198, #5
static catTamanhos + #199, #5
static catTamanhos + #200, #5
static catTamanhos + #201, #5
static catTamanhos + #202, #5
static catTamanhos + #203, #5
static catTamanhos + #204, #5
static catTamanhos + #205, #5
static catTamanhos + #206, #5
static catTamanhos + #207, #5
static catTamanhos + #208, #5
static catTamanhos + #209, #5
static catTamanhos + #210, #5
static catTamanhos + #211, #5
static catTamanhos + #212, #5
static catTamanhos + #213, #5
static catTamanhos + #214, #5
static catTamanhos + #215, #5
static catTamanhos + #216, #5
static catTamanhos + #217, #5
static catTamanhos + #218, #5
static catTamanhos + #219, #5
static catTamanhos + #220, #5
static catTamanhos + #221, #5
static catTamanhos + #222, #5
static catTamanhos + #223, #5
static catTamanhos + #224, #5
static catTamanhos + #225, #5
static catTamanhos + #226, #5
static catTamanhos + #227, #5
static catTamanhos + #228, #5
static catTamanhos + #229, #5
static catTamanhos + #230, #5
static catTamanhos + #231, #5
static catTamanhos + #232, #5
static catTamanhos + #233, #5
static catTamanhos + #234, #5
static catTamanhos + #235, #5
static catTamanhos + #236, #5
static catTamanhos + #237, #5
static catTamanhos + #238, #5
static catTamanhos + #239, #5
static catTamanhos + #240, #5
static catTamanhos + #241, #5
static catTamanhos + #242, #5
static catTamanhos + #243, #5
static catTamanhos + #244, #5
static catTamanhos + #245, #5
static catTamanhos + #246, #5
static catTamanhos + #247, #5
static catTamanhos + #248, #5
static catTamanhos + #249, #5
static catTamanhos + #250, #5
static catTamanhos + #251, #5
static catTamanhos + #252, #5
static catTamanhos + #253, #5
static catTamanhos + #254, #5
static catTamanhos + #255, #5
static catTamanhos + #256, #5
static catTamanhos + #257, #5
static catTamanhos + #258, #5
static catTamanhos + #259, #5
static catTamanhos + #260, #5
static catTamanhos + #261, #5
static catTamanhos + #262, #5
static catTamanhos + #263, #5
static catTamanhos + #264, #5
static catTamanhos + #265, #5
static catTamanhos + #266, #5
static catTamanhos + #267, #5
static catTamanhos + #268, #5
static catTamanhos + #269, #5
static catTamanhos + #270, #5
static catTamanhos + #271, #5
static catTamanhos + #272, #5
static catTamanhos + #273, #5
static catTamanhos + #274, #5
static catTamanhos + #275, #5
static catTamanhos + #276, #5
static catTamanhos + #277, #5
static catTamanhos + #278, #5
static catTamanhos + #279, #5
static catTamanhos + #280, #5
static catTamanhos + #281, #5
static catTamanhos + #282, #5
static catTamanhos + #283, #5
static catTamanhos + #284, #5
static catTamanhos + #285, #5
static catTamanhos + #286, #5
static catTamanhos + #287, #5
static catTamanhos + #288, #5
static catTamanhos + #289, #5
static catTamanhos + #290, #5
static catTamanhos + #291, #5
static catTamanhos + #292, #5
static catTamanhos + #293, #5
static catTamanhos + #294, #5
static catTamanhos + #295, #5
static catTamanhos + #296, #5
static catTamanhos + #297, #5
static catTamanhos + #298, #5
static catTamanhos + #299, #5
static catTamanhos + #300, #5
static catTamanhos + #301, #5
static catTamanhos + #302, #5
static catTamanhos + #303, #5
static catTamanhos + #304, #5
static catTamanhos + #305, #5
static catTamanhos + #306, #5
static catTamanhos + #307, #5
static catTamanhos + #308, #5
static catTamanhos + #309, #5
static catTamanhos + #310, #5
static catTamanhos + #311, #5
static catTamanhos + #312, #5
static catTamanhos + #313, #5
static catTamanhos + #314, #5
static catTamanhos + #315, #5
static catTamanhos + #316, #5
static catTamanhos + #317, #5
static catTamanhos + #318, #5
static catTamanhos + #319, #5
static catTamanhos + #320, #5
static catTamanhos + #321, #5
static catTamanhos + #322, #5
static catTamanhos + #323, #5
static catTamanhos + #324, #5
static catTamanhos + #325, #5
static catTamanhos + #326, #5
static catTamanhos + #327, #5
static catTamanhos + #328, #5
static catTamanhos + #329, #5
static catTamanhos + #330, #5
static catTamanhos + #331, #5
static catTamanhos + #332, #5
static catTamanhos + #333, #5
static catTamanhos + #334, #5
static catTamanhos + #335, #5
static catTamanhos + #336, #5
static catTamanhos + #337, #5
static catTamanhos + #338, #5
static catTamanhos + #339, #5
static catTamanhos + #340, #5
static catTamanhos + #341, #5
static catTamanhos + #342, #5
static catTamanhos + #343, #5
static catTamanhos + #344, #5
static catTamanhos + #345, #5
static catTamanhos + #346, #5
static catTamanhos + #347, #5
static catTamanhos + #348, #5
static catTamanhos + #349, #5
static catTamanhos + #350, #5
static catTamanhos + #351, #5
static catTamanhos + #352, #5
static catTamanhos + #353, #5
static catTamanhos + #354, #5
static catTamanhos + #355, #5
static catTamanhos + #356, #5
static catTamanhos + #357, #5
static catTamanhos + #358, #5
static catTamanhos + #359, #5
static catTamanhos + #360, #5
static catTamanhos + #361, #5
static catTamanhos + #362, #5
static catTamanhos + #363, #5
static catTamanhos + #364, #5
static catTamanhos + #365, #5
static catTamanhos + #366, #5
static catTamanhos + #367, #5
static catTamanhos + #368, #5
static catTamanhos + #369, #5
static catTamanhos + #370, #5
static catTamanhos + #371, #5
static catTamanhos + #372, #5
static catTamanhos + #373, #5
static catTamanhos + #374, #5
static catTamanhos + #375, #5
static catTamanhos + #376, #5
static catTamanhos + #377, #5
static catTamanhos + #378, #5
static catTamanhos + #379, #5
static catTamanhos + #380, #5
static catTamanhos + #381, #5
static catTamanhos + #382, #5
static catTamanhos + #383, #5
static catTamanhos + #384, #5
static catTamanhos + #385, #5
static catTamanhos + #386, #5
static catTamanhos + #387, #5
static catTamanhos + #388, #5
static catTamanhos + #389, #5
static catTamanhos + #390, #5
static catTamanhos + #391, #5
static catTamanhos + #392, #5
static catTamanhos + #393, #5
static catTamanhos + #394, #5
static catTamanhos + #395, #5
static catTamanhos + #396, #5
static catTamanhos + #397, #5
static catTamanhos + #398, #5
static catTamanhos + #399, #5
static catTamanhos + #400, #5
static catTamanhos + #401, #5
static catTamanhos + #402, #5
static catTamanhos + #403, #5
static catTamanhos + #404, #5
static catTamanhos + #405, #5
static catTamanhos + #406, #5
static catTamanhos + #407, #5
static catTamanhos + #408, #5
static catTamanhos + #409, #5
static catTamanhos + #410, #5
static catTamanhos + #411, #5
static catTamanhos + #412, #5
static catTamanhos + #413, #5
static catTamanhos + #414, #5
static catTamanhos + #415, #5
static catTamanhos + #416, #5
static catTamanhos + #417, #5
static catTamanhos + #418, #5
static catTamanhos + #419, #5
static catTamanhos + #420, #5
static catTamanhos + #421, #5
static catTamanhos + #422, #5
static catTamanhos + #423, #5
static catTamanhos + #424, #5
static catTamanhos + #425, #5
static catTamanhos + #426, #5
static catTamanhos + #427, #5
static catTamanhos + #428, #5
static catTamanhos + #429, #5
static catTamanhos + #430, #5
static catTamanhos + #431, #5
static catTamanhos + #432, #5
static catTamanhos + #433, #5
static catTamanhos + #434, #5
static catTamanhos + #435, #5
static catTamanhos + #436, #5
static catTamanhos + #437, #5
static catTamanhos + #438, #5
static catTamanhos + #439, #5
static catTamanhos + #440, #5
static catTamanhos + #441, #5
static catTamanhos + #442, #5
static catTamanhos + #443, #5
static catTamanhos + #444, #5
static catTamanhos + #445, #5
static catTamanhos + #446, #5
static catTamanhos + #447, #5
static catTamanhos + #448, #5
static catTamanhos + #449, #5
static catTamanhos + #450, #5
static catTamanhos + #451, #5
static catTamanhos + #452, #5
static catTamanhos + #453, #5
static catTamanhos + #454, #5
static catTamanhos + #455, #5
static catTamanhos + #456, #5
static catTamanhos + #457, #5
static catTamanhos + #458, #5
static catTamanhos + #459, #5
static catTamanhos + #460, #5
static catTamanhos + #461, #5
static catTamanhos + #462, #5
static catTamanhos + #463, #5
static catTamanhos + #464, #5
static catTamanhos + #465, #5
static catTamanhos + #466, #5
static catTamanhos + #467, #5
static catTamanhos + #468, #5
static catTamanhos + #469, #5
static catTamanhos + #470, #5
static catTamanhos + #471, #5
static catTamanhos + #472, #5
static catTamanhos + #473, #5
static catTamanhos + #474, #5
static catTamanhos + #475, #5
static catTamanhos + #476, #5
static catTamanhos + #477, #5
static catTamanhos + #478, #5
static catTamanhos + #479, #5
static catTamanhos + #480, #5
static catTamanhos + #481, #5
static catTamanhos + #482, #5
static catTamanhos + #483, #5
static catTamanhos + #484, #5
static catTamanhos + #485, #5
static catTamanhos + #486, #5
static catTamanhos + #487, #5
static catTamanhos + #488, #5
static catTamanhos + #489, #5
static catTamanhos + #490, #5
static catTamanhos + #491, #5
static catTamanhos + #492, #5
static catTamanhos + #493, #5
static catTamanhos + #494, #5
static catTamanhos + #495, #5
static catTamanhos + #496, #5
static catTamanhos + #497, #5
static catTamanhos + #498, #5
static catTamanhos + #499, #5
static catTamanhos + #500, #5
static catTamanhos + #501, #5
static catTamanhos + #502, #5
static catTamanhos + #503, #5
static catTamanhos + #504, #5
static catTamanhos + #505, #5
static catTamanhos + #506, #5
static catTamanhos + #507, #5
static catTamanhos + #508, #5
static catTamanhos + #509, #5
static catTamanhos + #510, #5
static catTamanhos + #511, #5
static catTamanhos + #512, #5
static catTamanhos + #513, #5
static catTamanhos + #514, #5
static catTamanhos + #515, #5
static catTamanhos + #516, #5
static catTamanhos + #517, #5
static catTamanhos + #518, #5
static catTamanhos + #519, #5
static catTamanhos + #520, #5
static catTamanhos + #521, #5
static catTamanhos + #522, #5
static catTamanhos + #523, #5
static catTamanhos + #524, #5
static catTamanhos + #525, #5
static catTamanhos + #526, #5
static catTamanhos + #527, #5
static catTamanhos + #528, #5
static catTamanhos + #529, #5
static catTamanhos + #530, #5
static catTamanhos + #531, #5
static catTamanhos + #532, #5
static catTamanhos + #533, #5
static catTamanhos + #534, #5
static catTamanhos + #535, #5
static catTamanhos + #536, #5
static catTamanhos + #537, #5
static catTamanhos + #538, #5
static catTamanhos + #539, #5
static catTamanhos + #540, #5
static catTamanhos + #541, #5
static catTamanhos + #542, #5
static catTamanhos + #543, #5
static catTamanhos + #544, #5
static catTamanhos + #545, #5
static catTamanhos + #546, #5
static catTamanhos + #547, #5
static catTamanhos + #548, #5
static catTamanhos + #549, #5
static catTamanhos + #550, #5
static catTamanhos + #551, #5
static catTamanhos + #552, #5
static catTamanhos + #553, #5
static catTamanhos + #554, #5
static catTamanhos + #555, #5
static catTamanhos + #556, #5
static catTamanhos + #557, #5
static catTamanhos + #558, #5
static catTamanhos + #559, #5
static catTamanhos + #560, #5
static catTamanhos + #561, #5
static catTamanhos + #562, #5
static catTamanhos + #563, #5
static catTamanhos + #564, #5
static catTamanhos + #565, #5
static catTamanhos + #566, #5
static catTamanhos + #567, #5
static catTamanhos + #568, #5
static catTamanhos + #569, #5
static catTamanhos + #570, #5
static catTamanhos + #571, #5
static catTamanhos + #572, #5
static catTamanhos + #573, #5
static catTamanhos + #574, #5
static catTamanhos + #575, #5
static catTamanhos + #576, #5
static catTamanhos + #577, #5
static catTamanhos + #578, #5
static catTamanhos + #579, #5
static catTamanhos + #580, #5
static catTamanhos + #581, #5
static catTamanhos + #582, #5
static catTamanhos + #583, #5
static catTamanhos + #584, #5
static catTamanhos + #585, #5
static catTamanhos + #586, #5
static catTamanhos + #587, #5
static catTamanhos + #588, #5
static catTamanhos + #589, #5
static catTamanhos + #590, #5
static catTamanhos + #591, #5
static catTamanhos + #592, #5
static catTamanhos + #593, #5
static catTamanhos + #594, #5
static catTamanhos + #595, #5
static catTamanhos + #596, #5
static catTamanhos + #597, #5
static catTamanhos + #598, #5
static catTamanhos + #599, #5
static catTamanhos + #600, #5
static catTamanhos + #601, #5
static catTamanhos + #602, #5
static catTamanhos + #603, #5
static catTamanhos + #604, #5
static catTamanhos + #605, #5
static catTamanhos + #606, #5
static catTamanhos + #607, #5
static catTamanhos + #608, #5
static catTamanhos + #609, #5
static catTamanhos + #610, #5
static catTamanhos + #611, #5
static catTamanhos + #612, #5
static catTamanhos + #613, #5
static catTamanhos + #614, #5
static catTamanhos + #615, #5
static catTamanhos + #616, #5
static catTamanhos + #617, #5
static catTamanhos + #618, #5
static catTamanhos + #619, #5
static catTamanhos + #620, #5
static catTamanhos + #621, #5
static catTamanhos + #622, #5
static catTamanhos + #623, #5
static catTamanhos + #624, #5
static catTamanhos + #625, #5
static catTamanhos + #626, #5
static catTamanhos + #627, #5
static catTamanhos + #628, #5
static catTamanhos + #629, #5
static catTamanhos + #630, #5
static catTamanhos + #631, #5
static catTamanhos + #632, #5
static catTamanhos + #633, #5
static catTamanhos + #634, #5
static catTamanhos + #635, #5
static catTamanhos + #636, #5
static catTamanhos + #637, #5
static catTamanhos + #638, #5
static catTamanhos + #639, #5
static catTamanhos + #640, #5
static catTamanhos + #641, #5
static catTamanhos + #642, #5
static catTamanhos + #643, #5
static catTamanhos + #644, #5
static catTamanhos + #645, #5
static catTamanhos + #646, #5
static catTamanhos + #647, #5
static catTamanhos + #648, #5
static catTamanhos + #649, #5
static catTamanhos + #650, #5
static catTamanhos + #651, #5
static catTamanhos + #652, #5
static catTamanhos + #653, #5
static catTamanhos + #654, #5
static catTamanhos + #655, #5
static catTamanhos + #656, #5
static catTamanhos + #657, #5
static catTamanhos + #658, #5
static catTamanhos + #659, #5
static catTamanhos + #660, #5
static catTamanhos + #661, #5
static catTamanhos + #662, #5
static catTamanhos + #663, #5
static catTamanhos + #664, #5
static catTamanhos + #665, #5
static catTamanhos + #666, #5
static catTamanhos + #667, #5
static catTamanhos + #668, #5
static catTamanhos + #669, #5
static catTamanhos + #670, #5
static catTamanhos + #671, #5
static catTamanhos + #672, #5
static catTamanhos + #673, #5
static catTamanhos + #674, #5
static catTamanhos + #675, #5
static catTamanhos + #676, #5
static catTamanhos + #677, #5
static catTamanhos + #678, #5
static catTamanhos + #679, #5
static catTamanhos + #680, #5
static catTamanhos + #681, #5
static catTamanhos + #682, #5
static catTamanhos + #683, #5
static catTamanhos + #684, #5
static catTamanhos + #685, #5
static catTamanhos + #686, #5
static catTamanhos + #687, #5
static catTamanhos + #688, #5
static catTamanhos + #689, #5
static catTamanhos + #690, #5
static catTamanhos + #691, #5
static catTamanhos + #692, #5
static catTamanhos + #693, #5
static catTamanhos + #694, #5
static catTamanhos + #695, #5
static catTamanhos + #696, #5
static catTamanhos + #697, #5
static catTamanhos + #698, #5
static catTamanhos + #699, #5
static catTamanhos + #700, #5
static catTamanhos + #701, #5
static catTamanhos + #702, #5
static catTamanhos + #703, #5
static catTamanhos + #704, #5
static catTamanhos + #705, #5
static catTamanhos + #706, #5
static catTamanhos + #707, #5
static catTamanhos + #708, #5
static catTamanhos + #709, #5
static catTamanhos + #710, #5
static catTamanhos + #711, #5
static catTamanhos + #712, #5
static catTamanhos + #713, #5
static catTamanhos + #714, #5
static catTamanhos + #715, #5
static catTamanhos + #716, #5
static catTamanhos + #717, #5
static catTamanhos + #718, #5
static catTamanhos + #719, #5
static catTamanhos + #720, #5
static catTamanhos + #721, #5
static catTamanhos + #722, #5
static catTamanhos + #723, #5
static catTamanhos + #724, #5
static catTamanhos + #725, #5
static catTamanhos + #726, #5
static catTamanhos + #727, #5
static catTamanhos + #728, #5
static catTamanhos + #729, #5
static catTamanhos + #730, #5
static catTamanhos + #731, #5
static catTamanhos + #732, #5
static catTamanhos + #733, #5
static catTamanhos + #734, #5
static catTamanhos + #735, #5
static catTamanhos + #736, #5
static catTamanhos + #737, #5
static catTamanhos + #738, #5
static catTamanhos + #739, #5
static catTamanhos + #740, #5
static catTamanhos + #741, #5
static catTamanhos + #742, #5
static catTamanhos + #743, #5
static catTamanhos + #744, #5
static catTamanhos + #745, #5
static catTamanhos + #746, #5
static catTamanhos + #747, #5
static catTamanhos + #748, #5
static catTamanhos + #749, #5
static catTamanhos + #750, #5
static catTamanhos + #751, #5
static catTamanhos + #752, #5
static catTamanhos + #753, #5
static catTamanhos + #754, #5
static catTamanhos + #755, #5
static catTamanhos + #756, #5
static catTamanhos + #757, #5
static catTamanhos + #758, #5
static catTamanhos + #759, #5
static catTamanhos + #760, #5
static catTamanhos + #761, #5
static catTamanhos + #762, #5
static catTamanhos + #763, #5
static catTamanhos + #764, #5
static catTamanhos + #765, #5
static catTamanhos + #766, #5
static catTamanhos + #767, #5
static catTamanhos + #768, #5
static catTamanhos + #769, #5
static catTamanhos + #770, #5
static catTamanhos + #771, #5
static catTamanhos + #772, #5
static catTamanhos + #773, #5
static catTamanhos + #774, #5
static catTamanhos + #775, #5
static catTamanhos + #776, #5
static catTamanhos + #777, #5
static catTamanhos + #778, #5
static catTamanhos + #779, #5
static catTamanhos + #780, #5
static catTamanhos + #781, #5
static catTamanhos + #782, #5
static catTamanhos + #783, #5

;--- MSGS PRINTADAS DURANTE O JOGO-------
Msn0: string "V O C E   V E N C E U !!!"
Msn1: string "Quer jogar novamente? <s/n>"
Msn2: string "V O C E   P E R D E U !!!"
Msn3: string "A palavra da rodada era: "
Msn4: string "TENTATIVA"
;------------------------------
;Menu principal do jogo:
main:
	call ImprimeTela ;tela do menu 

	main_loop:	
	call InputTecla 
	loadn r0, #13  ;ASCII ENTER = 13
	load r1, Tecla ;pega a tecla inputada
	cmp r0, r1	   ;input == ENTER?
	jeq jogo       ;se sim, go to para a função do jogo 

   loadn r0, #'1'    ;no caso da tecla 1 ser inputada
   load r1, Tecla
	cmp r0,r1         ;input == 1?
   jeq Instrucaotela ;se sim, go to para a tela das intruções
   
   jmp main_loop     ;digitar uma tecla inválida faz o programa continuar no loop
   call ApagaTela
	halt

;Main do jogo:
jogo:
   call ImprimeTela3 ;tela para gerar a palavra
   call GeradorPalavra

	loadn r0, #0
	store Acerto, r0	;contador de acertos
   store Erro, r0		;contador de erros

   call ApagaTela
   call SorteiaPalavra 
   
   ;--calcula a posicao com base na palavra sorteada
   
	loadn r3, #40		;tamanho da linha da tela
	loadn r4, #8		;maximo de tentativas por padrao
	load r0, TamanhoPalavra
	loadn r2, #376			;traços no ponto central da tela	
	store posCursor, r2  ;desloca o cursor na tela a cada palavra

	loadn r1, #0 		;guarda o numero da tentativa
	loadn r3, #40 		;tamanho da linha da tela
   
	Loop:
		loadn r5, #0
		store contadorVerdes, r5 ;contador é zerado a cada tentativa
      
      call PrintaTentativa
		call DesenhaTracos
		call InputPalavra
		call ChecaPalavra 
		call Compara
		call TestaFim
      inc r1            ;tentativas++
      store Contador,r1 ;salva na variável pra usar dps 

		add r2, r2, r3		;passa pra proxima linha
		store posCursor, r2

		cmp r1, r4 		;caso nao tenha excedido o numero de tentativas, continua
		jne Loop
	
jogoFim:
	halt
;***********************************************************************
; COMPARA A PALAVRA DIGITADA PELO JOGADOR COM A CORRETA LETRA POR LETRA
;***********************************************************************
ChecaPalavra:
	push r0
	push r1
	push r2
	push r3
	push r4

	loadn r1, #PalavraDigitada ;endereco de inicio da palavra
	load r2, TamanhoPalavra
	loadn r3, #0 ;contador de letras

	checaPalavra_Loop:
		store posLetra, r3
		add r4, r1, r3		;pega o endereco exato da letra a ser lida
		loadi r0, r4		;r0 = memoria[r4]
		store Tecla, r0
		call ChecaLetra
		inc r3
		cmp r3, r2 	;se tiver acabado a palavra, sai
		jne checaPalavra_Loop

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
;***********************************************************************
; CHECA UMA LETRA COM TODA A PALAVRA CERTA E PINTA ELA COM A
;          COR DE ACORDO COM A SUA APARICAO E POSICAO
;***********************************************************************
ChecaLetra: 
	push r0        ;r0 =letra a ser checada com todas as outras
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
   push r7

	load r1, Palavra 	;endereco da palavra
	load r2, TamanhoPalavra	
	loadn r3, #0 		;contador
	loadn r5, #2304   ;letras que não estão na palavra(ASCII vermelho)		
   load r7, contadorVerdes

	checaLetra_Loop:
		add r4, r1, r3 		
		loadi r4, r4	;r4 = memória[r4] (Letra da palavra certa a ser checada)
		cmp r0, r4
		jeq letraPresente

	  checaLetra_Continue:
		inc r3
		cmp r2, r3
		jeq checaLetra_Sai	;caso ja tenha acabado a palavra, sai do loop
		jmp checaLetra_Loop


	letraPresente:
		load r6, posLetra
		cmp r6, r3 			
		jne letraAmarela  ;caso a letra esteja presente, mas no lugar errado
      inc r7
		loadn r5, #512 	;caso a letra esteja presente e no lugar certo(ASCII verde)
		jmp checaLetra_Sai

		letraAmarela:
			loadn r5, #2816   ;ASCII amarelo
			jmp checaLetra_Continue


   	checaLetra_Sai:
   		load r3, posLetra
	   	load r4, posCursor
	   	add r4, r4, r3		;pega endereco da posicao certa
	   	add r0, r0, r5 		
	   	store contadorVerdes, r7
	   	
		outchar r0, r4
      cmp r7,r2
	   jeq TestaFim

	   pop r7
	  	pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

;********************************************************
;          SALVA A PALAVRA DIGITADA PELO USUÁRIO
;********************************************************
InputPalavra:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	
	loadn r1, #PalavraDigitada 	;endereco reservado pra palavra a ser digitada
	load r2, TamanhoPalavra       
	load r3, posCursor			   ;aponta o inicio da linha para escrever
	loadn r4, #0 				      ;contador de letras

	inputPalavra_Loop:
		call InputTecla
		load r0, Tecla
		loadn r6, #13
		cmp r0, r6
		jeq jogoFim
		add r5, r1, r4 		;r5 =posicao da letra a ser inserida na memoria
		storei r5, r0 			;memoria[r5] = r0

		outchar r0, r3
		inc r3

		inc r4
		cmp r4, r2
		jne inputPalavra_Loop

	loadn r0, #0
	add r4, r4, r3
	storei r4, r0

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
;********************************************************
;            DESENHA OS TRACOS DA PALAVRA
;********************************************************
DesenhaTracos:	;r0 =numero da linha que vai iniciar
	push r0
	push r1
	push r2
	push r3
	push r4

	load r1, TamanhoPalavra
	loadn r4, #0 			;contador de Letras
   store Contador,r4
	load r2, posCursor
   
	DesenhaTracos_Loop:
		loadn r3, #3551	;underline rosa = caracter '_'(223) + (3328)rosa = 3551
		outchar r3, r2
		inc r2
		inc r4
		cmp r1, r4
		jne DesenhaTracos_Loop	;se o contador for igual ao tamanho, sai do loop

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;********************************************************
;            SORTEIA UMA PALAVRA DO CATALOGO 
;********************************************************
SorteiaPalavra:
	push r0
	push r1
	push r2
	push r3
	push r4
   push r5

	load r1, chaveRandom ;seleciona um numero entre 0 e o tamanho do catalogo
	rotl r1, #4		 	   ;faz um rotate pra tentar deixar random
	loadn r2, #783 		;numero de palavras no catalogo (ATUALIZAR CASO ADICIONE MAIS)
	mod r2, r1, r2 		;r1 = chaveRandom % r2=numCatalogo (um numero random)

	loadn r3, #2         ;tamanho de um endereco de memoria 			
	loadn r4, #Catalogo	;endereco do inicio do catalogo de palavras
	mul r3, r3, r2       
	add r4, r4, r3			;pula algumas palavras
	loadi r4, r4

	store Palavra, r4	   ;guarda palavra a ser usada

	;salva o tamanho da palavra
	loadn r4, #catTamanhos
	add r4, r4, r2
	loadi r4, r4

	store TamanhoPalavra, r4
   pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;********************************************************
;              IMPRIME A TELA DO MENU
;********************************************************	

ImprimeTela: 	

  push R0
  push R1
  push R2
  push R3

  loadn R0, #telainicio
  loadn R1, #0
  loadn R2, #1200

ImprimeTela_Loop:
	 add R3,R0,R1
    loadi R3,R3
    outchar R3,R1
    inc R1
    cmp R1,R2

    jne ImprimeTela_Loop

  pop R3
  pop R2
  pop R1
  pop R0
  rts
;********************************************************
;                       IMPRIME STRING
;********************************************************
ImprimeStr:	    
            ;r0 = Posicao da tela que o primeiro caractere da mensagem será impresso  
            ;r1 = endereco onde comeca a mensagem
            ;r2 = cor da mensagem. 
	push r0	;protege o r0 na pilha para preservar seu valor
	push r1	;protege o r1 na pilha para preservar seu valor
	push r2	;protege o r1 na pilha para preservar seu valor
	push r3	;protege o r3 na pilha para ser usado na subrotina
	push r4	;protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	;A mensagem será impressa até encontrar "\0"

   ImprimeStr_Loop:	
		loadi r4, r1
		cmp r4, r3		      ; if(char == \0) 
		jeq ImprimeStr_Sai   ;sai do loop
		add r4, r2, r4	      ;soma a cor
		outchar r4, r0	      ;imprime o caractere na tela
		inc r0			      ;incrementa a posicao na tela
		inc r1			      ;incrementa o ponteiro da string
		jmp ImprimeStr_Loop
	
   ImprimeStr_Sai:	
	pop r4	;resgata os valores dos registradores utilizados na ubrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;********************************************************
;                       APAGA TELA
;********************************************************
ApagaTela:
	push r0
	push r1
	
	loadn r0, #1200	;apaga as 1200 posicoes da tela
	loadn r1, #' '		;com "espaco"
	
	ApagaTela_Loop:	;label for(r0=1200;r0>0;r0--)
	   dec r0
	   outchar r1, r0
	   jnz ApagaTela_Loop
 
	pop r1
	pop r0
	rts	
;********************************************************
;  SALVA ALGUMA TECLA INPUTADA NA VARIÁVEL "TECLA" 
;********************************************************
InputTecla:	   
   push fr		;protege o registrador de flags
	push r0
	push r1
	push r2
	loadn r1, #255	;se nao inputar nada vem 255
	loadn r2, #0	;logo que programa a FPGA o inchar vem 0
   
   InputTecla_Loop:
		inchar r0			   ;lê do teclado, se nada for digitado = 255
		cmp r0, r1			   ;compara r0 com 255
		jeq InputTecla_Loop	;fica lendo até que digite uma tecla válida
		cmp r0, r2			   ;compara r0 com 0
		jeq InputTecla_Loop	;lê novamente pois logo que programa a FPGA o inchar vem 0

	   store Tecla, r0	   ;salva a tecla na variavel global "Tecla"
	
	pop r2
	pop r1
	pop r0
	pop fr
	rts

;********************************************************
;               IMPRIME O MENU DE INSTRUCAO
;********************************************************
ImprimeTela2: 	
		                
  push R0
  push R1
  push R2
  push R3

  loadn R0, #tela2
  loadn R1, #0    ;r1 = endereco onde comeca a primeira linha do cenário
  loadn R2, #1200 ;r2 = até onde termina o cenário

ImprimeTela2_Loop:

	add R3,R0,R1   ;soma da tela com a posição
   loadi R3, R3
   outchar R3, R1  ;o que é printado e onde
   inc R1
   cmp R1, R2
   jne ImprimeTela2_Loop
    
  pop R3
  pop R2
  pop R1
  pop R0
  rts
;********************************************************
;               IMPRIME A TELA DE GERAR PALAVRA
;********************************************************
ImprimeTela3: 	

  push R0
  push R1
  push R2
  push R3

  loadn R0, #tela3
  loadn R1, #0    ;onde começa
  loadn R2, #1200 ;onde termina

ImprimeTela3_Loop:

	add R3,R0,R1
   loadi R3, R3
   outchar R3, R1
   inc R1
   cmp R1, R2
   jne ImprimeTela3_Loop
    
  pop R3
  pop R2
  pop R1
  pop R0
  rts
;********************************************************
;              COMANDOS DA TELA DE INTRUÇÕES
;********************************************************
Instrucaotela:	
      call ApagaTela
      call ImprimeTela2

   Instrucaotela_Loop:
      call InputTecla
		loadn r0, #'0'
		load r1, Tecla
		cmp r0, r1			
		jne Instrucaotela_Loop ;fica no loop se a tecla for diferente de 0
      jmp main               ;go to menu quando inputa 0 

;********************************************************
;     CONFERE SE A LETRA DIGITADA PERTENCE A PALAVRA
;********************************************************	
Compara:	   

	push fr	;Protege o registrador de flags
	push r0	;acertou a letra?
	push r1	;i = 0
	push r2	;TamanhoPalavra
	push r3	;Letra
	push r4	;#Palavra
	push r5	;palavra + i
	push r6	;Posicao na tela onde a letra da palavra vai ser escrita
	push r7	;Aux: Pos na tela e palavra[i]

	loadn r0, #0	;acertou = 0
	loadn r1, #0	;i = 0
	load r2, TamanhoPalavra
	load r3, Tecla
	loadn r4, #Palavra

   Compara_Loop:	;enquanto ( i < TamanhoPalavra )
		;verifica se já testou todas as letras da palavra
		cmp r1, r2	;i < TamanhoPalavra?
		jeq Compara_Fim
		
		;verifica se a letra digitada pertence a palavra na posicao i
		add r5, r4, r1	;r5 = palavra + i
		loadi r7, r5	;r7 = palavra[i]
		cmp r3, r7	;Letra == palavra[i] ?
		jne Compara_NaoPertence
		
		add r7, r6, r1	;r7 = pos na tela : r7 = posicao inicial + i
		outchar r3, r7	;imprime Letra na tela no traço correspondente
		
		load r7, Acerto
		inc r7		;incrementa o contador de acertos
		store Acerto, r7 ;atualiza o numero de acertos
		
		inc r1         ; i++
		loadn r0, #1	;acertou = 1
		jmp Compara_Loop

   Compara_NaoPertence:
	;se nao achou a Letra, incrementa o i e volta pro Loop
	inc r1		      ; i++
	jmp Compara_Loop

   Compara_Fim:
	;verifica se terminou de testar a letra digitada com todas as letras da palavra
	;verifica se houve um acerto
	loadn r7, #1
	cmp r0, r7	;acertou == 1 ?
	jeq Compara_FimSwitch	;se sim, sai da comparação
	load r7, Erro	         ;se nao, incrementa o contador de erro
	inc r7			         ;erro++
	store Erro, r7          ;atualiza o numero de erros
   
   ;Switch erro (r7)
   ;Case 1:
	loadn r0, #1
	cmp r7, r0	   ;erro = 1
	jne Compara_Case2
	jmp Compara_FimSwitch	;break

   Compara_Case2:
	loadn r0, #2	;erro = 2
	cmp r7, r0
	jne Compara_Case3
	jmp Compara_FimSwitch	;break

   Compara_Case3:
	loadn r0, #3	;erro = 3
	cmp r7, r0
	jne Compara_Case4
	jmp Compara_FimSwitch	;break 
	
   Compara_Case4:
	loadn r0, #4	;erro = 4
	cmp r7, r0
	jne Compara_Case5
	jmp Compara_FimSwitch	;break 

   Compara_Case5:
	loadn r0, #5	;erro = 5
	cmp r7, r0
	jne Compara_Case6
	jmp Compara_FimSwitch	;break 

   Compara_Case6:
	loadn r0, #6	;erro = 6
	cmp r7, r0
	jne Compara_Case7
	jmp Compara_FimSwitch	;break 	

   Compara_Case7:
	loadn r0, #7	;erro = 7
	cmp r7, r0
	jne Compara_Case8
	jmp Compara_FimSwitch	;break 	


   Compara_Case8:	
	loadn r0, #8	;erro = 8
	cmp r7, r0
	jne Compara_FimSwitch ;jogo acabou

   Compara_FimSwitch:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts	
;----------------
;********************************************************
;         VERIFICA SE O JOGO TERMINOU
;********************************************************	
TestaFim:	 
	push fr	;Protege o registrador de flags
	push r0	;Posicao na Tela
	push r1	;Ponteiro para as mensagens
	push r2	;Cor das mensagens
	push r3	;Contador de Acertos
	push r4	;Tamanho da Palavra
	push r5	;Contador de Erro
	push r6	;Numero maximo de erros
   
   load r3, Acerto
   load r4, TamanhoPalavra
	load r5, Erro
	loadn r6, #8	;numero maximo de tentativas = 8
	
	
	cmp r5, r6	         ;erro = 8?
	jeq TestaFim_Perdeu	;se sim, game over
	
	load r3, contadorVerdes
	cmp r3, r4	      ;acerto = TamanhoPalavra ?
	jne TestaFim_Sai	;se nao, go digitar outra Letra , se sim, continua na função          
   loadn r0, #808    ;posicao que imprime na tela
	loadn r1, #Msn0   ;imprime voce venceu
	loadn r2, #512
	call ImprimeStr

   TestaFim_JogarNovamente:	
	loadn r0, #1086
	loadn r1, #Msn1   ;imprime quer jogar novamente
	loadn r2, #3328
	call ImprimeStr
	call InputTecla   ;usuário digita uma tecla
	loadn r3, #'n'    
	load r4, Tecla
	cmp r3, r4		   ;tecla == 'n'?
	jeq TestaFim_FimJogo	  ;se tecla == 'n', go to fim do jogo
   loadn r3, #'s'
	load r4, Tecla
	cmp r3, r4		   ;tecla == 's'?
	jne TestaFim_JogarNovamente ;se tecla == 's', restart
	
	call ApagaTela
	pop r6	
	pop r5	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	pop r0	;da um Pop a mais para acertar o ponteiro da pilha, pois nao vai dar o rts 
	jmp main

TestaFim_Perdeu:

	loadn r0, #808    ;posicao
	loadn r1, #Msn2   ;imprime voce perdeu 
	loadn r2, #2304   ;cor
	call ImprimeStr

   loadn r0, #964
	loadn r1, #Msn3   ;imprime "A palavra da rodada era:"
	loadn r2, #0
	call ImprimeStr

   loadn r0, #988
	load r1, Palavra  ;imprime a palavra escolhida da rodada
	loadn r2, #512
	call ImprimeStr
	jmp TestaFim_JogarNovamente

   TestaFim_FimJogo:
	call ApagaTela
	halt
	
   TestaFim_Sai:

	pop r6
	pop r5	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts
;********************************************************
;    GERA UMA CHAVE PARA PEGAR UMA PALAVRA DO CATALOGO
;********************************************************
GeradorPalavra: 	
	push r0
	push r1
	push r2

	loadn r0, #255	;se nao digitar nada, tem um espaco
	loadn r1, #32 	;codigo ASCII do espaço
	loadn r2, #0 	;inicia contador em zero

	GeradorPalavra_loop:
		inchar r0
		inc r2
		cmp r0, r1
		jne GeradorPalavra_loop

	store chaveRandom, r2

	pop r2
	pop r1
	pop r0
	rts
;********************************************************
;    PRINTA E INCREMENTA AS TENTATIVAS DURANTE A RODADA
;********************************************************
PrintaTentativa:

	push r0
	push r1
	push r2
	push r3
   push r4
   
    loadn r3, #0 ;compara
    load r4, Contador ;numeros de tentativas	
    cmp r3,r4
    jeq PrintaTentativa1

    loadn r3, #1 ;compara
    load r4, Contador ;numeros de tentativas	
    cmp r3,r4
    jeq PrintaTentativa2
      
    loadn r3, #2 ;compara
    load r4, Contador ;numeros de tentativas	
    cmp r3,r4
    jeq PrintaTentativa3

    loadn r3, #3 ;compara
    load r4, Contador ;numeros de tentativas	
    cmp r3,r4
    jeq PrintaTentativa4

    loadn r3, #4 ;compara
    load r4, Contador ;numeros de tentativas	
    cmp r3,r4
    jeq PrintaTentativa5

    loadn r3, #5;compara
    load r4, Contador ;numeros de tentativas	
    cmp r3,r4
    jeq PrintaTentativa6

    loadn r3, #6 ;compara
    load r4, Contador ;numeros de tentativas	
    cmp r3,r4
    jeq PrintaTentativa7

    loadn r3, #7 ;compara
    load r4, Contador ;numeros de tentativas	
    cmp r3,r4
    jeq PrintaTentativa8

    PrintaTentativa_Fim:
	   pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

	PrintaTentativa1:	
		
		loadn r0, #223    ;posicao da tela onde é impresso
		loadn r1, #'1'    ;caracter impresso
	   loadn r2, #3328   ;cor rosa
	   add r1,r1,r2      ;colore o caracter
		outchar r1, r0    ;imprime o caracter r1 na posicao r0
	   loadn r0, #213
		loadn r1, #Msn4
		loadn r2, #3328
		call ImprimeStr
		jmp PrintaTentativa_Fim
	   
		
	PrintaTentativa2:	

		loadn r0, #223    ;posicao da tela onde é impresso
		loadn r1, #'2'    ;caracter impresso
	   loadn r2, #3328   ;cor rosa
	   add r1,r1,r2      ;colore o caracter
		outchar r1, r0    ;imprime o caracter r1 na posicao r0
	   loadn r0, #213
		loadn r1, #Msn4
		loadn r2, #3328
		call ImprimeStr
		jmp PrintaTentativa_Fim
	   
	
	PrintaTentativa3:	
		
		loadn r0, #223    ;posicao da tela onde é impresso
		loadn r1, #'3'    ;caracter impresso
	   loadn r2, #3328   ;cor rosa
	   add r1,r1,r2      ;colore o caracter
		outchar r1, r0    ;imprime o caracter r1 na posicao r0
	   loadn r0, #213
		loadn r1, #Msn4
		loadn r2, #3328
		call ImprimeStr
		jmp PrintaTentativa_Fim


	PrintaTentativa4:	
		
		loadn r0, #223    ;posicao da tela onde é impresso
		loadn r1, #'4'    ;caracter impresso
	   loadn r2, #3328   ;cor rosa
	   add r1,r1,r2      ;colore o caracter
		outchar r1, r0    ;imprime o caracter r1 na posicao r0
	   loadn r0, #213
		loadn r1, #Msn4
		loadn r2, #3328
		call ImprimeStr
		jmp PrintaTentativa_Fim
	   
		
	PrintaTentativa5:	
		
		loadn r0, #223    ;posicao da tela onde é impresso
		loadn r1, #'5'    ;caracter impresso
	   loadn r2, #3328   ;cor rosa
	   add r1,r1,r2      ;colore o caracter
		outchar r1, r0    ;imprime o caracter r1 na posicao r0
	   loadn r0, #213
		loadn r1, #Msn4
		loadn r2, #3328
		call ImprimeStr
		jmp PrintaTentativa_Fim
	   
		
	PrintaTentativa6:	
		
		loadn r0, #223    ;posicao da tela onde é impresso
		loadn r1, #'6'    ;caracter impresso
	   loadn r2, #3328   ;cor rosa
	   add r1,r1,r2      ;colore o caracter
		outchar r1, r0    ;imprime o caracter r1 na posicao r0
	   loadn r0, #213
		loadn r1, #Msn4
		loadn r2, #3328
		call ImprimeStr
	   jmp PrintaTentativa_Fim
		

	PrintaTentativa7:	
		
		loadn r0, #223    ;posicao da tela onde é impresso
		loadn r1, #'7'    ;caracter impresso
	   loadn r2, #3328   ;cor rosa
	   add r1,r1,r2      ;colore o caracter
		outchar r1, r0    ;imprime o caracter r1 na posicao r0
	   loadn r0, #213
		loadn r1, #Msn4
		loadn r2, #3328
		call ImprimeStr
	   jmp PrintaTentativa_Fim


	PrintaTentativa8:	

		loadn r0, #223    ;posicao da tela onde é impresso
		loadn r1, #'8'    ;caracter impresso
	   loadn r2, #3328   ;cor rosa
	   add r1,r1,r2      ;colore o caracter
		outchar r1, r0    ;imprime o caracter r1 na posicao r0
	   loadn r0, #213
		loadn r1, #Msn4
		loadn r2, #3328
		call ImprimeStr
		jmp PrintaTentativa_Fim

  ;Tela das instruções
  tela2 : var #1200
  ;Linha 0
  static tela2 + #0, #2877
  static tela2 + #1, #2877
  static tela2 + #2, #2877
  static tela2 + #3, #2877
  static tela2 + #4, #2877
  static tela2 + #5, #2877
  static tela2 + #6, #2877
  static tela2 + #7, #2877
  static tela2 + #8, #2877
  static tela2 + #9, #2877
  static tela2 + #10, #2877
  static tela2 + #11, #2877
  static tela2 + #12, #2877
  static tela2 + #13, #2877
  static tela2 + #14, #2877
  static tela2 + #15, #2877
  static tela2 + #16, #2877
  static tela2 + #17, #2877
  static tela2 + #18, #2877
  static tela2 + #19, #2877
  static tela2 + #20, #2877
  static tela2 + #21, #2877
  static tela2 + #22, #2877
  static tela2 + #23, #2877
  static tela2 + #24, #2877
  static tela2 + #25, #2877
  static tela2 + #26, #2877
  static tela2 + #27, #2877
  static tela2 + #28, #2877
  static tela2 + #29, #2877
  static tela2 + #30, #2877
  static tela2 + #31, #2877
  static tela2 + #32, #2877
  static tela2 + #33, #2877
  static tela2 + #34, #2877
  static tela2 + #35, #2877
  static tela2 + #36, #2877
  static tela2 + #37, #2877
  static tela2 + #38, #2877
  static tela2 + #39, #2877

  ;Linha 1
  static tela2 + #40, #3389
  static tela2 + #41, #3967
  static tela2 + #42, #3967
  static tela2 + #43, #3967
  static tela2 + #44, #3967
  static tela2 + #45, #3967
  static tela2 + #46, #3967
  static tela2 + #47, #3967
  static tela2 + #48, #3967
  static tela2 + #49, #3967
  static tela2 + #50, #3967
  static tela2 + #51, #3967
  static tela2 + #52, #3967
  static tela2 + #53, #3967
  static tela2 + #54, #3967
  static tela2 + #55, #2836
  static tela2 + #56, #2836
  static tela2 + #57, #2836
  static tela2 + #58, #2836
  static tela2 + #59, #2836
  static tela2 + #60, #2836
  static tela2 + #61, #2836
  static tela2 + #62, #2836
  static tela2 + #63, #2836
  static tela2 + #64, #2836
  static tela2 + #65, #2836
  static tela2 + #66, #3967
  static tela2 + #67, #3967
  static tela2 + #68, #3967
  static tela2 + #69, #3967
  static tela2 + #70, #3967
  static tela2 + #71, #3967
  static tela2 + #72, #3967
  static tela2 + #73, #3967
  static tela2 + #74, #3967
  static tela2 + #75, #3967
  static tela2 + #76, #3967
  static tela2 + #77, #3967
  static tela2 + #78, #3967
  static tela2 + #79, #3389

  ;Linha 2
  static tela2 + #80, #3389
  static tela2 + #81, #3967
  static tela2 + #82, #3967
  static tela2 + #83, #3967
  static tela2 + #84, #3967
  static tela2 + #85, #3967
  static tela2 + #86, #3967
  static tela2 + #87, #3967
  static tela2 + #88, #3967
  static tela2 + #89, #3967
  static tela2 + #90, #3395
  static tela2 + #91, #3407
  static tela2 + #92, #3405
  static tela2 + #93, #3407
  static tela2 + #94, #3967
  static tela2 + #95, #3398
  static tela2 + #96, #3413
  static tela2 + #97, #3406
  static tela2 + #98, #3395
  static tela2 + #99, #3401
  static tela2 + #100, #3407
  static tela2 + #101, #3406
  static tela2 + #102, #3393
  static tela2 + #103, #3967
  static tela2 + #104, #3407
  static tela2 + #105, #3967
  static tela2 + #106, #3402
  static tela2 + #107, #3407
  static tela2 + #108, #3399
  static tela2 + #109, #3407
  static tela2 + #110, #3391
  static tela2 + #111, #3967
  static tela2 + #112, #3967
  static tela2 + #113, #3967
  static tela2 + #114, #3967
  static tela2 + #115, #3967
  static tela2 + #116, #3967
  static tela2 + #117, #3967
  static tela2 + #118, #3967
  static tela2 + #119, #3389

  ;Linha 3
  static tela2 + #120, #3389
  static tela2 + #121, #3967
  static tela2 + #122, #3967
  static tela2 + #123, #3967
  static tela2 + #124, #3967
  static tela2 + #125, #3967
  static tela2 + #126, #3967
  static tela2 + #127, #3967
  static tela2 + #128, #3967
  static tela2 + #129, #3114
  static tela2 + #130, #3114
  static tela2 + #131, #3114
  static tela2 + #132, #3114
  static tela2 + #133, #3114
  static tela2 + #134, #3114
  static tela2 + #135, #3114
  static tela2 + #136, #3114
  static tela2 + #137, #3114
  static tela2 + #138, #3114
  static tela2 + #139, #3114
  static tela2 + #140, #3114
  static tela2 + #141, #3114
  static tela2 + #142, #3114
  static tela2 + #143, #3114
  static tela2 + #144, #3114
  static tela2 + #145, #3114
  static tela2 + #146, #3114
  static tela2 + #147, #3114
  static tela2 + #148, #3114
  static tela2 + #149, #3114
  static tela2 + #150, #3114
  static tela2 + #151, #3114
  static tela2 + #152, #3967
  static tela2 + #153, #3967
  static tela2 + #154, #3967
  static tela2 + #155, #3967
  static tela2 + #156, #3967
  static tela2 + #157, #3967
  static tela2 + #158, #3967
  static tela2 + #159, #3389

  ;Linha 4
  static tela2 + #160, #3389
  static tela2 + #161, #3967
  static tela2 + #162, #3967
  static tela2 + #163, #3967
  static tela2 + #164, #3967
  static tela2 + #165, #3967
  static tela2 + #166, #3967
  static tela2 + #167, #3967
  static tela2 + #168, #3967
  static tela2 + #169, #3967
  static tela2 + #170, #3967
  static tela2 + #171, #3967
  static tela2 + #172, #3967
  static tela2 + #173, #3967
  static tela2 + #174, #3967
  static tela2 + #175, #3967
  static tela2 + #176, #3967
  static tela2 + #177, #3967
  static tela2 + #178, #3967
  static tela2 + #179, #3967
  static tela2 + #180, #3967
  static tela2 + #181, #3967
  static tela2 + #182, #3967
  static tela2 + #183, #3967
  static tela2 + #184, #3967
  static tela2 + #185, #3967
  static tela2 + #186, #3967
  static tela2 + #187, #3967
  static tela2 + #188, #3967
  static tela2 + #189, #3967
  static tela2 + #190, #3967
  static tela2 + #191, #3097
  static tela2 + #192, #3967
  static tela2 + #193, #3967
  static tela2 + #194, #3967
  static tela2 + #195, #3967
  static tela2 + #196, #3967
  static tela2 + #197, #3967
  static tela2 + #198, #3967
  static tela2 + #199, #3389

  ;Linha 5
  static tela2 + #200, #3389
  static tela2 + #201, #3967
  static tela2 + #202, #3967
  static tela2 + #203, #3967
  static tela2 + #204, #3967
  static tela2 + #205, #3967
  static tela2 + #206, #3967
  static tela2 + #207, #3967
  static tela2 + #208, #3967
  static tela2 + #209, #3967
  static tela2 + #210, #3967
  static tela2 + #211, #3967
  static tela2 + #212, #3967
  static tela2 + #213, #3967
  static tela2 + #214, #3967
  static tela2 + #215, #3967
  static tela2 + #216, #3967
  static tela2 + #217, #3967
  static tela2 + #218, #3967
  static tela2 + #219, #3967
  static tela2 + #220, #3967
  static tela2 + #221, #3967
  static tela2 + #222, #3967
  static tela2 + #223, #3967
  static tela2 + #224, #3967
  static tela2 + #225, #3967
  static tela2 + #226, #3967
  static tela2 + #227, #3967
  static tela2 + #228, #3967
  static tela2 + #229, #3967
  static tela2 + #230, #3967
  static tela2 + #231, #3967
  static tela2 + #232, #3967
  static tela2 + #233, #3967
  static tela2 + #234, #3967
  static tela2 + #235, #3967
  static tela2 + #236, #3967
  static tela2 + #237, #3967
  static tela2 + #238, #3967
  static tela2 + #239, #3389

  ;Linha 6
  static tela2 + #240, #3389
  static tela2 + #241, #3967
  static tela2 + #242, #3967
  static tela2 + #243, #3967
  static tela2 + #244, #3967
  static tela2 + #245, #3967
  static tela2 + #246, #3967
  static tela2 + #247, #3967
  static tela2 + #248, #3967
  static tela2 + #249, #3967
  static tela2 + #250, #3967
  static tela2 + #251, #3967
  static tela2 + #252, #3967
  static tela2 + #253, #3967
  static tela2 + #254, #3967
  static tela2 + #255, #3967
  static tela2 + #256, #3967
  static tela2 + #257, #3967
  static tela2 + #258, #3967
  static tela2 + #259, #3967
  static tela2 + #260, #3967
  static tela2 + #261, #3967
  static tela2 + #262, #3967
  static tela2 + #263, #3967
  static tela2 + #264, #3967
  static tela2 + #265, #3967
  static tela2 + #266, #3967
  static tela2 + #267, #3967
  static tela2 + #268, #3967
  static tela2 + #269, #3967
  static tela2 + #270, #3967
  static tela2 + #271, #3967
  static tela2 + #272, #3967
  static tela2 + #273, #3967
  static tela2 + #274, #3967
  static tela2 + #275, #3967
  static tela2 + #276, #3967
  static tela2 + #277, #3967
  static tela2 + #278, #3967
  static tela2 + #279, #3389

  ;Linha 7
  static tela2 + #280, #3389
  static tela2 + #281, #2859
  static tela2 + #282, #65
  static tela2 + #283, #3967
  static tela2 + #284, #67
  static tela2 + #285, #65
  static tela2 + #286, #68
  static tela2 + #287, #65
  static tela2 + #288, #3967
  static tela2 + #289, #82
  static tela2 + #290, #79
  static tela2 + #291, #68
  static tela2 + #292, #65
  static tela2 + #293, #68
  static tela2 + #294, #65
  static tela2 + #295, #3967
  static tela2 + #296, #86
  static tela2 + #297, #67
  static tela2 + #298, #3967
  static tela2 + #299, #68
  static tela2 + #300, #69
  static tela2 + #301, #86
  static tela2 + #302, #69
  static tela2 + #303, #3967
  static tela2 + #304, #65
  static tela2 + #305, #68
  static tela2 + #306, #73
  static tela2 + #307, #86
  static tela2 + #308, #73
  static tela2 + #309, #78
  static tela2 + #310, #72
  static tela2 + #311, #65
  static tela2 + #312, #82
  static tela2 + #313, #3967
  static tela2 + #314, #65
  static tela2 + #315, #3967
  static tela2 + #316, #80
  static tela2 + #317, #65
  static tela2 + #318, #76
  static tela2 + #319, #3389

  ;Linha 8
  static tela2 + #320, #3389
  static tela2 + #321, #65
  static tela2 + #322, #86
  static tela2 + #323, #82
  static tela2 + #324, #65
  static tela2 + #325, #3967
  static tela2 + #326, #68
  static tela2 + #327, #65
  static tela2 + #328, #3967
  static tela2 + #329, #82
  static tela2 + #330, #79
  static tela2 + #331, #68
  static tela2 + #332, #65
  static tela2 + #333, #68
  static tela2 + #334, #65
  static tela2 + #335, #46
  static tela2 + #336, #3967
  static tela2 + #337, #3967
  static tela2 + #338, #3967
  static tela2 + #339, #3967
  static tela2 + #340, #3967
  static tela2 + #341, #3967
  static tela2 + #342, #3967
  static tela2 + #343, #3967
  static tela2 + #344, #3967
  static tela2 + #345, #3967
  static tela2 + #346, #3967
  static tela2 + #347, #3967
  static tela2 + #348, #3967
  static tela2 + #349, #3967
  static tela2 + #350, #3967
  static tela2 + #351, #3967
  static tela2 + #352, #3967
  static tela2 + #353, #3967
  static tela2 + #354, #3967
  static tela2 + #355, #3967
  static tela2 + #356, #3967
  static tela2 + #357, #3967
  static tela2 + #358, #3967
  static tela2 + #359, #3389

  ;Linha 9
  static tela2 + #360, #3389
  static tela2 + #361, #3967
  static tela2 + #362, #3967
  static tela2 + #363, #3967
  static tela2 + #364, #3967
  static tela2 + #365, #3967
  static tela2 + #366, #3967
  static tela2 + #367, #3967
  static tela2 + #368, #3967
  static tela2 + #369, #3967
  static tela2 + #370, #3967
  static tela2 + #371, #3967
  static tela2 + #372, #3967
  static tela2 + #373, #3967
  static tela2 + #374, #3967
  static tela2 + #375, #3967
  static tela2 + #376, #3967
  static tela2 + #377, #3967
  static tela2 + #378, #3967
  static tela2 + #379, #3967
  static tela2 + #380, #3967
  static tela2 + #381, #3967
  static tela2 + #382, #3967
  static tela2 + #383, #3967
  static tela2 + #384, #3967
  static tela2 + #385, #3967
  static tela2 + #386, #3967
  static tela2 + #387, #3967
  static tela2 + #388, #3967
  static tela2 + #389, #3967
  static tela2 + #390, #3967
  static tela2 + #391, #3967
  static tela2 + #392, #3967
  static tela2 + #393, #3967
  static tela2 + #394, #3967
  static tela2 + #395, #3967
  static tela2 + #396, #3967
  static tela2 + #397, #3967
  static tela2 + #398, #3967
  static tela2 + #399, #3389

  ;Linha 10
  static tela2 + #400, #3389
  static tela2 + #401, #3967
  static tela2 + #402, #3967
  static tela2 + #403, #3967
  static tela2 + #404, #3967
  static tela2 + #405, #3967
  static tela2 + #406, #3967
  static tela2 + #407, #3967
  static tela2 + #408, #6
  static tela2 + #409, #3967
  static tela2 + #410, #3967
  static tela2 + #411, #3967
  static tela2 + #412, #3967
  static tela2 + #413, #3967
  static tela2 + #414, #3967
  static tela2 + #415, #3967
  static tela2 + #416, #3967
  static tela2 + #417, #3967
  static tela2 + #418, #3967
  static tela2 + #419, #3967
  static tela2 + #420, #3967
  static tela2 + #421, #3967
  static tela2 + #422, #3967
  static tela2 + #423, #3967
  static tela2 + #424, #3967
  static tela2 + #425, #3967
  static tela2 + #426, #3967
  static tela2 + #427, #3967
  static tela2 + #428, #3967
  static tela2 + #429, #3967
  static tela2 + #430, #3967
  static tela2 + #431, #3967
  static tela2 + #432, #3967
  static tela2 + #433, #3967
  static tela2 + #434, #3967
  static tela2 + #435, #3967
  static tela2 + #436, #3967
  static tela2 + #437, #3967
  static tela2 + #438, #3967
  static tela2 + #439, #3389

  ;Linha 11
  static tela2 + #440, #3389
  static tela2 + #441, #2859
  static tela2 + #442, #84
  static tela2 + #443, #79
  static tela2 + #444, #68
  static tela2 + #445, #65
  static tela2 + #446, #83
  static tela2 + #447, #3967
  static tela2 + #448, #65
  static tela2 + #449, #83
  static tela2 + #450, #3967
  static tela2 + #451, #80
  static tela2 + #452, #65
  static tela2 + #453, #76
  static tela2 + #454, #65
  static tela2 + #455, #86
  static tela2 + #456, #82
  static tela2 + #457, #65
  static tela2 + #458, #83
  static tela2 + #459, #3967
  static tela2 + #460, #80
  static tela2 + #461, #79
  static tela2 + #462, #83
  static tela2 + #463, #83
  static tela2 + #464, #85
  static tela2 + #465, #69
  static tela2 + #466, #77
  static tela2 + #467, #3967
  static tela2 + #468, #53
  static tela2 + #469, #3967
  static tela2 + #470, #76
  static tela2 + #471, #69
  static tela2 + #472, #84
  static tela2 + #473, #82
  static tela2 + #474, #65
  static tela2 + #475, #83
  static tela2 + #476, #46
  static tela2 + #477, #3967
  static tela2 + #478, #3967
  static tela2 + #479, #3389

  ;Linha 12
  static tela2 + #480, #3389
  static tela2 + #481, #3967
  static tela2 + #482, #3967
  static tela2 + #483, #3967
  static tela2 + #484, #3967
  static tela2 + #485, #3967
  static tela2 + #486, #3967
  static tela2 + #487, #3967
  static tela2 + #488, #3967
  static tela2 + #489, #3967
  static tela2 + #490, #3967
  static tela2 + #491, #3967
  static tela2 + #492, #3967
  static tela2 + #493, #3967
  static tela2 + #494, #3967
  static tela2 + #495, #3967
  static tela2 + #496, #3967
  static tela2 + #497, #3967
  static tela2 + #498, #3967
  static tela2 + #499, #3967
  static tela2 + #500, #3967
  static tela2 + #501, #3967
  static tela2 + #502, #3967
  static tela2 + #503, #3967
  static tela2 + #504, #3967
  static tela2 + #505, #3967
  static tela2 + #506, #3967
  static tela2 + #507, #3967
  static tela2 + #508, #3967
  static tela2 + #509, #3967
  static tela2 + #510, #3967
  static tela2 + #511, #3967
  static tela2 + #512, #3967
  static tela2 + #513, #3967
  static tela2 + #514, #3967
  static tela2 + #515, #3967
  static tela2 + #516, #3967
  static tela2 + #517, #3967
  static tela2 + #518, #3967
  static tela2 + #519, #3389

  ;Linha 13
  static tela2 + #520, #3389
  static tela2 + #521, #3967
  static tela2 + #522, #3967
  static tela2 + #523, #3967
  static tela2 + #524, #3967
  static tela2 + #525, #3967
  static tela2 + #526, #3967
  static tela2 + #527, #3967
  static tela2 + #528, #3967
  static tela2 + #529, #3967
  static tela2 + #530, #3967
  static tela2 + #531, #3967
  static tela2 + #532, #3967
  static tela2 + #533, #3967
  static tela2 + #534, #3967
  static tela2 + #535, #3967
  static tela2 + #536, #3967
  static tela2 + #537, #3967
  static tela2 + #538, #3967
  static tela2 + #539, #3967
  static tela2 + #540, #3967
  static tela2 + #541, #3967
  static tela2 + #542, #3967
  static tela2 + #543, #3967
  static tela2 + #544, #3967
  static tela2 + #545, #3967
  static tela2 + #546, #3967
  static tela2 + #547, #3967
  static tela2 + #548, #3967
  static tela2 + #549, #3967
  static tela2 + #550, #3967
  static tela2 + #551, #3967
  static tela2 + #552, #3967
  static tela2 + #553, #3967
  static tela2 + #554, #3967
  static tela2 + #555, #3967
  static tela2 + #556, #3967
  static tela2 + #557, #3967
  static tela2 + #558, #3967
  static tela2 + #559, #3389

  ;Linha 14
  static tela2 + #560, #3389
  static tela2 + #561, #2859
  static tela2 + #562, #86
  static tela2 + #563, #67
  static tela2 + #564, #4
  static tela2 + #565, #84
  static tela2 + #566, #69
  static tela2 + #567, #77
  static tela2 + #568, #4
  static tela2 + #569, #56
  static tela2 + #570, #4
  static tela2 + #571, #84
  static tela2 + #572, #69
  static tela2 + #573, #78
  static tela2 + #574, #84
  static tela2 + #575, #65
  static tela2 + #576, #84
  static tela2 + #577, #73
  static tela2 + #578, #86
  static tela2 + #579, #65
  static tela2 + #580, #83
  static tela2 + #581, #3967
  static tela2 + #582, #65
  static tela2 + #583, #3967
  static tela2 + #584, #67
  static tela2 + #585, #65
  static tela2 + #586, #68
  static tela2 + #587, #65
  static tela2 + #588, #3967
  static tela2 + #589, #82
  static tela2 + #590, #79
  static tela2 + #591, #68
  static tela2 + #592, #65
  static tela2 + #593, #68
  static tela2 + #594, #65
  static tela2 + #595, #46
  static tela2 + #596, #3967
  static tela2 + #597, #3967
  static tela2 + #598, #3967
  static tela2 + #599, #3389

  ;Linha 15
  static tela2 + #600, #3389
  static tela2 + #601, #3967
  static tela2 + #602, #3967
  static tela2 + #603, #3967
  static tela2 + #604, #3967
  static tela2 + #605, #3967
  static tela2 + #606, #3967
  static tela2 + #607, #3967
  static tela2 + #608, #3967
  static tela2 + #609, #3967
  static tela2 + #610, #3967
  static tela2 + #611, #3967
  static tela2 + #612, #3967
  static tela2 + #613, #3967
  static tela2 + #614, #3967
  static tela2 + #615, #3967
  static tela2 + #616, #3967
  static tela2 + #617, #3967
  static tela2 + #618, #3967
  static tela2 + #619, #3967
  static tela2 + #620, #3967
  static tela2 + #621, #3967
  static tela2 + #622, #3967
  static tela2 + #623, #3967
  static tela2 + #624, #3967
  static tela2 + #625, #3967
  static tela2 + #626, #3967
  static tela2 + #627, #3967
  static tela2 + #628, #3967
  static tela2 + #629, #3967
  static tela2 + #630, #3967
  static tela2 + #631, #3967
  static tela2 + #632, #3967
  static tela2 + #633, #3967
  static tela2 + #634, #3967
  static tela2 + #635, #3967
  static tela2 + #636, #3967
  static tela2 + #637, #3967
  static tela2 + #638, #3967
  static tela2 + #639, #3389

  ;Linha 16
  static tela2 + #640, #3389
  static tela2 + #641, #3967
  static tela2 + #642, #3967
  static tela2 + #643, #3967
  static tela2 + #644, #3967
  static tela2 + #645, #3967
  static tela2 + #646, #3967
  static tela2 + #647, #3967
  static tela2 + #648, #3967
  static tela2 + #649, #3967
  static tela2 + #650, #3967
  static tela2 + #651, #3967
  static tela2 + #652, #3967
  static tela2 + #653, #3967
  static tela2 + #654, #3967
  static tela2 + #655, #3967
  static tela2 + #656, #3967
  static tela2 + #657, #3967
  static tela2 + #658, #3967
  static tela2 + #659, #3967
  static tela2 + #660, #3967
  static tela2 + #661, #3967
  static tela2 + #662, #15
  static tela2 + #663, #3967
  static tela2 + #664, #3967
  static tela2 + #665, #3967
  static tela2 + #666, #3967
  static tela2 + #667, #3967
  static tela2 + #668, #3967
  static tela2 + #669, #3967
  static tela2 + #670, #3967
  static tela2 + #671, #3967
  static tela2 + #672, #3967
  static tela2 + #673, #3967
  static tela2 + #674, #3967
  static tela2 + #675, #3967
  static tela2 + #676, #3967
  static tela2 + #677, #3967
  static tela2 + #678, #3967
  static tela2 + #679, #3389

  ;Linha 17
  static tela2 + #680, #3389
  static tela2 + #681, #2859
  static tela2 + #682, #65
  static tela2 + #683, #3967
  static tela2 + #684, #67
  static tela2 + #685, #65
  static tela2 + #686, #68
  static tela2 + #687, #65
  static tela2 + #688, #3967
  static tela2 + #689, #84
  static tela2 + #690, #69
  static tela2 + #691, #78
  static tela2 + #692, #84
  static tela2 + #693, #65
  static tela2 + #694, #84
  static tela2 + #695, #73
  static tela2 + #696, #86
  static tela2 + #697, #65
  static tela2 + #698, #3967
  static tela2 + #699, #83
  static tela2 + #700, #69
  static tela2 + #701, #82
  static tela2 + #702, #65
  static tela2 + #703, #79
  static tela2 + #704, #3967
  static tela2 + #705, #77
  static tela2 + #706, #79
  static tela2 + #707, #83
  static tela2 + #708, #84
  static tela2 + #709, #82
  static tela2 + #710, #65
  static tela2 + #711, #68
  static tela2 + #712, #65
  static tela2 + #713, #83
  static tela2 + #714, #3967
  static tela2 + #715, #65
  static tela2 + #716, #83
  static tela2 + #717, #3967
  static tela2 + #718, #3967
  static tela2 + #719, #3389

  ;Linha 18
  static tela2 + #720, #3389
  static tela2 + #721, #76
  static tela2 + #722, #69
  static tela2 + #723, #84
  static tela2 + #724, #82
  static tela2 + #725, #65
  static tela2 + #726, #83
  static tela2 + #727, #3967
  static tela2 + #728, #2640
  static tela2 + #729, #2642
  static tela2 + #730, #2629
  static tela2 + #731, #2643
  static tela2 + #732, #2629
  static tela2 + #733, #2638
  static tela2 + #734, #2644
  static tela2 + #735, #2629
  static tela2 + #736, #2643
  static tela2 + #737, #3967
  static tela2 + #738, #79
  static tela2 + #739, #85
  static tela2 + #740, #3967
  static tela2 + #741, #2382
  static tela2 + #742, #2369
  static tela2 + #743, #2383
  static tela2 + #744, #3967
  static tela2 + #745, #78
  static tela2 + #746, #65
  static tela2 + #747, #3967
  static tela2 + #748, #80
  static tela2 + #749, #65
  static tela2 + #750, #76
  static tela2 + #751, #65
  static tela2 + #752, #86
  static tela2 + #753, #82
  static tela2 + #754, #65
  static tela2 + #755, #46
  static tela2 + #756, #3967
  static tela2 + #757, #3967
  static tela2 + #758, #3967
  static tela2 + #759, #3389

  ;Linha 19
  static tela2 + #760, #3389
  static tela2 + #761, #3967
  static tela2 + #762, #3967
  static tela2 + #763, #3967
  static tela2 + #764, #3967
  static tela2 + #765, #3967
  static tela2 + #766, #3967
  static tela2 + #767, #3967
  static tela2 + #768, #3967
  static tela2 + #769, #2567
  static tela2 + #770, #3967
  static tela2 + #771, #3967
  static tela2 + #772, #3967
  static tela2 + #773, #3967
  static tela2 + #774, #3967
  static tela2 + #775, #3967
  static tela2 + #776, #3967
  static tela2 + #777, #3967
  static tela2 + #778, #3967
  static tela2 + #779, #3967
  static tela2 + #780, #3967
  static tela2 + #781, #3967
  static tela2 + #782, #3967
  static tela2 + #783, #3967
  static tela2 + #784, #3967
  static tela2 + #785, #3967
  static tela2 + #786, #3967
  static tela2 + #787, #3967
  static tela2 + #788, #3967
  static tela2 + #789, #3967
  static tela2 + #790, #3967
  static tela2 + #791, #3967
  static tela2 + #792, #3967
  static tela2 + #793, #3967
  static tela2 + #794, #3967
  static tela2 + #795, #3967
  static tela2 + #796, #3967
  static tela2 + #797, #3967
  static tela2 + #798, #3967
  static tela2 + #799, #3389

  ;Linha 20
  static tela2 + #800, #3389
  static tela2 + #801, #3967
  static tela2 + #802, #3967
  static tela2 + #803, #3967
  static tela2 + #804, #3967
  static tela2 + #805, #3967
  static tela2 + #806, #3967
  static tela2 + #807, #3967
  static tela2 + #808, #3967
  static tela2 + #809, #3967
  static tela2 + #810, #3967
  static tela2 + #811, #3967
  static tela2 + #812, #3967
  static tela2 + #813, #3967
  static tela2 + #814, #3967
  static tela2 + #815, #3967
  static tela2 + #816, #3967
  static tela2 + #817, #3967
  static tela2 + #818, #3967
  static tela2 + #819, #3967
  static tela2 + #820, #3967
  static tela2 + #821, #3967
  static tela2 + #822, #3967
  static tela2 + #823, #3967
  static tela2 + #824, #3967
  static tela2 + #825, #3967
  static tela2 + #826, #3967
  static tela2 + #827, #3967
  static tela2 + #828, #3967
  static tela2 + #829, #3967
  static tela2 + #830, #3967
  static tela2 + #831, #3967
  static tela2 + #832, #3967
  static tela2 + #833, #3967
  static tela2 + #834, #3967
  static tela2 + #835, #3967
  static tela2 + #836, #3967
  static tela2 + #837, #3967
  static tela2 + #838, #3967
  static tela2 + #839, #3389

  ;Linha 21
  static tela2 + #840, #3389
  static tela2 + #841, #3967
  static tela2 + #842, #3967
  static tela2 + #843, #3967
  static tela2 + #844, #3967
  static tela2 + #845, #3967
  static tela2 + #846, #3114
  static tela2 + #847, #3114
  static tela2 + #848, #3114
  static tela2 + #849, #3114
  static tela2 + #850, #3114
  static tela2 + #851, #3114
  static tela2 + #852, #3114
  static tela2 + #853, #3114
  static tela2 + #854, #3114
  static tela2 + #855, #3114
  static tela2 + #856, #3114
  static tela2 + #857, #3114
  static tela2 + #858, #3114
  static tela2 + #859, #3114
  static tela2 + #860, #3114
  static tela2 + #861, #3114
  static tela2 + #862, #3114
  static tela2 + #863, #3114
  static tela2 + #864, #3114
  static tela2 + #865, #3114
  static tela2 + #866, #3114
  static tela2 + #867, #3114
  static tela2 + #868, #3114
  static tela2 + #869, #3114
  static tela2 + #870, #3114
  static tela2 + #871, #3967
  static tela2 + #872, #3967
  static tela2 + #873, #3967
  static tela2 + #874, #3967
  static tela2 + #875, #3967
  static tela2 + #876, #3967
  static tela2 + #877, #3967
  static tela2 + #878, #3967
  static tela2 + #879, #3389

  ;Linha 22
  static tela2 + #880, #3389
  static tela2 + #881, #3967
  static tela2 + #882, #3967
  static tela2 + #883, #3967
  static tela2 + #884, #3967
  static tela2 + #885, #3967
  static tela2 + #886, #3114
  static tela2 + #887, #3967
  static tela2 + #888, #65
  static tela2 + #889, #80
  static tela2 + #890, #69
  static tela2 + #891, #82
  static tela2 + #892, #84
  static tela2 + #893, #69
  static tela2 + #894, #3967
  static tela2 + #895, #3390
  static tela2 + #896, #3376
  static tela2 + #897, #3388
  static tela2 + #898, #3967
  static tela2 + #899, #80
  static tela2 + #900, #65
  static tela2 + #901, #82
  static tela2 + #902, #65
  static tela2 + #903, #15
  static tela2 + #904, #86
  static tela2 + #905, #79
  static tela2 + #906, #76
  static tela2 + #907, #84
  static tela2 + #908, #65
  static tela2 + #909, #82
  static tela2 + #910, #3114
  static tela2 + #911, #3967
  static tela2 + #912, #3967
  static tela2 + #913, #3967
  static tela2 + #914, #3967
  static tela2 + #915, #3967
  static tela2 + #916, #3967
  static tela2 + #917, #3967
  static tela2 + #918, #3967
  static tela2 + #919, #3389

  ;Linha 23
  static tela2 + #920, #3389
  static tela2 + #921, #3967
  static tela2 + #922, #3967
  static tela2 + #923, #3967
  static tela2 + #924, #3967
  static tela2 + #925, #3967
  static tela2 + #926, #3114
  static tela2 + #927, #3967
  static tela2 + #928, #3967
  static tela2 + #929, #3967
  static tela2 + #930, #3967
  static tela2 + #931, #3967
  static tela2 + #932, #3967
  static tela2 + #933, #3967
  static tela2 + #934, #3967
  static tela2 + #935, #3967
  static tela2 + #936, #3967
  static tela2 + #937, #3967
  static tela2 + #938, #3967
  static tela2 + #939, #3967
  static tela2 + #940, #3967
  static tela2 + #941, #3967
  static tela2 + #942, #3967
  static tela2 + #943, #3967
  static tela2 + #944, #3967
  static tela2 + #945, #3967
  static tela2 + #946, #3967
  static tela2 + #947, #3967
  static tela2 + #948, #3967
  static tela2 + #949, #3967
  static tela2 + #950, #3114
  static tela2 + #951, #3967
  static tela2 + #952, #3967
  static tela2 + #953, #3967
  static tela2 + #954, #3967
  static tela2 + #955, #3967
  static tela2 + #956, #3967
  static tela2 + #957, #3967
  static tela2 + #958, #3967
  static tela2 + #959, #3389

  ;Linha 24
  static tela2 + #960, #3389
  static tela2 + #961, #3967
  static tela2 + #962, #3967
  static tela2 + #963, #3967
  static tela2 + #964, #3967
  static tela2 + #965, #3967
  static tela2 + #966, #3114
  static tela2 + #967, #3967
  static tela2 + #968, #3967
  static tela2 + #969, #3967
  static tela2 + #970, #3967
  static tela2 + #971, #3967
  static tela2 + #972, #3967
  static tela2 + #973, #3967
  static tela2 + #974, #11
  static tela2 + #975, #65
  static tela2 + #976, #79
  static tela2 + #977, #3967
  static tela2 + #978, #77
  static tela2 + #979, #69
  static tela2 + #980, #78
  static tela2 + #981, #85
  static tela2 + #982, #3967
  static tela2 + #983, #3967
  static tela2 + #984, #3967
  static tela2 + #985, #3967
  static tela2 + #986, #3967
  static tela2 + #987, #3967
  static tela2 + #988, #3967
  static tela2 + #989, #3967
  static tela2 + #990, #3114
  static tela2 + #991, #3967
  static tela2 + #992, #3967
  static tela2 + #993, #3967
  static tela2 + #994, #3967
  static tela2 + #995, #3967
  static tela2 + #996, #3967
  static tela2 + #997, #3967
  static tela2 + #998, #3967
  static tela2 + #999, #3389

  ;Linha 25
  static tela2 + #1000, #3389
  static tela2 + #1001, #3967
  static tela2 + #1002, #3967
  static tela2 + #1003, #3967
  static tela2 + #1004, #3967
  static tela2 + #1005, #3967
  static tela2 + #1006, #3114
  static tela2 + #1007, #3114
  static tela2 + #1008, #3114
  static tela2 + #1009, #3114
  static tela2 + #1010, #3114
  static tela2 + #1011, #3114
  static tela2 + #1012, #3114
  static tela2 + #1013, #3114
  static tela2 + #1014, #3114
  static tela2 + #1015, #3114
  static tela2 + #1016, #3114
  static tela2 + #1017, #3114
  static tela2 + #1018, #3114
  static tela2 + #1019, #3114
  static tela2 + #1020, #3114
  static tela2 + #1021, #3114
  static tela2 + #1022, #3114
  static tela2 + #1023, #3114
  static tela2 + #1024, #3114
  static tela2 + #1025, #3114
  static tela2 + #1026, #3114
  static tela2 + #1027, #3114
  static tela2 + #1028, #3114
  static tela2 + #1029, #3114
  static tela2 + #1030, #3114
  static tela2 + #1031, #3967
  static tela2 + #1032, #3967
  static tela2 + #1033, #3967
  static tela2 + #1034, #3967
  static tela2 + #1035, #3967
  static tela2 + #1036, #3967
  static tela2 + #1037, #3967
  static tela2 + #1038, #3967
  static tela2 + #1039, #3389

  ;Linha 26
  static tela2 + #1040, #3389
  static tela2 + #1041, #3967
  static tela2 + #1042, #3967
  static tela2 + #1043, #3967
  static tela2 + #1044, #3967
  static tela2 + #1045, #3967
  static tela2 + #1046, #3967
  static tela2 + #1047, #3967
  static tela2 + #1048, #3967
  static tela2 + #1049, #3967
  static tela2 + #1050, #3967
  static tela2 + #1051, #3967
  static tela2 + #1052, #3967
  static tela2 + #1053, #3967
  static tela2 + #1054, #3967
  static tela2 + #1055, #3967
  static tela2 + #1056, #3967
  static tela2 + #1057, #3967
  static tela2 + #1058, #3967
  static tela2 + #1059, #3967
  static tela2 + #1060, #3967
  static tela2 + #1061, #3967
  static tela2 + #1062, #3967
  static tela2 + #1063, #3967
  static tela2 + #1064, #3967
  static tela2 + #1065, #3967
  static tela2 + #1066, #3967
  static tela2 + #1067, #3967
  static tela2 + #1068, #3967
  static tela2 + #1069, #3967
  static tela2 + #1070, #3967
  static tela2 + #1071, #3967
  static tela2 + #1072, #3967
  static tela2 + #1073, #3967
  static tela2 + #1074, #3967
  static tela2 + #1075, #3967
  static tela2 + #1076, #3967
  static tela2 + #1077, #3967
  static tela2 + #1078, #3967
  static tela2 + #1079, #3389

  ;Linha 27
  static tela2 + #1080, #3389
  static tela2 + #1081, #3967
  static tela2 + #1082, #3967
  static tela2 + #1083, #3967
  static tela2 + #1084, #3967
  static tela2 + #1085, #3967
  static tela2 + #1086, #3967
  static tela2 + #1087, #3967
  static tela2 + #1088, #3967
  static tela2 + #1089, #3967
  static tela2 + #1090, #3967
  static tela2 + #1091, #3967
  static tela2 + #1092, #3967
  static tela2 + #1093, #3967
  static tela2 + #1094, #3967
  static tela2 + #1095, #3967
  static tela2 + #1096, #3967
  static tela2 + #1097, #3967
  static tela2 + #1098, #3967
  static tela2 + #1099, #3967
  static tela2 + #1100, #3967
  static tela2 + #1101, #3967
  static tela2 + #1102, #3967
  static tela2 + #1103, #3967
  static tela2 + #1104, #3967
  static tela2 + #1105, #3967
  static tela2 + #1106, #3967
  static tela2 + #1107, #3967
  static tela2 + #1108, #3967
  static tela2 + #1109, #3967
  static tela2 + #1110, #3967
  static tela2 + #1111, #3967
  static tela2 + #1112, #3967
  static tela2 + #1113, #3967
  static tela2 + #1114, #3967
  static tela2 + #1115, #3967
  static tela2 + #1116, #3967
  static tela2 + #1117, #3967
  static tela2 + #1118, #3967
  static tela2 + #1119, #3389

  ;Linha 28
  static tela2 + #1120, #3389
  static tela2 + #1121, #3967
  static tela2 + #1122, #3967
  static tela2 + #1123, #3967
  static tela2 + #1124, #2826
  static tela2 + #1125, #2826
  static tela2 + #1126, #2826
  static tela2 + #1127, #2826
  static tela2 + #1128, #2826
  static tela2 + #1129, #3967
  static tela2 + #1130, #3967
  static tela2 + #1131, #3967
  static tela2 + #1132, #3967
  static tela2 + #1133, #3967
  static tela2 + #1134, #3967
  static tela2 + #1135, #3967
  static tela2 + #1136, #3967
  static tela2 + #1137, #3967
  static tela2 + #1138, #3967
  static tela2 + #1139, #3967
  static tela2 + #1140, #3967
  static tela2 + #1141, #3967
  static tela2 + #1142, #3967
  static tela2 + #1143, #3967
  static tela2 + #1144, #3967
  static tela2 + #1145, #3967
  static tela2 + #1146, #3967
  static tela2 + #1147, #3967
  static tela2 + #1148, #3967
  static tela2 + #1149, #3967
  static tela2 + #1150, #3967
  static tela2 + #1151, #3967
  static tela2 + #1152, #3967
  static tela2 + #1153, #3967
  static tela2 + #1154, #3967
  static tela2 + #1155, #3967
  static tela2 + #1156, #3967
  static tela2 + #1157, #3967
  static tela2 + #1158, #3967
  static tela2 + #1159, #3389

  ;Linha 29
  static tela2 + #1160, #2877
  static tela2 + #1161, #2877
  static tela2 + #1162, #2877
  static tela2 + #1163, #2877
  static tela2 + #1164, #2877
  static tela2 + #1165, #2877
  static tela2 + #1166, #2877
  static tela2 + #1167, #2877
  static tela2 + #1168, #2877
  static tela2 + #1169, #2877
  static tela2 + #1170, #2877
  static tela2 + #1171, #2877
  static tela2 + #1172, #2877
  static tela2 + #1173, #2877
  static tela2 + #1174, #2877
  static tela2 + #1175, #2877
  static tela2 + #1176, #2877
  static tela2 + #1177, #2877
  static tela2 + #1178, #2877
  static tela2 + #1179, #2877
  static tela2 + #1180, #2877
  static tela2 + #1181, #2877
  static tela2 + #1182, #2877
  static tela2 + #1183, #2877
  static tela2 + #1184, #2877
  static tela2 + #1185, #2877
  static tela2 + #1186, #2877
  static tela2 + #1187, #2877
  static tela2 + #1188, #2877
  static tela2 + #1189, #2877
  static tela2 + #1190, #2877
  static tela2 + #1191, #2877
  static tela2 + #1192, #2877
  static tela2 + #1193, #2877
  static tela2 + #1194, #2877
  static tela2 + #1195, #2877
  static tela2 + #1196, #2877
  static tela2 + #1197, #2877
  static tela2 + #1198, #2877
  static tela2 + #1199, #2877
;----------------------------------
;Tela menu
  telainicio : var #1200
  ;Linha 0
  static telainicio + #0, #2877
  static telainicio + #1, #2877
  static telainicio + #2, #2877
  static telainicio + #3, #2877
  static telainicio + #4, #2877
  static telainicio + #5, #2877
  static telainicio + #6, #2877
  static telainicio + #7, #2877
  static telainicio + #8, #2877
  static telainicio + #9, #2877
  static telainicio + #10, #2877
  static telainicio + #11, #2877
  static telainicio + #12, #2877
  static telainicio + #13, #2877
  static telainicio + #14, #2877
  static telainicio + #15, #2877
  static telainicio + #16, #2877
  static telainicio + #17, #2877
  static telainicio + #18, #2877
  static telainicio + #19, #2877
  static telainicio + #20, #2877
  static telainicio + #21, #2877
  static telainicio + #22, #2877
  static telainicio + #23, #2877
  static telainicio + #24, #2877
  static telainicio + #25, #2877
  static telainicio + #26, #2877
  static telainicio + #27, #2877
  static telainicio + #28, #2877
  static telainicio + #29, #2877
  static telainicio + #30, #2877
  static telainicio + #31, #2877
  static telainicio + #32, #2877
  static telainicio + #33, #2877
  static telainicio + #34, #2877
  static telainicio + #35, #2877
  static telainicio + #36, #2877
  static telainicio + #37, #2877
  static telainicio + #38, #2877
  static telainicio + #39, #2877

  ;Linha 1
  static telainicio + #40, #3389
  static telainicio + #41, #127
  static telainicio + #42, #127
  static telainicio + #43, #127
  static telainicio + #44, #127
  static telainicio + #45, #127
  static telainicio + #46, #127
  static telainicio + #47, #127
  static telainicio + #48, #127
  static telainicio + #49, #127
  static telainicio + #50, #127
  static telainicio + #51, #127
  static telainicio + #52, #127
  static telainicio + #53, #127
  static telainicio + #54, #127
  static telainicio + #55, #127
  static telainicio + #56, #127
  static telainicio + #57, #127
  static telainicio + #58, #127
  static telainicio + #59, #127
  static telainicio + #60, #127
  static telainicio + #61, #127
  static telainicio + #62, #127
  static telainicio + #63, #127
  static telainicio + #64, #127
  static telainicio + #65, #127
  static telainicio + #66, #127
  static telainicio + #67, #127
  static telainicio + #68, #127
  static telainicio + #69, #127
  static telainicio + #70, #127
  static telainicio + #71, #127
  static telainicio + #72, #127
  static telainicio + #73, #127
  static telainicio + #74, #127
  static telainicio + #75, #127
  static telainicio + #76, #127
  static telainicio + #77, #127
  static telainicio + #78, #127
  static telainicio + #79, #3389

  ;Linha 2
  static telainicio + #80, #3389
  static telainicio + #81, #127
  static telainicio + #82, #127
  static telainicio + #83, #127
  static telainicio + #84, #127
  static telainicio + #85, #127
  static telainicio + #86, #127
  static telainicio + #87, #127
  static telainicio + #88, #127
  static telainicio + #89, #127
  static telainicio + #90, #127
  static telainicio + #91, #127
  static telainicio + #92, #127
  static telainicio + #93, #127
  static telainicio + #94, #127
  static telainicio + #95, #127
  static telainicio + #96, #127
  static telainicio + #97, #2822
  static telainicio + #98, #2822
  static telainicio + #99, #127
  static telainicio + #100, #127
  static telainicio + #101, #127
  static telainicio + #102, #2822
  static telainicio + #103, #2822
  static telainicio + #104, #127
  static telainicio + #105, #2822
  static telainicio + #106, #2822
  static telainicio + #107, #2822
  static telainicio + #108, #2822
  static telainicio + #109, #2822
  static telainicio + #110, #127
  static telainicio + #111, #127
  static telainicio + #112, #127
  static telainicio + #113, #127
  static telainicio + #114, #127
  static telainicio + #115, #127
  static telainicio + #116, #127
  static telainicio + #117, #127
  static telainicio + #118, #127
  static telainicio + #119, #3389

  ;Linha 3
  static telainicio + #120, #3389
  static telainicio + #121, #127
  static telainicio + #122, #127
  static telainicio + #123, #127
  static telainicio + #124, #2822
  static telainicio + #125, #2822
  static telainicio + #126, #2822
  static telainicio + #127, #2823
  static telainicio + #128, #2887
  static telainicio + #129, #2887
  static telainicio + #130, #2887
  static telainicio + #131, #2887
  static telainicio + #132, #2822
  static telainicio + #133, #2898
  static telainicio + #134, #2898
  static telainicio + #135, #2898
  static telainicio + #136, #2898
  static telainicio + #137, #2822
  static telainicio + #138, #2885
  static telainicio + #139, #2885
  static telainicio + #140, #2885
  static telainicio + #141, #2885
  static telainicio + #142, #2822
  static telainicio + #143, #2887
  static telainicio + #144, #2887
  static telainicio + #145, #2887
  static telainicio + #146, #2887
  static telainicio + #147, #2822
  static telainicio + #148, #2895
  static telainicio + #149, #2895
  static telainicio + #150, #2895
  static telainicio + #151, #2895
  static telainicio + #152, #127
  static telainicio + #153, #127
  static telainicio + #154, #127
  static telainicio + #155, #127
  static telainicio + #156, #127
  static telainicio + #157, #127
  static telainicio + #158, #127
  static telainicio + #159, #3389

  ;Linha 4
  static telainicio + #160, #3389
  static telainicio + #161, #127
  static telainicio + #162, #127
  static telainicio + #163, #127
  static telainicio + #164, #2822
  static telainicio + #165, #127
  static telainicio + #166, #2822
  static telainicio + #167, #127
  static telainicio + #168, #2887
  static telainicio + #169, #127
  static telainicio + #170, #127
  static telainicio + #171, #2822
  static telainicio + #172, #127
  static telainicio + #173, #2898
  static telainicio + #174, #2822
  static telainicio + #175, #2822
  static telainicio + #176, #2898
  static telainicio + #177, #2822
  static telainicio + #178, #2885
  static telainicio + #179, #127
  static telainicio + #180, #127
  static telainicio + #181, #2822
  static telainicio + #182, #2822
  static telainicio + #183, #2887
  static telainicio + #184, #2822
  static telainicio + #185, #127
  static telainicio + #186, #2822
  static telainicio + #187, #2822
  static telainicio + #188, #2895
  static telainicio + #189, #2822
  static telainicio + #190, #127
  static telainicio + #191, #2895
  static telainicio + #192, #127
  static telainicio + #193, #127
  static telainicio + #194, #127
  static telainicio + #195, #127
  static telainicio + #196, #127
  static telainicio + #197, #127
  static telainicio + #198, #127
  static telainicio + #199, #3389

  ;Linha 5
  static telainicio + #200, #3389
  static telainicio + #201, #127
  static telainicio + #202, #127
  static telainicio + #203, #127
  static telainicio + #204, #2822
  static telainicio + #205, #127
  static telainicio + #206, #2822
  static telainicio + #207, #2822
  static telainicio + #208, #2887
  static telainicio + #209, #2822
  static telainicio + #210, #2887
  static telainicio + #211, #2887
  static telainicio + #212, #2822
  static telainicio + #213, #2898
  static telainicio + #214, #2898
  static telainicio + #215, #2898
  static telainicio + #216, #2898
  static telainicio + #217, #2822
  static telainicio + #218, #2885
  static telainicio + #219, #2885
  static telainicio + #220, #2885
  static telainicio + #221, #2885
  static telainicio + #222, #2822
  static telainicio + #223, #2887
  static telainicio + #224, #2822
  static telainicio + #225, #2887
  static telainicio + #226, #2887
  static telainicio + #227, #2822
  static telainicio + #228, #2895
  static telainicio + #229, #2822
  static telainicio + #230, #127
  static telainicio + #231, #2895
  static telainicio + #232, #127
  static telainicio + #233, #127
  static telainicio + #234, #127
  static telainicio + #235, #127
  static telainicio + #236, #127
  static telainicio + #237, #127
  static telainicio + #238, #127
  static telainicio + #239, #3389

  ;Linha 6
  static telainicio + #240, #3389
  static telainicio + #241, #127
  static telainicio + #242, #127
  static telainicio + #243, #127
  static telainicio + #244, #2822
  static telainicio + #245, #127
  static telainicio + #246, #2822
  static telainicio + #247, #127
  static telainicio + #248, #2887
  static telainicio + #249, #2822
  static telainicio + #250, #127
  static telainicio + #251, #2887
  static telainicio + #252, #2822
  static telainicio + #253, #2898
  static telainicio + #254, #2822
  static telainicio + #255, #2898
  static telainicio + #256, #2822
  static telainicio + #257, #2822
  static telainicio + #258, #2885
  static telainicio + #259, #2822
  static telainicio + #260, #127
  static telainicio + #261, #2822
  static telainicio + #262, #2822
  static telainicio + #263, #2887
  static telainicio + #264, #2822
  static telainicio + #265, #127
  static telainicio + #266, #2887
  static telainicio + #267, #127
  static telainicio + #268, #2895
  static telainicio + #269, #2822
  static telainicio + #270, #127
  static telainicio + #271, #2895
  static telainicio + #272, #127
  static telainicio + #273, #127
  static telainicio + #274, #127
  static telainicio + #275, #127
  static telainicio + #276, #127
  static telainicio + #277, #127
  static telainicio + #278, #127
  static telainicio + #279, #3389

  ;Linha 7
  static telainicio + #280, #3389
  static telainicio + #281, #127
  static telainicio + #282, #127
  static telainicio + #283, #127
  static telainicio + #284, #2822
  static telainicio + #285, #2822
  static telainicio + #286, #2822
  static telainicio + #287, #2822
  static telainicio + #288, #2887
  static telainicio + #289, #2887
  static telainicio + #290, #2887
  static telainicio + #291, #2887
  static telainicio + #292, #2822
  static telainicio + #293, #2898
  static telainicio + #294, #2822
  static telainicio + #295, #2822
  static telainicio + #296, #2898
  static telainicio + #297, #2822
  static telainicio + #298, #2885
  static telainicio + #299, #2885
  static telainicio + #300, #2885
  static telainicio + #301, #2885
  static telainicio + #302, #2822
  static telainicio + #303, #2887
  static telainicio + #304, #2887
  static telainicio + #305, #2887
  static telainicio + #306, #2887
  static telainicio + #307, #2822
  static telainicio + #308, #2895
  static telainicio + #309, #2895
  static telainicio + #310, #2895
  static telainicio + #311, #2895
  static telainicio + #312, #127
  static telainicio + #313, #127
  static telainicio + #314, #127
  static telainicio + #315, #127
  static telainicio + #316, #127
  static telainicio + #317, #127
  static telainicio + #318, #127
  static telainicio + #319, #3389

  ;Linha 8
  static telainicio + #320, #3389
  static telainicio + #321, #127
  static telainicio + #322, #127
  static telainicio + #323, #127
  static telainicio + #324, #127
  static telainicio + #325, #127
  static telainicio + #326, #127
  static telainicio + #327, #127
  static telainicio + #328, #127
  static telainicio + #329, #127
  static telainicio + #330, #127
  static telainicio + #331, #127
  static telainicio + #332, #127
  static telainicio + #333, #127
  static telainicio + #334, #127
  static telainicio + #335, #127
  static telainicio + #336, #127
  static telainicio + #337, #3114
  static telainicio + #338, #127
  static telainicio + #339, #127
  static telainicio + #340, #127
  static telainicio + #341, #2822
  static telainicio + #342, #2822
  static telainicio + #343, #2822
  static telainicio + #344, #2822
  static telainicio + #345, #127
  static telainicio + #346, #127
  static telainicio + #347, #127
  static telainicio + #348, #127
  static telainicio + #349, #127
  static telainicio + #350, #127
  static telainicio + #351, #127
  static telainicio + #352, #127
  static telainicio + #353, #127
  static telainicio + #354, #127
  static telainicio + #355, #127
  static telainicio + #356, #127
  static telainicio + #357, #127
  static telainicio + #358, #127
  static telainicio + #359, #3389

  ;Linha 9
  static telainicio + #360, #3389
  static telainicio + #361, #127
  static telainicio + #362, #127
  static telainicio + #363, #127
  static telainicio + #364, #127
  static telainicio + #365, #127
  static telainicio + #366, #127
  static telainicio + #367, #127
  static telainicio + #368, #127
  static telainicio + #369, #127
  static telainicio + #370, #127
  static telainicio + #371, #127
  static telainicio + #372, #2898
  static telainicio + #373, #2898
  static telainicio + #374, #2898
  static telainicio + #375, #2898
  static telainicio + #376, #127
  static telainicio + #377, #2889
  static telainicio + #378, #127
  static telainicio + #379, #2881
  static telainicio + #380, #2881
  static telainicio + #381, #2881
  static telainicio + #382, #2881
  static telainicio + #383, #127
  static telainicio + #384, #2894
  static telainicio + #385, #127
  static telainicio + #386, #127
  static telainicio + #387, #127
  static telainicio + #388, #2894
  static telainicio + #389, #127
  static telainicio + #390, #127
  static telainicio + #391, #127
  static telainicio + #392, #127
  static telainicio + #393, #127
  static telainicio + #394, #127
  static telainicio + #395, #127
  static telainicio + #396, #127
  static telainicio + #397, #127
  static telainicio + #398, #127
  static telainicio + #399, #3389

  ;Linha 10
  static telainicio + #400, #3389
  static telainicio + #401, #127
  static telainicio + #402, #127
  static telainicio + #403, #127
  static telainicio + #404, #127
  static telainicio + #405, #127
  static telainicio + #406, #127
  static telainicio + #407, #127
  static telainicio + #408, #127
  static telainicio + #409, #127
  static telainicio + #410, #127
  static telainicio + #411, #127
  static telainicio + #412, #2898
  static telainicio + #413, #127
  static telainicio + #414, #127
  static telainicio + #415, #2898
  static telainicio + #416, #127
  static telainicio + #417, #2889
  static telainicio + #418, #127
  static telainicio + #419, #2881
  static telainicio + #420, #2831
  static telainicio + #421, #127
  static telainicio + #422, #2881
  static telainicio + #423, #127
  static telainicio + #424, #2894
  static telainicio + #425, #2894
  static telainicio + #426, #127
  static telainicio + #427, #127
  static telainicio + #428, #2894
  static telainicio + #429, #127
  static telainicio + #430, #127
  static telainicio + #431, #127
  static telainicio + #432, #127
  static telainicio + #433, #127
  static telainicio + #434, #127
  static telainicio + #435, #127
  static telainicio + #436, #127
  static telainicio + #437, #127
  static telainicio + #438, #127
  static telainicio + #439, #3389

  ;Linha 11
  static telainicio + #440, #3389
  static telainicio + #441, #127
  static telainicio + #442, #127
  static telainicio + #443, #127
  static telainicio + #444, #127
  static telainicio + #445, #127
  static telainicio + #446, #127
  static telainicio + #447, #127
  static telainicio + #448, #127
  static telainicio + #449, #127
  static telainicio + #450, #127
  static telainicio + #451, #127
  static telainicio + #452, #2898
  static telainicio + #453, #2898
  static telainicio + #454, #2898
  static telainicio + #455, #2898
  static telainicio + #456, #127
  static telainicio + #457, #2889
  static telainicio + #458, #127
  static telainicio + #459, #2881
  static telainicio + #460, #2881
  static telainicio + #461, #2881
  static telainicio + #462, #2881
  static telainicio + #463, #127
  static telainicio + #464, #2894
  static telainicio + #465, #127
  static telainicio + #466, #2894
  static telainicio + #467, #127
  static telainicio + #468, #2894
  static telainicio + #469, #127
  static telainicio + #470, #127
  static telainicio + #471, #127
  static telainicio + #472, #127
  static telainicio + #473, #127
  static telainicio + #474, #127
  static telainicio + #475, #127
  static telainicio + #476, #127
  static telainicio + #477, #127
  static telainicio + #478, #127
  static telainicio + #479, #3389

  ;Linha 12
  static telainicio + #480, #3389
  static telainicio + #481, #127
  static telainicio + #482, #127
  static telainicio + #483, #127
  static telainicio + #484, #127
  static telainicio + #485, #127
  static telainicio + #486, #127
  static telainicio + #487, #127
  static telainicio + #488, #127
  static telainicio + #489, #127
  static telainicio + #490, #127
  static telainicio + #491, #127
  static telainicio + #492, #2898
  static telainicio + #493, #127
  static telainicio + #494, #2898
  static telainicio + #495, #127
  static telainicio + #496, #127
  static telainicio + #497, #2889
  static telainicio + #498, #127
  static telainicio + #499, #2881
  static telainicio + #500, #127
  static telainicio + #501, #127
  static telainicio + #502, #2881
  static telainicio + #503, #127
  static telainicio + #504, #2894
  static telainicio + #505, #127
  static telainicio + #506, #127
  static telainicio + #507, #2894
  static telainicio + #508, #2894
  static telainicio + #509, #127
  static telainicio + #510, #127
  static telainicio + #511, #127
  static telainicio + #512, #127
  static telainicio + #513, #127
  static telainicio + #514, #127
  static telainicio + #515, #127
  static telainicio + #516, #127
  static telainicio + #517, #127
  static telainicio + #518, #127
  static telainicio + #519, #3389

  ;Linha 13
  static telainicio + #520, #3389
  static telainicio + #521, #127
  static telainicio + #522, #127
  static telainicio + #523, #127
  static telainicio + #524, #127
  static telainicio + #525, #127
  static telainicio + #526, #127
  static telainicio + #527, #127
  static telainicio + #528, #127
  static telainicio + #529, #127
  static telainicio + #530, #127
  static telainicio + #531, #127
  static telainicio + #532, #2898
  static telainicio + #533, #127
  static telainicio + #534, #127
  static telainicio + #535, #2898
  static telainicio + #536, #127
  static telainicio + #537, #2889
  static telainicio + #538, #127
  static telainicio + #539, #2881
  static telainicio + #540, #127
  static telainicio + #541, #127
  static telainicio + #542, #2881
  static telainicio + #543, #127
  static telainicio + #544, #2894
  static telainicio + #545, #127
  static telainicio + #546, #127
  static telainicio + #547, #127
  static telainicio + #548, #2894
  static telainicio + #549, #127
  static telainicio + #550, #127
  static telainicio + #551, #127
  static telainicio + #552, #127
  static telainicio + #553, #127
  static telainicio + #554, #127
  static telainicio + #555, #127
  static telainicio + #556, #127
  static telainicio + #557, #127
  static telainicio + #558, #127
  static telainicio + #559, #3389

  ;Linha 14
  static telainicio + #560, #3389
  static telainicio + #561, #127
  static telainicio + #562, #127
  static telainicio + #563, #127
  static telainicio + #564, #127
  static telainicio + #565, #127
  static telainicio + #566, #127
  static telainicio + #567, #127
  static telainicio + #568, #127
  static telainicio + #569, #127
  static telainicio + #570, #127
  static telainicio + #571, #127
  static telainicio + #572, #127
  static telainicio + #573, #127
  static telainicio + #574, #127
  static telainicio + #575, #127
  static telainicio + #576, #127
  static telainicio + #577, #127
  static telainicio + #578, #127
  static telainicio + #579, #127
  static telainicio + #580, #127
  static telainicio + #581, #127
  static telainicio + #582, #127
  static telainicio + #583, #127
  static telainicio + #584, #127
  static telainicio + #585, #127
  static telainicio + #586, #127
  static telainicio + #587, #127
  static telainicio + #588, #127
  static telainicio + #589, #127
  static telainicio + #590, #127
  static telainicio + #591, #127
  static telainicio + #592, #127
  static telainicio + #593, #127
  static telainicio + #594, #127
  static telainicio + #595, #127
  static telainicio + #596, #127
  static telainicio + #597, #127
  static telainicio + #598, #127
  static telainicio + #599, #3389

  ;Linha 15
  static telainicio + #600, #3389
  static telainicio + #601, #127
  static telainicio + #602, #127
  static telainicio + #603, #127
  static telainicio + #604, #127
  static telainicio + #605, #127
  static telainicio + #606, #127
  static telainicio + #607, #127
  static telainicio + #608, #127
  static telainicio + #609, #127
  static telainicio + #610, #2887
  static telainicio + #611, #2887
  static telainicio + #612, #2887
  static telainicio + #613, #2887
  static telainicio + #614, #127
  static telainicio + #615, #2881
  static telainicio + #616, #2881
  static telainicio + #617, #2881
  static telainicio + #618, #2881
  static telainicio + #619, #127
  static telainicio + #620, #2893
  static telainicio + #621, #127
  static telainicio + #622, #127
  static telainicio + #623, #127
  static telainicio + #624, #2893
  static telainicio + #625, #127
  static telainicio + #626, #2885
  static telainicio + #627, #2885
  static telainicio + #628, #2885
  static telainicio + #629, #2885
  static telainicio + #630, #127
  static telainicio + #631, #127
  static telainicio + #632, #127
  static telainicio + #633, #127
  static telainicio + #634, #127
  static telainicio + #635, #127
  static telainicio + #636, #127
  static telainicio + #637, #127
  static telainicio + #638, #127
  static telainicio + #639, #3389

  ;Linha 16
  static telainicio + #640, #3389
  static telainicio + #641, #127
  static telainicio + #642, #127
  static telainicio + #643, #127
  static telainicio + #644, #127
  static telainicio + #645, #127
  static telainicio + #646, #127
  static telainicio + #647, #127
  static telainicio + #648, #127
  static telainicio + #649, #127
  static telainicio + #650, #2887
  static telainicio + #651, #127
  static telainicio + #652, #127
  static telainicio + #653, #127
  static telainicio + #654, #127
  static telainicio + #655, #2881
  static telainicio + #656, #127
  static telainicio + #657, #127
  static telainicio + #658, #2881
  static telainicio + #659, #127
  static telainicio + #660, #2893
  static telainicio + #661, #2893
  static telainicio + #662, #127
  static telainicio + #663, #2893
  static telainicio + #664, #2893
  static telainicio + #665, #127
  static telainicio + #666, #2885
  static telainicio + #667, #127
  static telainicio + #668, #127
  static telainicio + #669, #127
  static telainicio + #670, #127
  static telainicio + #671, #127
  static telainicio + #672, #127
  static telainicio + #673, #127
  static telainicio + #674, #127
  static telainicio + #675, #127
  static telainicio + #676, #127
  static telainicio + #677, #127
  static telainicio + #678, #127
  static telainicio + #679, #3389

  ;Linha 17
  static telainicio + #680, #3389
  static telainicio + #681, #127
  static telainicio + #682, #127
  static telainicio + #683, #127
  static telainicio + #684, #127
  static telainicio + #685, #127
  static telainicio + #686, #127
  static telainicio + #687, #127
  static telainicio + #688, #127
  static telainicio + #689, #127
  static telainicio + #690, #2887
  static telainicio + #691, #127
  static telainicio + #692, #2887
  static telainicio + #693, #2887
  static telainicio + #694, #127
  static telainicio + #695, #2881
  static telainicio + #696, #2881
  static telainicio + #697, #2881
  static telainicio + #698, #2881
  static telainicio + #699, #127
  static telainicio + #700, #2893
  static telainicio + #701, #127
  static telainicio + #702, #2893
  static telainicio + #703, #127
  static telainicio + #704, #2893
  static telainicio + #705, #127
  static telainicio + #706, #2885
  static telainicio + #707, #2885
  static telainicio + #708, #2885
  static telainicio + #709, #2885
  static telainicio + #710, #127
  static telainicio + #711, #127
  static telainicio + #712, #127
  static telainicio + #713, #127
  static telainicio + #714, #127
  static telainicio + #715, #127
  static telainicio + #716, #127
  static telainicio + #717, #127
  static telainicio + #718, #127
  static telainicio + #719, #3389

  ;Linha 18
  static telainicio + #720, #3389
  static telainicio + #721, #127
  static telainicio + #722, #127
  static telainicio + #723, #127
  static telainicio + #724, #127
  static telainicio + #725, #127
  static telainicio + #726, #127
  static telainicio + #727, #127
  static telainicio + #728, #127
  static telainicio + #729, #127
  static telainicio + #730, #2887
  static telainicio + #731, #127
  static telainicio + #732, #127
  static telainicio + #733, #2887
  static telainicio + #734, #127
  static telainicio + #735, #2881
  static telainicio + #736, #127
  static telainicio + #737, #127
  static telainicio + #738, #2881
  static telainicio + #739, #127
  static telainicio + #740, #2893
  static telainicio + #741, #127
  static telainicio + #742, #127
  static telainicio + #743, #127
  static telainicio + #744, #2893
  static telainicio + #745, #127
  static telainicio + #746, #2885
  static telainicio + #747, #127
  static telainicio + #748, #127
  static telainicio + #749, #127
  static telainicio + #750, #127
  static telainicio + #751, #127
  static telainicio + #752, #127
  static telainicio + #753, #127
  static telainicio + #754, #127
  static telainicio + #755, #127
  static telainicio + #756, #127
  static telainicio + #757, #127
  static telainicio + #758, #127
  static telainicio + #759, #3389

  ;Linha 19
  static telainicio + #760, #3389
  static telainicio + #761, #127
  static telainicio + #762, #127
  static telainicio + #763, #127
  static telainicio + #764, #127
  static telainicio + #765, #127
  static telainicio + #766, #127
  static telainicio + #767, #127
  static telainicio + #768, #127
  static telainicio + #769, #127
  static telainicio + #770, #2887
  static telainicio + #771, #2887
  static telainicio + #772, #2887
  static telainicio + #773, #2887
  static telainicio + #774, #2828
  static telainicio + #775, #2881
  static telainicio + #776, #127
  static telainicio + #777, #127
  static telainicio + #778, #2881
  static telainicio + #779, #127
  static telainicio + #780, #2893
  static telainicio + #781, #127
  static telainicio + #782, #127
  static telainicio + #783, #127
  static telainicio + #784, #2893
  static telainicio + #785, #127
  static telainicio + #786, #2885
  static telainicio + #787, #2885
  static telainicio + #788, #2885
  static telainicio + #789, #2885
  static telainicio + #790, #127
  static telainicio + #791, #127
  static telainicio + #792, #127
  static telainicio + #793, #127
  static telainicio + #794, #127
  static telainicio + #795, #127
  static telainicio + #796, #127
  static telainicio + #797, #127
  static telainicio + #798, #127
  static telainicio + #799, #3389

  ;Linha 20
  static telainicio + #800, #3389
  static telainicio + #801, #127
  static telainicio + #802, #127
  static telainicio + #803, #127
  static telainicio + #804, #127
  static telainicio + #805, #127
  static telainicio + #806, #127
  static telainicio + #807, #127
  static telainicio + #808, #127
  static telainicio + #809, #127
  static telainicio + #810, #127
  static telainicio + #811, #127
  static telainicio + #812, #127
  static telainicio + #813, #127
  static telainicio + #814, #127
  static telainicio + #815, #127
  static telainicio + #816, #127
  static telainicio + #817, #127
  static telainicio + #818, #127
  static telainicio + #819, #127
  static telainicio + #820, #127
  static telainicio + #821, #127
  static telainicio + #822, #127
  static telainicio + #823, #127
  static telainicio + #824, #127
  static telainicio + #825, #127
  static telainicio + #826, #127
  static telainicio + #827, #127
  static telainicio + #828, #127
  static telainicio + #829, #127
  static telainicio + #830, #127
  static telainicio + #831, #127
  static telainicio + #832, #127
  static telainicio + #833, #127
  static telainicio + #834, #127
  static telainicio + #835, #127
  static telainicio + #836, #127
  static telainicio + #837, #127
  static telainicio + #838, #127
  static telainicio + #839, #3389

  ;Linha 21
  static telainicio + #840, #3389
  static telainicio + #841, #3114
  static telainicio + #842, #3114
  static telainicio + #843, #3114
  static telainicio + #844, #3114
  static telainicio + #845, #3114
  static telainicio + #846, #3114
  static telainicio + #847, #3114
  static telainicio + #848, #3114
  static telainicio + #849, #3114
  static telainicio + #850, #3114
  static telainicio + #851, #3114
  static telainicio + #852, #3114
  static telainicio + #853, #3114
  static telainicio + #854, #3114
  static telainicio + #855, #3114
  static telainicio + #856, #3114
  static telainicio + #857, #3114
  static telainicio + #858, #3114
  static telainicio + #859, #3114
  static telainicio + #860, #3114
  static telainicio + #861, #3114
  static telainicio + #862, #3114
  static telainicio + #863, #3114
  static telainicio + #864, #3114
  static telainicio + #865, #3114
  static telainicio + #866, #3114
  static telainicio + #867, #3114
  static telainicio + #868, #3114
  static telainicio + #869, #3114
  static telainicio + #870, #3114
  static telainicio + #871, #3114
  static telainicio + #872, #3114
  static telainicio + #873, #3114
  static telainicio + #874, #3114
  static telainicio + #875, #3114
  static telainicio + #876, #3114
  static telainicio + #877, #3114
  static telainicio + #878, #3114
  static telainicio + #879, #3389

  ;Linha 22
  static telainicio + #880, #3389
  static telainicio + #881, #127
  static telainicio + #882, #127
  static telainicio + #883, #127
  static telainicio + #884, #127
  static telainicio + #885, #127
  static telainicio + #886, #127
  static telainicio + #887, #65
  static telainicio + #888, #80
  static telainicio + #889, #69
  static telainicio + #890, #82
  static telainicio + #891, #84
  static telainicio + #892, #69
  static telainicio + #893, #127
  static telainicio + #894, #3390
  static telainicio + #895, #3397
  static telainicio + #896, #3406
  static telainicio + #897, #3412
  static telainicio + #898, #3397
  static telainicio + #899, #3410
  static telainicio + #900, #3388
  static telainicio + #901, #127
  static telainicio + #902, #80
  static telainicio + #903, #65
  static telainicio + #904, #82
  static telainicio + #905, #65
  static telainicio + #906, #127
  static telainicio + #907, #74
  static telainicio + #908, #79
  static telainicio + #909, #71
  static telainicio + #910, #65
  static telainicio + #911, #82
  static telainicio + #912, #127
  static telainicio + #913, #127
  static telainicio + #914, #127
  static telainicio + #915, #127
  static telainicio + #916, #127
  static telainicio + #917, #127
  static telainicio + #918, #127
  static telainicio + #919, #3389

  ;Linha 23
  static telainicio + #920, #3389
  static telainicio + #921, #127
  static telainicio + #922, #127
  static telainicio + #923, #127
  static telainicio + #924, #127
  static telainicio + #925, #127
  static telainicio + #926, #127
  static telainicio + #927, #127
  static telainicio + #928, #127
  static telainicio + #929, #127
  static telainicio + #930, #127
  static telainicio + #931, #127
  static telainicio + #932, #127
  static telainicio + #933, #127
  static telainicio + #934, #127
  static telainicio + #935, #127
  static telainicio + #936, #127
  static telainicio + #937, #127
  static telainicio + #938, #127
  static telainicio + #939, #127
  static telainicio + #940, #127
  static telainicio + #941, #127
  static telainicio + #942, #127
  static telainicio + #943, #127
  static telainicio + #944, #127
  static telainicio + #945, #127
  static telainicio + #946, #127
  static telainicio + #947, #127
  static telainicio + #948, #127
  static telainicio + #949, #127
  static telainicio + #950, #127
  static telainicio + #951, #127
  static telainicio + #952, #127
  static telainicio + #953, #127
  static telainicio + #954, #127
  static telainicio + #955, #127
  static telainicio + #956, #127
  static telainicio + #957, #127
  static telainicio + #958, #127
  static telainicio + #959, #3389

  ;Linha 24
  static telainicio + #960, #3389
  static telainicio + #961, #127
  static telainicio + #962, #127
  static telainicio + #963, #127
  static telainicio + #964, #127
  static telainicio + #965, #127
  static telainicio + #966, #127
  static telainicio + #967, #127
  static telainicio + #968, #127
  static telainicio + #969, #127
  static telainicio + #970, #127
  static telainicio + #971, #127
  static telainicio + #972, #127
  static telainicio + #973, #127
  static telainicio + #974, #127
  static telainicio + #975, #127
  static telainicio + #976, #127
  static telainicio + #977, #127
  static telainicio + #978, #127
  static telainicio + #979, #127
  static telainicio + #980, #127
  static telainicio + #981, #127
  static telainicio + #982, #127
  static telainicio + #983, #127
  static telainicio + #984, #127
  static telainicio + #985, #127
  static telainicio + #986, #127
  static telainicio + #987, #127
  static telainicio + #988, #127
  static telainicio + #989, #127
  static telainicio + #990, #127
  static telainicio + #991, #127
  static telainicio + #992, #127
  static telainicio + #993, #127
  static telainicio + #994, #127
  static telainicio + #995, #127
  static telainicio + #996, #127
  static telainicio + #997, #127
  static telainicio + #998, #127
  static telainicio + #999, #3389

  ;Linha 25
  static telainicio + #1000, #3389
  static telainicio + #1001, #127
  static telainicio + #1002, #65
  static telainicio + #1003, #80
  static telainicio + #1004, #69
  static telainicio + #1005, #82
  static telainicio + #1006, #84
  static telainicio + #1007, #69
  static telainicio + #1008, #127
  static telainicio + #1009, #3390
  static telainicio + #1010, #3377
  static telainicio + #1011, #3388
  static telainicio + #1012, #127
  static telainicio + #1013, #80
  static telainicio + #1014, #65
  static telainicio + #1015, #82
  static telainicio + #1016, #65
  static telainicio + #1017, #127
  static telainicio + #1018, #76
  static telainicio + #1019, #69
  static telainicio + #1020, #82
  static telainicio + #1021, #127
  static telainicio + #1022, #65
  static telainicio + #1023, #83
  static telainicio + #1024, #127
  static telainicio + #1025, #73
  static telainicio + #1026, #78
  static telainicio + #1027, #83
  static telainicio + #1028, #84
  static telainicio + #1029, #82
  static telainicio + #1030, #85
  static telainicio + #1031, #67
  static telainicio + #1032, #79
  static telainicio + #1033, #69
  static telainicio + #1034, #83
  static telainicio + #1035, #127
  static telainicio + #1036, #127
  static telainicio + #1037, #127
  static telainicio + #1038, #127
  static telainicio + #1039, #3389

  ;Linha 26
  static telainicio + #1040, #3389
  static telainicio + #1041, #3114
  static telainicio + #1042, #3114
  static telainicio + #1043, #3114
  static telainicio + #1044, #3114
  static telainicio + #1045, #3114
  static telainicio + #1046, #3114
  static telainicio + #1047, #3114
  static telainicio + #1048, #3114
  static telainicio + #1049, #3114
  static telainicio + #1050, #3114
  static telainicio + #1051, #3114
  static telainicio + #1052, #3114
  static telainicio + #1053, #3114
  static telainicio + #1054, #3114
  static telainicio + #1055, #3114
  static telainicio + #1056, #3114
  static telainicio + #1057, #3114
  static telainicio + #1058, #3114
  static telainicio + #1059, #3114
  static telainicio + #1060, #3114
  static telainicio + #1061, #3114
  static telainicio + #1062, #3114
  static telainicio + #1063, #3114
  static telainicio + #1064, #3114
  static telainicio + #1065, #3114
  static telainicio + #1066, #3114
  static telainicio + #1067, #3114
  static telainicio + #1068, #3114
  static telainicio + #1069, #3114
  static telainicio + #1070, #3114
  static telainicio + #1071, #3114
  static telainicio + #1072, #3114
  static telainicio + #1073, #3114
  static telainicio + #1074, #3114
  static telainicio + #1075, #3114
  static telainicio + #1076, #3114
  static telainicio + #1077, #3114
  static telainicio + #1078, #3114
  static telainicio + #1079, #3389

  ;Linha 27
  static telainicio + #1080, #3389
  static telainicio + #1081, #3078
  static telainicio + #1082, #3078
  static telainicio + #1083, #3078
  static telainicio + #1084, #3078
  static telainicio + #1085, #3078
  static telainicio + #1086, #3078
  static telainicio + #1087, #3078
  static telainicio + #1088, #3078
  static telainicio + #1089, #3078
  static telainicio + #1090, #3078
  static telainicio + #1091, #3078
  static telainicio + #1092, #3078
  static telainicio + #1093, #3078
  static telainicio + #1094, #3078
  static telainicio + #1095, #3078
  static telainicio + #1096, #3078
  static telainicio + #1097, #3078
  static telainicio + #1098, #3078
  static telainicio + #1099, #3078
  static telainicio + #1100, #3078
  static telainicio + #1101, #3078
  static telainicio + #1102, #3078
  static telainicio + #1103, #3078
  static telainicio + #1104, #3078
  static telainicio + #1105, #3078
  static telainicio + #1106, #3078
  static telainicio + #1107, #3078
  static telainicio + #1108, #3078
  static telainicio + #1109, #3078
  static telainicio + #1110, #3078
  static telainicio + #1111, #3078
  static telainicio + #1112, #3078
  static telainicio + #1113, #3078
  static telainicio + #1114, #3078
  static telainicio + #1115, #3078
  static telainicio + #1116, #3078
  static telainicio + #1117, #3078
  static telainicio + #1118, #3078
  static telainicio + #1119, #3389

  ;Linha 28
  static telainicio + #1120, #3389
  static telainicio + #1121, #3078
  static telainicio + #1122, #3078
  static telainicio + #1123, #3078
  static telainicio + #1124, #3078
  static telainicio + #1125, #3078
  static telainicio + #1126, #3078
  static telainicio + #1127, #3078
  static telainicio + #1128, #3078
  static telainicio + #1129, #3078
  static telainicio + #1130, #3078
  static telainicio + #1131, #3078
  static telainicio + #1132, #3078
  static telainicio + #1133, #3078
  static telainicio + #1134, #3078
  static telainicio + #1135, #3078
  static telainicio + #1136, #3078
  static telainicio + #1137, #3078
  static telainicio + #1138, #3078
  static telainicio + #1139, #3078
  static telainicio + #1140, #3078
  static telainicio + #1141, #3078
  static telainicio + #1142, #3078
  static telainicio + #1143, #3078
  static telainicio + #1144, #3078
  static telainicio + #1145, #3078
  static telainicio + #1146, #3078
  static telainicio + #1147, #3078
  static telainicio + #1148, #3078
  static telainicio + #1149, #3078
  static telainicio + #1150, #3078
  static telainicio + #1151, #3078
  static telainicio + #1152, #3078
  static telainicio + #1153, #3078
  static telainicio + #1154, #3078
  static telainicio + #1155, #3078
  static telainicio + #1156, #3078
  static telainicio + #1157, #3078
  static telainicio + #1158, #3078
  static telainicio + #1159, #3389

  ;Linha 29
  static telainicio + #1160, #2877
  static telainicio + #1161, #2877
  static telainicio + #1162, #2877
  static telainicio + #1163, #2877
  static telainicio + #1164, #2877
  static telainicio + #1165, #2877
  static telainicio + #1166, #2877
  static telainicio + #1167, #2877
  static telainicio + #1168, #2877
  static telainicio + #1169, #2877
  static telainicio + #1170, #2877
  static telainicio + #1171, #2877
  static telainicio + #1172, #2877
  static telainicio + #1173, #2877
  static telainicio + #1174, #2877
  static telainicio + #1175, #2877
  static telainicio + #1176, #2877
  static telainicio + #1177, #2877
  static telainicio + #1178, #2877
  static telainicio + #1179, #2877
  static telainicio + #1180, #2877
  static telainicio + #1181, #2877
  static telainicio + #1182, #2877
  static telainicio + #1183, #2877
  static telainicio + #1184, #2877
  static telainicio + #1185, #2877
  static telainicio + #1186, #2877
  static telainicio + #1187, #2877
  static telainicio + #1188, #2877
  static telainicio + #1189, #2877
  static telainicio + #1190, #2877
  static telainicio + #1191, #2877
  static telainicio + #1192, #2877
  static telainicio + #1193, #2877
  static telainicio + #1194, #2877
  static telainicio + #1195, #2877
  static telainicio + #1196, #2877
  static telainicio + #1197, #2877
  static telainicio + #1198, #2877
  static telainicio + #1199, #2877
;---------------------------------
;Tela antes do jogo
tela3 : var #1200
  ;Linha 0
  static tela3 + #0, #2877
  static tela3 + #1, #2877
  static tela3 + #2, #2877
  static tela3 + #3, #2877
  static tela3 + #4, #2877
  static tela3 + #5, #2877
  static tela3 + #6, #2877
  static tela3 + #7, #2877
  static tela3 + #8, #2877
  static tela3 + #9, #2877
  static tela3 + #10, #2877
  static tela3 + #11, #2877
  static tela3 + #12, #2877
  static tela3 + #13, #2877
  static tela3 + #14, #2877
  static tela3 + #15, #2877
  static tela3 + #16, #2877
  static tela3 + #17, #2877
  static tela3 + #18, #2877
  static tela3 + #19, #2877
  static tela3 + #20, #2877
  static tela3 + #21, #2877
  static tela3 + #22, #2877
  static tela3 + #23, #2877
  static tela3 + #24, #2877
  static tela3 + #25, #2877
  static tela3 + #26, #2877
  static tela3 + #27, #2877
  static tela3 + #28, #2877
  static tela3 + #29, #2877
  static tela3 + #30, #2877
  static tela3 + #31, #2877
  static tela3 + #32, #2877
  static tela3 + #33, #2877
  static tela3 + #34, #2877
  static tela3 + #35, #2877
  static tela3 + #36, #2877
  static tela3 + #37, #2877
  static tela3 + #38, #2877
  static tela3 + #39, #2877

  ;Linha 1
  static tela3 + #40, #3389
  static tela3 + #41, #127
  static tela3 + #42, #127
  static tela3 + #43, #127
  static tela3 + #44, #127
  static tela3 + #45, #127
  static tela3 + #46, #127
  static tela3 + #47, #127
  static tela3 + #48, #127
  static tela3 + #49, #127
  static tela3 + #50, #127
  static tela3 + #51, #127
  static tela3 + #52, #127
  static tela3 + #53, #127
  static tela3 + #54, #127
  static tela3 + #55, #127
  static tela3 + #56, #127
  static tela3 + #57, #127
  static tela3 + #58, #127
  static tela3 + #59, #127
  static tela3 + #60, #127
  static tela3 + #61, #127
  static tela3 + #62, #127
  static tela3 + #63, #127
  static tela3 + #64, #127
  static tela3 + #65, #127
  static tela3 + #66, #127
  static tela3 + #67, #127
  static tela3 + #68, #127
  static tela3 + #69, #127
  static tela3 + #70, #127
  static tela3 + #71, #127
  static tela3 + #72, #127
  static tela3 + #73, #127
  static tela3 + #74, #127
  static tela3 + #75, #127
  static tela3 + #76, #127
  static tela3 + #77, #127
  static tela3 + #78, #127
  static tela3 + #79, #3389

  ;Linha 2
  static tela3 + #80, #3389
  static tela3 + #81, #127
  static tela3 + #82, #127
  static tela3 + #83, #127
  static tela3 + #84, #127
  static tela3 + #85, #127
  static tela3 + #86, #127
  static tela3 + #87, #127
  static tela3 + #88, #127
  static tela3 + #89, #127
  static tela3 + #90, #127
  static tela3 + #91, #127
  static tela3 + #92, #127
  static tela3 + #93, #127
  static tela3 + #94, #127
  static tela3 + #95, #127
  static tela3 + #96, #127
  static tela3 + #97, #127
  static tela3 + #98, #127
  static tela3 + #99, #127
  static tela3 + #100, #127
  static tela3 + #101, #127
  static tela3 + #102, #127
  static tela3 + #103, #127
  static tela3 + #104, #127
  static tela3 + #105, #127
  static tela3 + #106, #127
  static tela3 + #107, #127
  static tela3 + #108, #127
  static tela3 + #109, #127
  static tela3 + #110, #127
  static tela3 + #111, #127
  static tela3 + #112, #127
  static tela3 + #113, #127
  static tela3 + #114, #127
  static tela3 + #115, #127
  static tela3 + #116, #127
  static tela3 + #117, #127
  static tela3 + #118, #127
  static tela3 + #119, #3389

  ;Linha 3
  static tela3 + #120, #3389
  static tela3 + #121, #127
  static tela3 + #122, #127
  static tela3 + #123, #65
  static tela3 + #124, #80
  static tela3 + #125, #69
  static tela3 + #126, #82
  static tela3 + #127, #84
  static tela3 + #128, #69
  static tela3 + #129, #127
  static tela3 + #130, #69
  static tela3 + #131, #83
  static tela3 + #132, #80
  static tela3 + #133, #65
  static tela3 + #134, #67
  static tela3 + #135, #79
  static tela3 + #136, #6
  static tela3 + #137, #80
  static tela3 + #138, #65
  static tela3 + #139, #82
  static tela3 + #140, #65
  static tela3 + #141, #127
  static tela3 + #142, #71
  static tela3 + #143, #69
  static tela3 + #144, #82
  static tela3 + #145, #65
  static tela3 + #146, #82
  static tela3 + #147, #127
  static tela3 + #148, #85
  static tela3 + #149, #77
  static tela3 + #150, #65
  static tela3 + #151, #127
  static tela3 + #152, #127
  static tela3 + #153, #127
  static tela3 + #154, #127
  static tela3 + #155, #127
  static tela3 + #156, #127
  static tela3 + #157, #127
  static tela3 + #158, #127
  static tela3 + #159, #3389

  ;Linha 4
  static tela3 + #160, #3389
  static tela3 + #161, #127
  static tela3 + #162, #127
  static tela3 + #163, #127
  static tela3 + #164, #127
  static tela3 + #165, #127
  static tela3 + #166, #127
  static tela3 + #167, #127
  static tela3 + #168, #127
  static tela3 + #169, #3114
  static tela3 + #170, #3114
  static tela3 + #171, #3114
  static tela3 + #172, #3114
  static tela3 + #173, #3114
  static tela3 + #174, #3114
  static tela3 + #175, #3114
  static tela3 + #176, #3114
  static tela3 + #177, #127
  static tela3 + #178, #127
  static tela3 + #179, #127
  static tela3 + #180, #127
  static tela3 + #181, #127
  static tela3 + #182, #127
  static tela3 + #183, #127
  static tela3 + #184, #127
  static tela3 + #185, #127
  static tela3 + #186, #127
  static tela3 + #187, #127
  static tela3 + #188, #127
  static tela3 + #189, #127
  static tela3 + #190, #127
  static tela3 + #191, #127
  static tela3 + #192, #127
  static tela3 + #193, #127
  static tela3 + #194, #127
  static tela3 + #195, #127
  static tela3 + #196, #127
  static tela3 + #197, #127
  static tela3 + #198, #127
  static tela3 + #199, #3389

  ;Linha 5
  static tela3 + #200, #3389
  static tela3 + #201, #127
  static tela3 + #202, #127
  static tela3 + #203, #127
  static tela3 + #204, #5
  static tela3 + #205, #5
  static tela3 + #206, #5
  static tela3 + #207, #80
  static tela3 + #208, #65
  static tela3 + #209, #76
  static tela3 + #210, #65
  static tela3 + #211, #86
  static tela3 + #212, #82
  static tela3 + #213, #65
  static tela3 + #214, #5
  static tela3 + #215, #65
  static tela3 + #216, #76
  static tela3 + #217, #69
  static tela3 + #218, #65
  static tela3 + #219, #84
  static tela3 + #220, #79
  static tela3 + #221, #82
  static tela3 + #222, #73
  static tela3 + #223, #65
  static tela3 + #224, #46
  static tela3 + #225, #46
  static tela3 + #226, #46
  static tela3 + #227, #127
  static tela3 + #228, #127
  static tela3 + #229, #127
  static tela3 + #230, #127
  static tela3 + #231, #127
  static tela3 + #232, #127
  static tela3 + #233, #127
  static tela3 + #234, #127
  static tela3 + #235, #127
  static tela3 + #236, #127
  static tela3 + #237, #127
  static tela3 + #238, #127
  static tela3 + #239, #3389

  ;Linha 6
  static tela3 + #240, #3389
  static tela3 + #241, #127
  static tela3 + #242, #127
  static tela3 + #243, #127
  static tela3 + #244, #127
  static tela3 + #245, #127
  static tela3 + #246, #127
  static tela3 + #247, #127
  static tela3 + #248, #127
  static tela3 + #249, #127
  static tela3 + #250, #127
  static tela3 + #251, #127
  static tela3 + #252, #127
  static tela3 + #253, #127
  static tela3 + #254, #127
  static tela3 + #255, #127
  static tela3 + #256, #127
  static tela3 + #257, #127
  static tela3 + #258, #127
  static tela3 + #259, #127
  static tela3 + #260, #127
  static tela3 + #261, #127
  static tela3 + #262, #127
  static tela3 + #263, #127
  static tela3 + #264, #127
  static tela3 + #265, #127
  static tela3 + #266, #11
  static tela3 + #267, #127
  static tela3 + #268, #127
  static tela3 + #269, #127
  static tela3 + #270, #127
  static tela3 + #271, #127
  static tela3 + #272, #127
  static tela3 + #273, #127
  static tela3 + #274, #127
  static tela3 + #275, #127
  static tela3 + #276, #127
  static tela3 + #277, #127
  static tela3 + #278, #127
  static tela3 + #279, #3389

  ;Linha 7
  static tela3 + #280, #3389
  static tela3 + #281, #127
  static tela3 + #282, #127
  static tela3 + #283, #127
  static tela3 + #284, #127
  static tela3 + #285, #127
  static tela3 + #286, #127
  static tela3 + #287, #127
  static tela3 + #288, #127
  static tela3 + #289, #127
  static tela3 + #290, #127
  static tela3 + #291, #127
  static tela3 + #292, #127
  static tela3 + #293, #127
  static tela3 + #294, #127
  static tela3 + #295, #127
  static tela3 + #296, #127
  static tela3 + #297, #127
  static tela3 + #298, #127
  static tela3 + #299, #127
  static tela3 + #300, #127
  static tela3 + #301, #127
  static tela3 + #302, #127
  static tela3 + #303, #127
  static tela3 + #304, #127
  static tela3 + #305, #127
  static tela3 + #306, #127
  static tela3 + #307, #127
  static tela3 + #308, #127
  static tela3 + #309, #127
  static tela3 + #310, #127
  static tela3 + #311, #127
  static tela3 + #312, #127
  static tela3 + #313, #127
  static tela3 + #314, #127
  static tela3 + #315, #127
  static tela3 + #316, #127
  static tela3 + #317, #127
  static tela3 + #318, #127
  static tela3 + #319, #3389

  ;Linha 8
  static tela3 + #320, #3389
  static tela3 + #321, #127
  static tela3 + #322, #127
  static tela3 + #323, #127
  static tela3 + #324, #127
  static tela3 + #325, #127
  static tela3 + #326, #127
  static tela3 + #327, #127
  static tela3 + #328, #127
  static tela3 + #329, #127
  static tela3 + #330, #127
  static tela3 + #331, #127
  static tela3 + #332, #127
  static tela3 + #333, #127
  static tela3 + #334, #127
  static tela3 + #335, #127
  static tela3 + #336, #127
  static tela3 + #337, #127
  static tela3 + #338, #127
  static tela3 + #339, #127
  static tela3 + #340, #127
  static tela3 + #341, #127
  static tela3 + #342, #127
  static tela3 + #343, #127
  static tela3 + #344, #127
  static tela3 + #345, #127
  static tela3 + #346, #127
  static tela3 + #347, #127
  static tela3 + #348, #127
  static tela3 + #349, #127
  static tela3 + #350, #127
  static tela3 + #351, #127
  static tela3 + #352, #127
  static tela3 + #353, #127
  static tela3 + #354, #127
  static tela3 + #355, #127
  static tela3 + #356, #127
  static tela3 + #357, #127
  static tela3 + #358, #127
  static tela3 + #359, #3389

  ;Linha 9
  static tela3 + #360, #3389
  static tela3 + #361, #3114
  static tela3 + #362, #3114
  static tela3 + #363, #3114
  static tela3 + #364, #3114
  static tela3 + #365, #3114
  static tela3 + #366, #3114
  static tela3 + #367, #3114
  static tela3 + #368, #3114
  static tela3 + #369, #3114
  static tela3 + #370, #3114
  static tela3 + #371, #3114
  static tela3 + #372, #3114
  static tela3 + #373, #3114
  static tela3 + #374, #3114
  static tela3 + #375, #3114
  static tela3 + #376, #3114
  static tela3 + #377, #3114
  static tela3 + #378, #3114
  static tela3 + #379, #3114
  static tela3 + #380, #3114
  static tela3 + #381, #3114
  static tela3 + #382, #3114
  static tela3 + #383, #3114
  static tela3 + #384, #3114
  static tela3 + #385, #3114
  static tela3 + #386, #3114
  static tela3 + #387, #3114
  static tela3 + #388, #3114
  static tela3 + #389, #3114
  static tela3 + #390, #3114
  static tela3 + #391, #3114
  static tela3 + #392, #3114
  static tela3 + #393, #3114
  static tela3 + #394, #3114
  static tela3 + #395, #3114
  static tela3 + #396, #3114
  static tela3 + #397, #3114
  static tela3 + #398, #3114
  static tela3 + #399, #3389

  ;Linha 10
  static tela3 + #400, #3389
  static tela3 + #401, #127
  static tela3 + #402, #127
  static tela3 + #403, #127
  static tela3 + #404, #127
  static tela3 + #405, #127
  static tela3 + #406, #127
  static tela3 + #407, #127
  static tela3 + #408, #127
  static tela3 + #409, #127
  static tela3 + #410, #127
  static tela3 + #411, #127
  static tela3 + #412, #127
  static tela3 + #413, #127
  static tela3 + #414, #127
  static tela3 + #415, #127
  static tela3 + #416, #127
  static tela3 + #417, #127
  static tela3 + #418, #127
  static tela3 + #419, #127
  static tela3 + #420, #127
  static tela3 + #421, #127
  static tela3 + #422, #127
  static tela3 + #423, #127
  static tela3 + #424, #127
  static tela3 + #425, #127
  static tela3 + #426, #127
  static tela3 + #427, #127
  static tela3 + #428, #127
  static tela3 + #429, #127
  static tela3 + #430, #127
  static tela3 + #431, #127
  static tela3 + #432, #127
  static tela3 + #433, #127
  static tela3 + #434, #127
  static tela3 + #435, #127
  static tela3 + #436, #127
  static tela3 + #437, #127
  static tela3 + #438, #127
  static tela3 + #439, #3389

  ;Linha 11
  static tela3 + #440, #3389
  static tela3 + #441, #127
  static tela3 + #442, #127
  static tela3 + #443, #3
  static tela3 + #444, #3
  static tela3 + #445, #3
  static tela3 + #446, #3
  static tela3 + #447, #3
  static tela3 + #448, #3
  static tela3 + #449, #3
  static tela3 + #450, #127
  static tela3 + #451, #127
  static tela3 + #452, #127
  static tela3 + #453, #127
  static tela3 + #454, #127
  static tela3 + #455, #127
  static tela3 + #456, #127
  static tela3 + #457, #127
  static tela3 + #458, #127
  static tela3 + #459, #127
  static tela3 + #460, #127
  static tela3 + #461, #127
  static tela3 + #462, #127
  static tela3 + #463, #127
  static tela3 + #464, #127
  static tela3 + #465, #127
  static tela3 + #466, #127
  static tela3 + #467, #127
  static tela3 + #468, #127
  static tela3 + #469, #127
  static tela3 + #470, #127
  static tela3 + #471, #127
  static tela3 + #472, #127
  static tela3 + #473, #127
  static tela3 + #474, #127
  static tela3 + #475, #127
  static tela3 + #476, #127
  static tela3 + #477, #127
  static tela3 + #478, #127
  static tela3 + #479, #3389

  ;Linha 12
  static tela3 + #480, #3389
  static tela3 + #481, #127
  static tela3 + #482, #127
  static tela3 + #483, #127
  static tela3 + #484, #3
  static tela3 + #485, #3
  static tela3 + #486, #3
  static tela3 + #487, #3
  static tela3 + #488, #127
  static tela3 + #489, #127
  static tela3 + #490, #127
  static tela3 + #491, #127
  static tela3 + #492, #127
  static tela3 + #493, #127
  static tela3 + #494, #127
  static tela3 + #495, #127
  static tela3 + #496, #127
  static tela3 + #497, #127
  static tela3 + #498, #127
  static tela3 + #499, #127
  static tela3 + #500, #127
  static tela3 + #501, #127
  static tela3 + #502, #127
  static tela3 + #503, #127
  static tela3 + #504, #127
  static tela3 + #505, #127
  static tela3 + #506, #127
  static tela3 + #507, #127
  static tela3 + #508, #127
  static tela3 + #509, #127
  static tela3 + #510, #127
  static tela3 + #511, #127
  static tela3 + #512, #127
  static tela3 + #513, #127
  static tela3 + #514, #127
  static tela3 + #515, #127
  static tela3 + #516, #127
  static tela3 + #517, #127
  static tela3 + #518, #127
  static tela3 + #519, #3389

  ;Linha 13
  static tela3 + #520, #3389
  static tela3 + #521, #127
  static tela3 + #522, #127
  static tela3 + #523, #2399
  static tela3 + #524, #2399
  static tela3 + #525, #2399
  static tela3 + #526, #2399
  static tela3 + #527, #2399
  static tela3 + #528, #127
  static tela3 + #529, #65
  static tela3 + #530, #127
  static tela3 + #531, #80
  static tela3 + #532, #65
  static tela3 + #533, #76
  static tela3 + #534, #65
  static tela3 + #535, #86
  static tela3 + #536, #82
  static tela3 + #537, #65
  static tela3 + #538, #127
  static tela3 + #539, #78
  static tela3 + #540, #65
  static tela3 + #541, #79
  static tela3 + #542, #127
  static tela3 + #543, #84
  static tela3 + #544, #69
  static tela3 + #545, #77
  static tela3 + #546, #127
  static tela3 + #547, #69
  static tela3 + #548, #83
  static tela3 + #549, #83
  static tela3 + #550, #65
  static tela3 + #551, #127
  static tela3 + #552, #76
  static tela3 + #553, #69
  static tela3 + #554, #84
  static tela3 + #555, #82
  static tela3 + #556, #65
  static tela3 + #557, #127
  static tela3 + #558, #127
  static tela3 + #559, #3389

  ;Linha 14
  static tela3 + #560, #3389
  static tela3 + #561, #127
  static tela3 + #562, #127
  static tela3 + #563, #127
  static tela3 + #564, #3
  static tela3 + #565, #3
  static tela3 + #566, #3
  static tela3 + #567, #3
  static tela3 + #568, #127
  static tela3 + #569, #127
  static tela3 + #570, #127
  static tela3 + #571, #127
  static tela3 + #572, #127
  static tela3 + #573, #127
  static tela3 + #574, #127
  static tela3 + #575, #127
  static tela3 + #576, #127
  static tela3 + #577, #127
  static tela3 + #578, #127
  static tela3 + #579, #127
  static tela3 + #580, #127
  static tela3 + #581, #127
  static tela3 + #582, #127
  static tela3 + #583, #127
  static tela3 + #584, #127
  static tela3 + #585, #127
  static tela3 + #586, #127
  static tela3 + #587, #127
  static tela3 + #588, #127
  static tela3 + #589, #127
  static tela3 + #590, #127
  static tela3 + #591, #127
  static tela3 + #592, #127
  static tela3 + #593, #127
  static tela3 + #594, #127
  static tela3 + #595, #127
  static tela3 + #596, #127
  static tela3 + #597, #127
  static tela3 + #598, #127
  static tela3 + #599, #3389

  ;Linha 15
  static tela3 + #600, #3389
  static tela3 + #601, #127
  static tela3 + #602, #127
  static tela3 + #603, #2911
  static tela3 + #604, #2911
  static tela3 + #605, #2911
  static tela3 + #606, #2911
  static tela3 + #607, #2911
  static tela3 + #608, #2569
  static tela3 + #609, #65
  static tela3 + #610, #127
  static tela3 + #611, #76
  static tela3 + #612, #69
  static tela3 + #613, #84
  static tela3 + #614, #82
  static tela3 + #615, #65
  static tela3 + #616, #127
  static tela3 + #617, #69
  static tela3 + #618, #83
  static tela3 + #619, #84
  static tela3 + #620, #65
  static tela3 + #621, #127
  static tela3 + #622, #78
  static tela3 + #623, #79
  static tela3 + #624, #127
  static tela3 + #625, #69
  static tela3 + #626, #83
  static tela3 + #627, #80
  static tela3 + #628, #65
  static tela3 + #629, #67
  static tela3 + #630, #79
  static tela3 + #631, #20
  static tela3 + #632, #69
  static tela3 + #633, #82
  static tela3 + #634, #82
  static tela3 + #635, #65
  static tela3 + #636, #68
  static tela3 + #637, #79
  static tela3 + #638, #127
  static tela3 + #639, #3389

  ;Linha 16
  static tela3 + #640, #3389
  static tela3 + #641, #127
  static tela3 + #642, #127
  static tela3 + #643, #127
  static tela3 + #644, #127
  static tela3 + #645, #127
  static tela3 + #646, #127
  static tela3 + #647, #127
  static tela3 + #648, #127
  static tela3 + #649, #127
  static tela3 + #650, #127
  static tela3 + #651, #127
  static tela3 + #652, #127
  static tela3 + #653, #127
  static tela3 + #654, #127
  static tela3 + #655, #127
  static tela3 + #656, #127
  static tela3 + #657, #127
  static tela3 + #658, #127
  static tela3 + #659, #127
  static tela3 + #660, #127
  static tela3 + #661, #127
  static tela3 + #662, #127
  static tela3 + #663, #127
  static tela3 + #664, #127
  static tela3 + #665, #127
  static tela3 + #666, #127
  static tela3 + #667, #127
  static tela3 + #668, #127
  static tela3 + #669, #127
  static tela3 + #670, #127
  static tela3 + #671, #127
  static tela3 + #672, #127
  static tela3 + #673, #127
  static tela3 + #674, #127
  static tela3 + #675, #127
  static tela3 + #676, #127
  static tela3 + #677, #127
  static tela3 + #678, #127
  static tela3 + #679, #3389

  ;Linha 17
  static tela3 + #680, #3389
  static tela3 + #681, #127
  static tela3 + #682, #127
  static tela3 + #683, #2655
  static tela3 + #684, #2655
  static tela3 + #685, #2655
  static tela3 + #686, #2655
  static tela3 + #687, #2655
  static tela3 + #688, #127
  static tela3 + #689, #65
  static tela3 + #690, #127
  static tela3 + #691, #76
  static tela3 + #692, #69
  static tela3 + #693, #84
  static tela3 + #694, #82
  static tela3 + #695, #65
  static tela3 + #696, #127
  static tela3 + #697, #69
  static tela3 + #698, #83
  static tela3 + #699, #84
  static tela3 + #700, #65
  static tela3 + #701, #127
  static tela3 + #702, #78
  static tela3 + #703, #79
  static tela3 + #704, #127
  static tela3 + #705, #69
  static tela3 + #706, #83
  static tela3 + #707, #80
  static tela3 + #708, #65
  static tela3 + #709, #67
  static tela3 + #710, #79
  static tela3 + #711, #127
  static tela3 + #712, #67
  static tela3 + #713, #69
  static tela3 + #714, #82
  static tela3 + #715, #84
  static tela3 + #716, #79
  static tela3 + #717, #127
  static tela3 + #718, #127
  static tela3 + #719, #3389

  ;Linha 18
  static tela3 + #720, #3389
  static tela3 + #721, #127
  static tela3 + #722, #127
  static tela3 + #723, #127
  static tela3 + #724, #127
  static tela3 + #725, #127
  static tela3 + #726, #127
  static tela3 + #727, #127
  static tela3 + #728, #127
  static tela3 + #729, #127
  static tela3 + #730, #127
  static tela3 + #731, #127
  static tela3 + #732, #127
  static tela3 + #733, #127
  static tela3 + #734, #127
  static tela3 + #735, #127
  static tela3 + #736, #127
  static tela3 + #737, #127
  static tela3 + #738, #127
  static tela3 + #739, #127
  static tela3 + #740, #127
  static tela3 + #741, #127
  static tela3 + #742, #127
  static tela3 + #743, #127
  static tela3 + #744, #127
  static tela3 + #745, #127
  static tela3 + #746, #127
  static tela3 + #747, #127
  static tela3 + #748, #127
  static tela3 + #749, #127
  static tela3 + #750, #127
  static tela3 + #751, #127
  static tela3 + #752, #127
  static tela3 + #753, #127
  static tela3 + #754, #127
  static tela3 + #755, #127
  static tela3 + #756, #127
  static tela3 + #757, #127
  static tela3 + #758, #127
  static tela3 + #759, #3389

  ;Linha 19
  static tela3 + #760, #3389
  static tela3 + #761, #127
  static tela3 + #762, #127
  static tela3 + #763, #127
  static tela3 + #764, #127
  static tela3 + #765, #127
  static tela3 + #766, #127
  static tela3 + #767, #127
  static tela3 + #768, #127
  static tela3 + #769, #127
  static tela3 + #770, #127
  static tela3 + #771, #127
  static tela3 + #772, #127
  static tela3 + #773, #127
  static tela3 + #774, #127
  static tela3 + #775, #127
  static tela3 + #776, #127
  static tela3 + #777, #127
  static tela3 + #778, #127
  static tela3 + #779, #127
  static tela3 + #780, #127
  static tela3 + #781, #127
  static tela3 + #782, #127
  static tela3 + #783, #127
  static tela3 + #784, #127
  static tela3 + #785, #127
  static tela3 + #786, #127
  static tela3 + #787, #127
  static tela3 + #788, #127
  static tela3 + #789, #127
  static tela3 + #790, #127
  static tela3 + #791, #127
  static tela3 + #792, #127
  static tela3 + #793, #127
  static tela3 + #794, #127
  static tela3 + #795, #127
  static tela3 + #796, #127
  static tela3 + #797, #127
  static tela3 + #798, #127
  static tela3 + #799, #3389

  ;Linha 20
  static tela3 + #800, #3389
  static tela3 + #801, #127
  static tela3 + #802, #127
  static tela3 + #803, #127
  static tela3 + #804, #127
  static tela3 + #805, #127
  static tela3 + #806, #127
  static tela3 + #807, #127
  static tela3 + #808, #127
  static tela3 + #809, #127
  static tela3 + #810, #127
  static tela3 + #811, #127
  static tela3 + #812, #127
  static tela3 + #813, #127
  static tela3 + #814, #127
  static tela3 + #815, #127
  static tela3 + #816, #127
  static tela3 + #817, #127
  static tela3 + #818, #127
  static tela3 + #819, #127
  static tela3 + #820, #127
  static tela3 + #821, #127
  static tela3 + #822, #127
  static tela3 + #823, #127
  static tela3 + #824, #127
  static tela3 + #825, #127
  static tela3 + #826, #127
  static tela3 + #827, #127
  static tela3 + #828, #127
  static tela3 + #829, #127
  static tela3 + #830, #127
  static tela3 + #831, #127
  static tela3 + #832, #127
  static tela3 + #833, #127
  static tela3 + #834, #127
  static tela3 + #835, #127
  static tela3 + #836, #127
  static tela3 + #837, #127
  static tela3 + #838, #127
  static tela3 + #839, #3389

  ;Linha 21
  static tela3 + #840, #3389
  static tela3 + #841, #3114
  static tela3 + #842, #3114
  static tela3 + #843, #3114
  static tela3 + #844, #3114
  static tela3 + #845, #3114
  static tela3 + #846, #3114
  static tela3 + #847, #3114
  static tela3 + #848, #3114
  static tela3 + #849, #3114
  static tela3 + #850, #3114
  static tela3 + #851, #3114
  static tela3 + #852, #3114
  static tela3 + #853, #3114
  static tela3 + #854, #3114
  static tela3 + #855, #3114
  static tela3 + #856, #3114
  static tela3 + #857, #3114
  static tela3 + #858, #3114
  static tela3 + #859, #3114
  static tela3 + #860, #3114
  static tela3 + #861, #3114
  static tela3 + #862, #3114
  static tela3 + #863, #3114
  static tela3 + #864, #3114
  static tela3 + #865, #3114
  static tela3 + #866, #3114
  static tela3 + #867, #3114
  static tela3 + #868, #3114
  static tela3 + #869, #3114
  static tela3 + #870, #3114
  static tela3 + #871, #3114
  static tela3 + #872, #3114
  static tela3 + #873, #3114
  static tela3 + #874, #3114
  static tela3 + #875, #3114
  static tela3 + #876, #3114
  static tela3 + #877, #3114
  static tela3 + #878, #3114
  static tela3 + #879, #3389

  ;Linha 22
  static tela3 + #880, #3389
  static tela3 + #881, #127
  static tela3 + #882, #127
  static tela3 + #883, #127
  static tela3 + #884, #127
  static tela3 + #885, #127
  static tela3 + #886, #127
  static tela3 + #887, #127
  static tela3 + #888, #127
  static tela3 + #889, #127
  static tela3 + #890, #127
  static tela3 + #891, #127
  static tela3 + #892, #127
  static tela3 + #893, #127
  static tela3 + #894, #127
  static tela3 + #895, #127
  static tela3 + #896, #127
  static tela3 + #897, #127
  static tela3 + #898, #127
  static tela3 + #899, #127
  static tela3 + #900, #127
  static tela3 + #901, #127
  static tela3 + #902, #127
  static tela3 + #903, #127
  static tela3 + #904, #127
  static tela3 + #905, #127
  static tela3 + #906, #127
  static tela3 + #907, #127
  static tela3 + #908, #127
  static tela3 + #909, #127
  static tela3 + #910, #127
  static tela3 + #911, #127
  static tela3 + #912, #127
  static tela3 + #913, #127
  static tela3 + #914, #127
  static tela3 + #915, #127
  static tela3 + #916, #127
  static tela3 + #917, #127
  static tela3 + #918, #127
  static tela3 + #919, #3389

  ;Linha 23
  static tela3 + #920, #3389
  static tela3 + #921, #127
  static tela3 + #922, #127
  static tela3 + #923, #127
  static tela3 + #924, #127
  static tela3 + #925, #127
  static tela3 + #926, #127
  static tela3 + #927, #127
  static tela3 + #928, #127
  static tela3 + #929, #127
  static tela3 + #930, #127
  static tela3 + #931, #127
  static tela3 + #932, #127
  static tela3 + #933, #127
  static tela3 + #934, #127
  static tela3 + #935, #127
  static tela3 + #936, #127
  static tela3 + #937, #127
  static tela3 + #938, #127
  static tela3 + #939, #127
  static tela3 + #940, #127
  static tela3 + #941, #127
  static tela3 + #942, #127
  static tela3 + #943, #127
  static tela3 + #944, #127
  static tela3 + #945, #127
  static tela3 + #946, #127
  static tela3 + #947, #127
  static tela3 + #948, #127
  static tela3 + #949, #127
  static tela3 + #950, #127
  static tela3 + #951, #127
  static tela3 + #952, #127
  static tela3 + #953, #127
  static tela3 + #954, #127
  static tela3 + #955, #127
  static tela3 + #956, #127
  static tela3 + #957, #127
  static tela3 + #958, #127
  static tela3 + #959, #3389

  ;Linha 24
  static tela3 + #960, #3389
  static tela3 + #961, #127
  static tela3 + #962, #127
  static tela3 + #963, #127
  static tela3 + #964, #127
  static tela3 + #965, #127
  static tela3 + #966, #127
  static tela3 + #967, #127
  static tela3 + #968, #127
  static tela3 + #969, #127
  static tela3 + #970, #127
  static tela3 + #971, #127
  static tela3 + #972, #127
  static tela3 + #973, #127
  static tela3 + #974, #127
  static tela3 + #975, #127
  static tela3 + #976, #127
  static tela3 + #977, #127
  static tela3 + #978, #127
  static tela3 + #979, #127
  static tela3 + #980, #127
  static tela3 + #981, #127
  static tela3 + #982, #127
  static tela3 + #983, #127
  static tela3 + #984, #127
  static tela3 + #985, #127
  static tela3 + #986, #127
  static tela3 + #987, #127
  static tela3 + #988, #127
  static tela3 + #989, #127
  static tela3 + #990, #127
  static tela3 + #991, #127
  static tela3 + #992, #127
  static tela3 + #993, #127
  static tela3 + #994, #127
  static tela3 + #995, #127
  static tela3 + #996, #127
  static tela3 + #997, #127
  static tela3 + #998, #127
  static tela3 + #999, #3389

  ;Linha 25
  static tela3 + #1000, #3389
  static tela3 + #1001, #127
  static tela3 + #1002, #127
  static tela3 + #1003, #127
  static tela3 + #1004, #127
  static tela3 + #1005, #127
  static tela3 + #1006, #127
  static tela3 + #1007, #127
  static tela3 + #1008, #127
  static tela3 + #1009, #127
  static tela3 + #1010, #127
  static tela3 + #1011, #127
  static tela3 + #1012, #127
  static tela3 + #1013, #127
  static tela3 + #1014, #127
  static tela3 + #1015, #127
  static tela3 + #1016, #127
  static tela3 + #1017, #127
  static tela3 + #1018, #127
  static tela3 + #1019, #127
  static tela3 + #1020, #127
  static tela3 + #1021, #127
  static tela3 + #1022, #127
  static tela3 + #1023, #127
  static tela3 + #1024, #127
  static tela3 + #1025, #127
  static tela3 + #1026, #127
  static tela3 + #1027, #127
  static tela3 + #1028, #127
  static tela3 + #1029, #127
  static tela3 + #1030, #127
  static tela3 + #1031, #127
  static tela3 + #1032, #127
  static tela3 + #1033, #127
  static tela3 + #1034, #127
  static tela3 + #1035, #127
  static tela3 + #1036, #127
  static tela3 + #1037, #127
  static tela3 + #1038, #127
  static tela3 + #1039, #3389

  ;Linha 26
  static tela3 + #1040, #3389
  static tela3 + #1041, #127
  static tela3 + #1042, #127
  static tela3 + #1043, #127
  static tela3 + #1044, #127
  static tela3 + #1045, #127
  static tela3 + #1046, #127
  static tela3 + #1047, #127
  static tela3 + #1048, #127
  static tela3 + #1049, #127
  static tela3 + #1050, #127
  static tela3 + #1051, #127
  static tela3 + #1052, #127
  static tela3 + #1053, #127
  static tela3 + #1054, #127
  static tela3 + #1055, #127
  static tela3 + #1056, #127
  static tela3 + #1057, #127
  static tela3 + #1058, #127
  static tela3 + #1059, #127
  static tela3 + #1060, #127
  static tela3 + #1061, #127
  static tela3 + #1062, #127
  static tela3 + #1063, #127
  static tela3 + #1064, #127
  static tela3 + #1065, #127
  static tela3 + #1066, #127
  static tela3 + #1067, #127
  static tela3 + #1068, #127
  static tela3 + #1069, #127
  static tela3 + #1070, #127
  static tela3 + #1071, #127
  static tela3 + #1072, #127
  static tela3 + #1073, #127
  static tela3 + #1074, #127
  static tela3 + #1075, #127
  static tela3 + #1076, #127
  static tela3 + #1077, #127
  static tela3 + #1078, #127
  static tela3 + #1079, #3389

  ;Linha 27
  static tela3 + #1080, #3389
  static tela3 + #1081, #127
  static tela3 + #1082, #127
  static tela3 + #1083, #127
  static tela3 + #1084, #127
  static tela3 + #1085, #127
  static tela3 + #1086, #127
  static tela3 + #1087, #127
  static tela3 + #1088, #127
  static tela3 + #1089, #127
  static tela3 + #1090, #127
  static tela3 + #1091, #127
  static tela3 + #1092, #127
  static tela3 + #1093, #127
  static tela3 + #1094, #127
  static tela3 + #1095, #127
  static tela3 + #1096, #127
  static tela3 + #1097, #127
  static tela3 + #1098, #127
  static tela3 + #1099, #127
  static tela3 + #1100, #127
  static tela3 + #1101, #127
  static tela3 + #1102, #127
  static tela3 + #1103, #127
  static tela3 + #1104, #127
  static tela3 + #1105, #127
  static tela3 + #1106, #127
  static tela3 + #1107, #127
  static tela3 + #1108, #127
  static tela3 + #1109, #127
  static tela3 + #1110, #127
  static tela3 + #1111, #127
  static tela3 + #1112, #127
  static tela3 + #1113, #127
  static tela3 + #1114, #127
  static tela3 + #1115, #127
  static tela3 + #1116, #127
  static tela3 + #1117, #127
  static tela3 + #1118, #127
  static tela3 + #1119, #3389

  ;Linha 28
  static tela3 + #1120, #3389
  static tela3 + #1121, #127
  static tela3 + #1122, #127
  static tela3 + #1123, #127
  static tela3 + #1124, #127
  static tela3 + #1125, #127
  static tela3 + #1126, #127
  static tela3 + #1127, #127
  static tela3 + #1128, #127
  static tela3 + #1129, #127
  static tela3 + #1130, #127
  static tela3 + #1131, #127
  static tela3 + #1132, #127
  static tela3 + #1133, #127
  static tela3 + #1134, #127
  static tela3 + #1135, #127
  static tela3 + #1136, #127
  static tela3 + #1137, #127
  static tela3 + #1138, #127
  static tela3 + #1139, #127
  static tela3 + #1140, #127
  static tela3 + #1141, #127
  static tela3 + #1142, #127
  static tela3 + #1143, #127
  static tela3 + #1144, #127
  static tela3 + #1145, #127
  static tela3 + #1146, #127
  static tela3 + #1147, #127
  static tela3 + #1148, #127
  static tela3 + #1149, #127
  static tela3 + #1150, #127
  static tela3 + #1151, #127
  static tela3 + #1152, #127
  static tela3 + #1153, #127
  static tela3 + #1154, #127
  static tela3 + #1155, #127
  static tela3 + #1156, #127
  static tela3 + #1157, #127
  static tela3 + #1158, #127
  static tela3 + #1159, #3389

  ;Linha 29
  static tela3 + #1160, #2877
  static tela3 + #1161, #2877
  static tela3 + #1162, #2877
  static tela3 + #1163, #2877
  static tela3 + #1164, #2877
  static tela3 + #1165, #2877
  static tela3 + #1166, #2877
  static tela3 + #1167, #2877
  static tela3 + #1168, #2877
  static tela3 + #1169, #2877
  static tela3 + #1170, #2877
  static tela3 + #1171, #2877
  static tela3 + #1172, #2877
  static tela3 + #1173, #2877
  static tela3 + #1174, #2877
  static tela3 + #1175, #2877
  static tela3 + #1176, #2877
  static tela3 + #1177, #2877
  static tela3 + #1178, #2877
  static tela3 + #1179, #2877
  static tela3 + #1180, #2877
  static tela3 + #1181, #2877
  static tela3 + #1182, #2877
  static tela3 + #1183, #2877
  static tela3 + #1184, #2877
  static tela3 + #1185, #2877
  static tela3 + #1186, #2877
  static tela3 + #1187, #2877
  static tela3 + #1188, #2877
  static tela3 + #1189, #2877
  static tela3 + #1190, #2877
  static tela3 + #1191, #2877
  static tela3 + #1192, #2877
  static tela3 + #1193, #2877
  static tela3 + #1194, #2877
  static tela3 + #1195, #2877
  static tela3 + #1196, #2877
  static tela3 + #1197, #2877
  static tela3 + #1198, #2877
  static tela3 + #1199, #2877
