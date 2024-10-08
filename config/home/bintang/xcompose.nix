{
  # Nah don't do this. Some apps don't read the environment variable. Just one file in your home directory won't hurt you
  # home.sessionVariables.XCOMPOSEFILE = "$XDG_CONFIG_HOME/XCompose";
  # home.file.".config/XCompose".source = ./XCompose;
  home.file.".XCompose".text = ''
    # Taken from https://raw.githubusercontent.com/kragen/xcompose/master/dotXCompose
    include "%L"

    # Coming from languages that heavily use reduplication I tend to use this a lot
    <Multi_key> <2> <2>		: "²"	twosuperior

    # System's XCompose does not define vowels with macron
    <Multi_key> <equal> <A>          : "Ā"    U0100    # LATIN CAPITAL LETTER A WITH MACRON
    <Multi_key> <equal> <a>          : "ā"    U0101    # LATIN SMALL LETTER A WITH MACRON
    <Multi_key> <equal> <E>          : "Ē"    U0112    # LATIN CAPITAL LETTER E WITH MACRON
    <Multi_key> <equal> <e>          : "ē"    U0113    # LATIN SMALL LETTER E WITH MACRON
    <Multi_key> <equal> <I>          : "Ī"    U012A    # LATIN CAPITAL LETTER I WITH MACRON
    <Multi_key> <equal> <i>          : "ī"    U012B    # LATIN SMALL LETTER I WITH MACRON
    <Multi_key> <equal> <O>          : "Ō"    U014C    # LATIN CAPITAL LETTER O WITH MACRON
    <Multi_key> <equal> <o>          : "ō"    U014D    # LATIN SMALL LETTER O WITH MACRON
    <Multi_key> <equal> <U>          : "Ū"    U016A    # LATIN CAPITAL LETTER U WITH MACRON
    <Multi_key> <equal> <u>          : "ū"    U016B    # LATIN SMALL LETTER U WITH MACRON

    # Greek glyphs
    <Multi_key> <asterisk> <a> : "α"	U03B1		# GREEK SMALL LETTER ALPHA
    <Multi_key> <asterisk> <b> : "β"	U03B2		# GREEK SMALL LETTER BETA
    <Multi_key> <asterisk> <c> : "ψ"	U03C8		# GREEK SMALL LETTER PSI
    <Multi_key> <asterisk> <d> : "δ"	U03B4		# GREEK SMALL LETTER DELTA
    <Multi_key> <asterisk> <e> : "ε"	U03B5		# GREEK SMALL LETTER EPSILON
    <Multi_key> <asterisk> <f> : "φ"	U03C6		# GREEK SMALL LETTER PHI
    <Multi_key> <asterisk> <g> : "γ"	U03B3		# GREEK SMALL LETTER GAMMA
    <Multi_key> <asterisk> <h> : "η"	U03B7		# GREEK SMALL LETTER ΕΤΑ
    <Multi_key> <asterisk> <i> : "ι"	U03B9		# GREEK SMALL LETTER ΙΟΤΑ
    <Multi_key> <asterisk> <j> : "ξ"	U03BE		# GREEK SMALL LETTER XI
    <Multi_key> <asterisk> <k> : "κ"	U03BA		# GREEK SMALL LETTER KAPPA
    <Multi_key> <asterisk> <l> : "λ"	U03BB		# GREEK SMALL LETTER LAMBDA
    <Multi_key> <asterisk> <m> : "μ"	U03BC		# GREEK SMALL LETTER MU
    <Multi_key> <asterisk> <n> : "ν"	U03BD		# GREEK SMALL LETTER NU
    <Multi_key> <asterisk> <o> : "ο"	U03BF		# GREEK SMALL LETTER OMICRON
    <Multi_key> <asterisk> <p> : "π"	U03C0		# GREEK SMALL LETTER PI
    <Multi_key> <asterisk> <q> : ";"	U037E		# GREEK QUESTION MARK
    <Multi_key> <asterisk> <r> : "ρ"	U03C1		# GREEK SMALL LETTER RHO
    <Multi_key> <asterisk> <s> : "σ"	U03C3		# GREEK SMALL LETTER SIGMA
    <Multi_key> <asterisk> <t> : "τ"	U03C4		# GREEK SMALL LETTER TAU
    <Multi_key> <asterisk> <u> : "θ"	U03B8		# GREEK SMALL LETTER THETA
    <Multi_key> <asterisk> <v> : "ω"	U03C9		# GREEK SMALL LETTER OMEGA
    <Multi_key> <asterisk> <w> : "ς"	U03C2		# GREEK SMALL LETTER FINAL SIGMA
    <Multi_key> <asterisk> <x> : "χ"	U03C7		# GREEK SMALL LETTER CHI
    <Multi_key> <asterisk> <y> : "υ"	U03C5		# GREEK SMALL LETTER UPSILON
    <Multi_key> <asterisk> <z> : "ζ"	U03B6		# GREEK SMALL LETTER ZETA
    <Multi_key> <asterisk> <A> : "Α"	U0391		# GREEK CAPITAL LETTER ALPHA
    <Multi_key> <asterisk> <B> : "Β"	U0392		# GREEK CAPITAL LETTER BETA
    <Multi_key> <asterisk> <C> : "Ψ"	U03A8		# GREEK CAPITAL LETTER PSI
    <Multi_key> <asterisk> <D> : "Δ"	U0394		# GREEK CAPITAL LETTER DELTA
    <Multi_key> <asterisk> <E> : "Ε"	U0395		# GREEK CAPITAL LETTER EPSILON
    <Multi_key> <asterisk> <F> : "Φ"	U03A6		# GREEK CAPITAL LETTER PHI
    <Multi_key> <asterisk> <G> : "Γ"	U0393		# GREEK CAPITAL LETTER GAMMA
    <Multi_key> <asterisk> <H> : "Η"	U0397		# GREEK CAPITAL LETTER ΕΤΑ
    <Multi_key> <asterisk> <I> : "Ι"	U0399		# GREEK CAPITAL LETTER ΙΟΤΑ
    <Multi_key> <asterisk> <J> : "Ξ"	U039E		# GREEK CAPITAL LETTER XI
    <Multi_key> <asterisk> <K> : "Κ"	U039A		# GREEK CAPITAL LETTER KAPPA
    <Multi_key> <asterisk> <L> : "Λ"	U039B		# GREEK CAPITAL LETTER LAMBDA
    <Multi_key> <asterisk> <M> : "Μ"	U039C		# GREEK CAPITAL LETTER MU
    <Multi_key> <asterisk> <N> : "Ν"	U039D		# GREEK CAPITAL LETTER NU
    <Multi_key> <asterisk> <O> : "Ο"	U039F		# GREEK CAPITAL LETTER OMICRON
    <Multi_key> <asterisk> <P> : "Π"	U03A0		# GREEK CAPITAL LETTER PI
    <Multi_key> <asterisk> <R> : "Ρ"	U03A1		# GREEK CAPITAL LETTER RHO
    <Multi_key> <asterisk> <S> : "Σ"	U03A3		# GREEK CAPITAL LETTER SIGMA
    <Multi_key> <asterisk> <T> : "Τ"	U03A4		# GREEK CAPITAL LETTER TAU
    <Multi_key> <asterisk> <U> : "Θ"	U0398		# GREEK CAPITAL LETTER THETA
    <Multi_key> <asterisk> <V> : "Ω"	U03A9		# GREEK CAPITAL LETTER OMEGA
    <Multi_key> <asterisk> <X> : "Χ"	U03A7		# GREEK CAPITAL LETTER CHI
    <Multi_key> <asterisk> <Y> : "Υ"	U03A5		# GREEK CAPITAL LETTER UPSILON
    <Multi_key> <asterisk> <Z> : "Ζ"	U0396		# GREEK CAPITAL LETTER ZETA
    <Multi_key> <asterisk> <question> : "Ϛ"	U03DA	# GREEK LETTER STIGMA
    <Multi_key> <asterisk> <slash>	  : "ϛ"	U03DB	# GREEK SMALL LETTER STIGMA

    # Combining diacritic marks
    <Multi_key> <backslash> <grave>	: "̀"  U0300   # COMBINING GRAVE ACCENT
    <Multi_key> <backslash> <apostrophe>    : "́"   U0301   # COMBINING ACUTE ACCENT
    <Multi_key> <backslash> <asciicircum>    : "̂"   U0302   # COMBINING CIRCUMFLEX ACCENT
    <Multi_key> <backslash> <asciitilde>       : "̃"   U0303	# COMBINING TILDE
    <Multi_key> <backslash> <equal>		: "̄"	U0304	# COMBINING MACRON
    <Multi_key> <backslash> <backslash> <equal>		: "̅"	U0305	# COMBINING OVERLINE -- ???
    <Multi_key> <backslash> <U>		: "̆"	U0306	# COMBINING BREVE
    <Multi_key> <backslash> <period>	: "̇"	U0307	# COMBINING DOT ABOVE
    <Multi_key> <backslash> <quotedbl>	: "̈"	U0308	# COMBINING DIAERESIS
    <Multi_key> <backslash> <question>	: "̉"	U0309	# COMBINING HOOK ABOVE
    <Multi_key> <backslash> <0>   	       	: "̊"	U030a	# COMBINING RING ABOVE
    <Multi_key> <backslash> <backslash> <apostrophe>	: "̋"	U030b	# COMBINING DOUBLE ACUTE ACCENT -- ??
    <Multi_key> <backslash> <c>		: "̌"	U030c	# COMBINING CARON
    <Multi_key> <backslash> <bar>       	: "̍"	U030d	# COMBINING VERTICAL LINE ABOVE
    <Multi_key> <backslash> <2> <bar>	: "̎"	U030e	# COMBINING DOUBLE VERTICAL LINE ABOVE
    <Multi_key> <backslash> <2> <grave>	: "̏"	U030f	# COMBINING DOUBLE GRAVE ACCENT

    ### IPA ###
    # TODO: Extend this

    # Superscripts/Suprasegmentals
    <Multi_key> <bar> <apostrophe>		               : "ˈ"	U02C8		# PRIMARY STRESS
    <Multi_key> <bar> <comma>		                     : "ˌ"	U02CC		# SECONDARY STRESS
    <Multi_key> <asciicircum> <asciicircum> <h>      : "ʰ"  U02B0   # ASPIRATION
    <Multi_key> <asciicircum> <asciicircum> <H>      : "ʱ"  U02B1   # BREATHY
    <Multi_key> <asciicircum> <asciicircum> <j>      : "ʲ"  U02B2   # PALATALIZATION
    <Multi_key> <asciicircum> <asciicircum> <w>      : "ʷ"  U02B7   # LABIALIZATION
    <Multi_key> <asciicircum> <question> <period>	   : "ˀ"  U02C0   # GLOTTALIZATION
    <Multi_key> <asciicircum> <question> <parenleft> : "ˁ"  U02C1   # PHARYNGEALIZATION
    <Multi_key> <colon> <plus>  	      	           : "ː"	U02D0		# LONG VOWEL
    <Multi_key> <backslash> <asciicircum> <bar>	     : "̍"	  U030D		# SYLLABIC ABOVE
    <Multi_key> <backslash> <underscore> <bar>	     : "̩"	  U0329		# SYLLABIC BELOW
    <Multi_key> <backslash> <at> <i> <b>	           : "̯"	  U032F	  # NON SYLLABIC
    <Multi_key> <backslash> <2> <at> <U>             : "͜"   U035C   # TIE BAR BELOW
    <Multi_key> <backslash> <at> <0>	               : "̥"	  U0325	  # VOICELESS
    <Multi_key> <asciicircum> <x>                    : "̽"   U033D   # MID-CENTRALIZED
    # Nasals
    <Multi_key> <m> <comma>		    : "ɱ"   U0273     # VOICED LABIODENTAL NASAL
    <Multi_key> <n> <comma>		    : "ɳ"   U0273     # VOICED RETROFLEX NASAL
    <Multi_key> <n> <y>		        : "ɲ"   U0273     # VOICED PALATAL NASAL
    # Stops
    <Multi_key> <t> <comma>		        : "ʈ"   U0288     # VOICELESS RETROFLEX STOP
    <Multi_key> <d> <comma>		        : "ɖ"   U0256     # VOICED RETROFLEX STOP
    <Multi_key> <g> <y>			          : "ɟ"	  U025F		  # VOICELESS PALATAL STOP
    <Multi_key> <g> <g>		            : "ɡ"   U0261     # VOICED VELAR STOP
    <Multi_key> <question> <period>   : "ʔ"	  U0294		  # GLOTTAL STOP
    <Multi_key> <question> <minus>	  : "ʡ"	  U02A1		  # EPIGLOTTAL STOP
    <Multi_key> <b> <apostrophe>	    : "ɓ"   U0253     # VOICED BILABIAL IMPLOSIVE
    <Multi_key> <d> <apostrophe>	    : "ɗ"   U0257     # VOICED ALVEOLAR IMPLOSIVE
    <Multi_key> <g> <apostrophe>	    : "ɠ"   U0260     # VOICED VELAR IMPLOSIVE
    <Multi_key> <G> <apostrophe>	    : "ʛ"   U029B     # VOICED UVULAR IMPLOSIVE
    # Fricatives
    <Multi_key> <p> <h>			            : "ɸ"	  U0278		  # VOICELESS BILABIAL FRICATIVE
    <Multi_key> <b> <h>                 : "β"	  U03B2		  # VOICED BILABIAL FRICATIVE
    <Multi_key> <l> <h>   	            : "ɬ"	  U026C		  # VOICELESS ALVEOLAR LATERAL FRICATIVE
    <Multi_key> <l> <z>			            : "ɮ"	  U026E		  # VOICED ALVEOLAR LATERAL FRICATIVE
    <Multi_key> <s> <h>			            : "ʃ"	  U0283		  # VOICELESS POSTALVEOLAR FRICATIVE
    <Multi_key> <z> <h>			            : "ʒ"	  U0292		  # VOICED POSTALVEOLAR FRICATIVE
    <Multi_key> <s> <y>			            : "ɕ"	  U0283		  # VOICELESS ALVEOLOPALATAL FRICATIVE
    <Multi_key> <z> <y>			            : "ʑ"	  U0292		  # VOICED ALVEOLOPALATAL FRICATIVE
    <Multi_key> <s> <comma>		          : "ʂ"   U0282     # VOICELESS RETROFLEX FRICATIVE
    <Multi_key> <z> <comma>		          : "ʐ"   U0290     # VOICED RETROFLEX FRICATIVE
    <Multi_key> <g> <h>	     	          : "ɣ"   U0263     # VOICED VELAR FRICATIVE
    <Multi_key> <question> <parenleft>	: "ʕ"	  U0295		  # VOICED PHARYNGEAL FRICATIVE
    <Multi_key> <h> <apostrophe>	      : "ɦ"   U0266     # VOICED GLOTTAL FRICATIVE
    <Multi_key> <w> <w>			            : "ʍ"	  U028D		  # VOICELESS LABIOVELAR FRICATIVE
    # Taps/Flaps and Trills
    <Multi_key> <r> <d>                 : "ɾ"   U027E   # VOICED ALVEOLAR FLAP
    <Multi_key> <question> <braceleft>	: "ʢ"	  U02A2		# VOICED EPIGLOTTAL TRILL
    # Approximants
    <Multi_key> <r> <r>           : "ɹ"   U0279     # VOICED ALVEOLAR APPROXIMANT
    <Multi_key> <r> <comma>	      : "ɻ"   U026D     # VOICED RETROFLEX APPROXIMANT
    <Multi_key> <l> <comma>		    : "ɭ"   U026D     # VOICED RETROFLEX LATERAL APPROXIMANT
    <Multi_key> <y> <y>			      : "ʎ"	  U028E		  # VOICED PALATAL LATERAL APPROXIMANT
    <Multi_key> <h> <h>			      : "ɥ"	  U0265		  # VOICED LABIOPALATAL APPROXIMANT
    # Vowels
    <Multi_key> <i> <i>			                : "ɨ"	U026F		        # HIGH CENTRAL UNROUNDED VOWEL
    <Multi_key> <u> <i>			                : "ɯ"	U026F		        # HIGH BACK UNROUNDED VOWEL
    <Multi_key> <i> <h>                     : "ɪ"	U026A		        # NEAR HIGH FRONT UNROUNDED VOWEL
    <Multi_key> <y> <h>                     : "ʏ"	U026A		        # NEAR HIGH FRONT ROUNDED VOWEL
    <Multi_key> <u> <h>			                : "ʊ"	U028A		        # NEAR HIGH BACK ROUNDED VOWEL
    <Multi_key> <o> <g> <h>	      	        : "ɤ" U0264           # MID HIGH BACK UNROUNDED VOWEL
    <Multi_key> <e> <r>			                : "ɚ"	U025A		        # COLOURED MID CENTRAL VOWEL
    <Multi_key> <a> <y>   	                : "ɛ" U025B		        # MID LOW FRONT UNROUNDED VOWEL
    <Multi_key> <less> <e> <h>		          : "ɜ"	U025C		        # MID LOW CENTRAL UNROUNDED VOWEL
    <Multi_key> <BackSpace> <e> <h>		      : "ɜ"	U025C		        # MID LOW CENTRAL UNROUNDED VOWEL
    <Multi_key> <less> <e> <r>		          : "ɝ"	U025D		        # COLOURED MID LOW CENTRAL UNROUNDED VOWEL
    <Multi_key> <BackSpace> <e> <r>		      : "ɝ"	U025D		        # COLOURED MID LOW CENTRAL UNROUNDED VOWEL
    <Multi_key> <v> <v>                     : "ʌ" U028C           # MID LOW BACK UNROUNDED VOWEL
    <Multi_key> <a> <w>			                : "ɔ"	U0254		        # MID LOW BACK ROUNDED VOWEL
    <Multi_key> <a> <a>			                : "ɐ"	U0250		        # NEAR LOW CENTRAL UNROUNDED VOWEL
    <Multi_key> <a> <h>			                : "ɑ"	U0251		        # LOW BACK UNROUNDED VOWEL
    <Multi_key> <less> <a> <h>		          : "ɒ"	U0252		        # LOW BACK ROUNDED VOWEL
    <Multi_key> <BackSpace> <a> <h>		      : "ɒ"	U0252		        # LOW BACK ROUNDED VOWEL
  '';
}
